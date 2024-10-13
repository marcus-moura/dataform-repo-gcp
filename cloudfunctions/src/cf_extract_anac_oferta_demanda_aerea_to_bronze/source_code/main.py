from ingestion import AnacWebScraper, CloudStorage, BigQueryLoader, DataTransformer
from loguru import logger
from datetime import datetime
import pytz
import sys
import yaml
import os

# Configuração do log
logger.remove()
logger.add(sys.stdout, colorize=True, format="<green>{time:YYYY-MM-DD at HH:mm:ss}</green> | {level} | {message}")
logger.level("INFO")

# Configuração do fuso horário
tz = pytz.timezone('America/Sao_Paulo')
        
def load_yaml(name_file: str):
    """Load yaml file with args"""
    path_yaml = os.path.join(os.getcwd(), name_file)
    with open(path_yaml, 'r', encoding='utf-8') as y:
        config = yaml.load(y.read(), yaml.Loader)
    return config

def main(request=None):
    project_id = os.getenv("PROJECT_ID")
    bucket_name = os.getenv("BUCKET_LANDING")
    location = os.getenv("LOCATION")
    
    # Load configuration from YAML file
    config = load_yaml("config.yaml")
    extract_config = config["extract"]
    bq_config = config["bigquery"]

    # Instanciação das classes
    web_scraper = AnacWebScraper()
    cloud_storage = CloudStorage(bucket_target=bucket_name)
    transformer = DataTransformer()
    bigquery = BigQueryLoader(project_id, location)

    # Verifica se a tabela já existe no BigQuery para decidir entre carga incremental ou completa
    if bigquery.table_exists(bq_config['dataset_id'], bq_config['table_id']): 
        current_year = datetime.now().strftime("%Y")
        year_filters = [current_year]
        logger.info(f"Iniciando o processo de carga incremental com filtro {year_filters}.")
    else:
        # Se a tabela não existir, realiza uma carga completa
        logger.info("Iniciando o processo de carga completa.")
        year_filters = []
    
    # Extrai os links para os arquivos CSV da página da web
    csv_links = web_scraper.extract_csv_links(url=extract_config['url'], year_filters=year_filters)
    for csv_link in csv_links:
        cloud_storage.download_file_to_gcs(csv_link, source=extract_config['source'], subdir_name=extract_config['subdir_name'])

    blobs = list(cloud_storage.get_list_blobs(extract_config['source'], extract_config['subdir_name']))
    if not blobs:
        logger.warning("Nenhum arquivo encontrado para processar. O pipeline será encerrado!!")
        return
    
    if year_filters:
        # Deleta a partição de acordo com o filtro de ano
        bigquery.delete_partition(bq_config['dataset_id'], bq_config['table_id'], bq_config['partition_field'], partition_values=year_filters)

    for blob in blobs:
        # Transformação dos dados
        df = transformer.transform_csv_to_df(blob)

        # Carregamento dos dados no BigQuery
        bigquery.load_dataframe(dataframe=df, **bq_config)
        
        # Movendo o arquivo para o diretório de arquivos processados
        logger.info(f"Movendo o arquivo {blob.name} para o diretório de arquivos processados.")
        cloud_storage.move_blob_bucket(blob.name, delete_after=True)
        logger.success(f"Arquivo {blob.name} movido com sucesso!")
        
    return "Ingestão concluída com sucesso!!"