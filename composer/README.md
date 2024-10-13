# GrupoH+ Data-Composer(Airflow) <img src="images/cloud_composer.png" alt="composer logo" width="45"/>

## Sobre

Bem-vindo ao repositório do Cloud Composer no projeto GrupoH+ Data. Este repositório abriga DAGs, operadores e scripts relacionados ao orquestrador de fluxos de trabalho otimizados para a integração com os serviços do Google Cloud Platform (GCP).

O Cloud Composer é um serviço gerenciado no GCP projetado para orquestrar e automatizar fluxos de trabalho de dados. Baseado no Apache Airflow, solução open source, seu objetivo é facilitar a criação, gerenciamento, agendamento e monitoramento de pipelines de dados complexos, oferecendo uma interface gráfica e intuitiva.

Para aprofundar ainda mais o conhecimento sobre o Composer e Airflow, recomenda-se consultar a documentação oficial:

- [Documentação oficial Composer](https://cloud.google.com/composer/docs/concepts/overview?hl=pt-br)
- [Documentação oficial Airflow](https://airflow.apache.org/docs/apache-airflow/stable/index.html)

⚠️ IMPORTANTE ⚠️

Como boa prática adotada no projeto  GrupoH+ Data, o desenvolvimento deve seguir normas e padrões já estabelecidos. As diretrizes específicas ao Cloud Composer podem ser encontradas ao longo deste documento.

## Objetivo

Abaixo estão listados os principais objetivos do Composer como ferramenta no projeto Data.

### Função do Composer no Projeto

1. **Orquestração Eficiente**: Atuar como a principal ferramenta de orquestração, coordenação e execução de processos estruturados de dados. Estes processos são definidos através de [DAGs](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html);
2. **Integração entre Recursos**: Facilitar a integração harmoniosa entre os recursos do GCP através de operadores e conectores. Centralizando, de certa forma, as principais etapas de um processo estruturado de dados, como: extração, transformação e carga;
3. **Padronização e Reutilização**: Estabelecer um padrão para as cargas de trabalho através de DAGs modularizadas e templates.

## Organização do Repositório
A estrutura do repositório reflete a organização lógica e modular do projeto, seguindo as melhores práticas para facilitar o desenvolvimento, manutenção e colaboração. A hierarquia é a seguinte:

```bash
├── .github
│   └── workflows
│       └── ci-deploy-composer-dags.yaml
├── dags
│   ├── dag_file.py
├── plugins
│   ├── include...
│   │   ├── configs
│   │   |  ├── config.yaml
│   │   ├── template
│   │   |  ├── files.py
│   │   ├── sql
│   │   |  ├── files.sql
│   │   ├── utils.py
```
- `.github/workflows/`: Contém os scripts de CI/CD para automação do deploy das DAGs para o Bucket do Composer via GitHub Actions.
- `dags`: Contém os arquivos de Directed Acyclic Graphs (DAGs).
- `plugins`: Além de conter o arquivo de funções utilitárias `utils.py`, possui o(s) subdiretório(s):
    - `include`: Recursos reutilizáveis. 
        - `configs`: Definição de argumentos em formato .yaml específicos para cada DAG.
        - `template`: Definições de scripts python com templates de Dags reutilizáveis.
        - `sql`: Armazena arquivos sql para extração ou transformação de dados.

Esta mesma estrutura de organização é encontrada no bucket `bkt-ghm-composer-{env}`  presente no mesmo projeto do Composer.

# Uso

## Instalação e Configuração

Antes de iniciar o desenvolvimento, certifique-se de que os pré-requisitos foram atendidos e que o ambiente está devidamente configurado:

1. **Ambiente Composer**: Certifique-se de que está utilizando o ambiente do Cloud 
Composer 2 ou posterior, isso pode ser visualizado na UI do console. O ambiente é criado via script Terraform. Caso prefira entender o processo passo-a-passo ou precise criar o ambiente manualmente pelo console, consulte a [documentação oficial](https://cloud.google.com/composer/docs/composer-2/create-environments?hl=pt-br).


2. **Permissões Conta de Serviço**: Certifique-se de que a conta de serviço principal associada ao Composer tenha a role `composer.worker` e as permissões adequadas para execução das tarefas necessárias. Isso pode incluir permissões para acessar recursos como BigQuery, Cloud Storage, Functions, entre outros;

Estes pré-requisitos são fundamentais para estabelecer um ambiente funcional e seguro.ss

### **Instalação**

A implantação do Composer é feita através de scripts estruturados em `Terraform`. Para maiores detalhes, acesse os scripts [aqui](../infra-terraform).

Certifique-se de seguir cada etapa cuidadosamente para garantir uma implantação bem-sucedida do ambiente.

### **Configuração**

#### **Criação de variável de ambiente**

- Variável de Ambiente `ENV`: Defina a variável de ambiente `ENV` com o valor correspondente ao ambiente desejado, podendo ser `dev` (desenvolvimento) ou `prd` (produção). Esta variável é essencial para a correta configuração do ambiente. Consulte a [documentação](https://cloud.google.com/composer/docs/composer-2/set-environment-variables?hl=pt-br) para obter orientações sobre como criar variáveis de ambiente no Composer.

#### **Integração com Secret Manager**
O [Secret Manager](https://cloud.google.com/security/products/secret-manager) é uma ferramenta de armazenamento e gestão de segredos e credenciais.

Em utilização junto ao Composer, proporciona acesso confiável a informações sensíveis. Embora a integração entre o Composer e o Secret Manager já esteja estabelecida, é fundamental seguir determinados padrões na criação e utilização dos segredos a fim de garantir um ambiente organizado e seguro. Abaixo, são apresentadas algumas dessas boas práticas:

**1. Padrões de Nomenclatura**:

- **Variáveis**:
    - Utilize o prefixo **`sm-`** antes do nome descritivo da secret. E.g., **`sm-salesforce_token_api`**
- **Conexões:**
    - Utilize o prefixo **`sm-`** antes do nome descritivo da conexão. E.g., **`sm-sqlserver_url`**

**2. Permissionamento**

- Certifique-se que a conta de serviço principal do Composer, que pode ser encontrada na Console GCP, possua a permissão `Secret Manager Secret Accessor` no `IAM (Identity and Access Management)` do projeto `ghm-data-{env}`.

**Acesso na DAG**

Para acessar uma secret a partir de uma DAG, utilize o leitor de variáveis do Composer.

Por exemplo, para a secret ``sm-secret_filename``:
```python
from airflow.models.variable import Variable
file_name = Variable.get('secret_filename')
```

**⚠️ Observação ⚠️:**

Para informações mais detalhadas sobre a integração e instruções sobre como utilizar o Secret Manager com o Cloud Composer, consulte a [documentação oficial do fabricante](https://cloud.google.com/composer/docs/secret-manager?hl=pt-br). Este recurso fornecerá orientações específicas para garantir uma implementação adequada e segura.

## Normas e Padrões

### Padrões de Nomenclatura

Ao criar novas DAGs, é importante seguir padrões de nomenclatura a fim de facilitar a identificação e a manutenção das DAGs.

#### Dags Bronze e Silver
Para dags das zonas bronze e silver recomenda-se a seguinte estrutura de nome:

- lower case
- Separado por "_"
- Prefixo e placeholders: **dag_{tipo de origem}_{aplicacao}_{zona}_{contexto}**

Por exemplo: `dag_api_five9_brz_to_slv_esp0001`, `dag_api_five9_brz_esp0002`

#### Dags Gold
Para dags da zona gold recomenda-se a seguinte estrutura de nome:

- lower case
- Separado por "_"
- Prefixo e placeholders: **dag_pipeline_{zona}_{contexto}**

Por exemplo: `dag_pipeline_gold_etapa_conta`

#### Dags Controller
Para dag de controle, utilizada para acionar diversas dags recomenda-se a seguinte estrutura de nome:

- lower case
- Separado por "_"
- Prefixo e placeholders: **dag_controller_{tipo de origem}_{aplicacao}_{zona}**

Por exemplo: `dag_controller_oracle_tasy_cloud_brz_to_slv_agenda`
          
### Nome do Owner nas DAGs

Como boa prática, recomenda-se utilizar o nome do proprietário (owner) como parte integrante do nome da DAG, seguindo a estrutura estabelecida. Isso contribui para uma identificação clara e consistente das DAGs no ambiente.

Abaixo, encontra-se uma imagem ilustrativa demonstrando o uso desses padrões no ambiente do Composer:

![console airflow padroes](images/console_airflow_padroes.png)


### Documentação da DAG

Documente suas DAGS individualmente, dando uma visão geral sobre o seu propósito. Exemplo:

```python
doc_md_task = """
 ## DAG: API Instituto Dr. Osmar Bronze to Silver Profissional

### Descrição
Esta DAG executa uma Cloud Function que carrega dados na camada Bronze para uma tabela de profissional e para outra de profissional_diario e, em seguida, executa uma operação de merge desses dados com a camada Silver no BigQuery.
"""
#Define parâmetros da dag com os argumentos yaml
@dag(
    dag_id="dag_exemplo_doc",
    schedule=None,
    catchup=False,
    default_args=default_args,
    dagrun_timeout=timedelta(minutes=1),
    tags=["doc"],
    doc_md=doc_md_task
)
```

Abaixo uma ilustração do resultado da documentação no Console do Airflow:

![docmd Airflow](images/docmd_airflow.png)

### **Utilização de argumentos YAML**

Para a criação das DAGs, são empregados arquivos de argumentos YAML. Esses arquivos contêm definições de parâmetros específicos, os quais podem ser utilizados para criar uma DAG específica ou serem aplicados em templates reutilizáveis, como será detalhado mais adiante. Essa abordagem proporciona flexibilidade e personalização significativa no desenvolvimento, permitindo uma configuração precisa e adaptável conforme as necessidades do projeto.

Esse método permite uma abordagem mais dinâmica e eficiente na gestão das tarefas e na adaptação às necessidades do projeto. Além disso, a utilização de arquivos YAML simplifica o processo de manutenção e permite uma fácil compreensão das configurações aplicadas.

#### **Estrutura dos Arquivos YAML**

Os arquivos YAML de argumentos estão disponíveis no diretório [plugins/include/configs](plugins/include/configs) e devem ser carregados no bucket do Composer seguindo o mesmo caminho.

Exemplo típico da estrutura de um arquivo YAML:

```yaml
# Exemplo de arquivo yaml - args_exemplo.yaml
dag:
  owner: "Ipnet"
  description: "inst_dr_osmar > cloudfunctions > bigquery"
  # schedule: "0 3 * * *"
  timeout: 100
  retries: 2
  retry_delay: 5
  max_active_runs: 1
  tags:
    - source:api
    - system:inst_dr_osmar
    - zone:bronze_to_silver
    - ingest:cloudfunction
    - transform:None
    - load:full
    - daily 03am
    
  doc_md: |
    ## DAG: API Instituto Dr. Osmar Bronze to Silver Financeiro

common:
  form_repository_id: ghm-dataform-repo-default
  form_dag_compilation: compilation_dataform_repository_default

tasks:
  - process: financeiro
    source: api_inst_dr_osmar
      deletion_partition_bronze: False
    ingestion:
      service: cloudfunctions
      function_name: gcf_api_inst_dr_osmar_to_bronze_financeiro
      request_method: POST
      data_request: {}
    transformation:
      service: dataform
      silver_is_incremental: True
  
  - process: financeiro_diario
    source: api_inst_dr_osmar
    deletion:
      deletion_partition_bronze: False
    ingestion:
      service: cloudfunctions
      function_name: gcf_api_inst_dr_osmar_to_bronze_financeiro
      request_method: POST
      data_request: {"leitura_diaria": True}
    dependencies:
     - financeiro
```

**Detalhes sobre Parâmetros**

- Parâmetros com a chave `config` são referentes à configurações inicias da dag;
- Parâmetros com a chave `tasks` são utilizados em operadores.

**⚠️ Observação ⚠️:**

- `Exemplos como Referência`: Os exemplos fornecidos são apenas uma base de orientação. Adaptações devem ser feitas conforme necessidades específicas do workload;
- `Recomendação de Templates`: Para utilizar YAML com argumentos predefinidos, é recomendado a utilização de templates. Essa prática simplifica o processo de criação e manutenção, contribuindo para uma gestão mais eficaz das DAGs;
- `Acesse a Documentação dos Templates`: Para obter orientações detalhadas sobre o uso correto dos templates, acesse a documentação disponível: [documentação de templates](plugins\include\template\README.md).
Aqui está a documentação aprimorada para a incorporação de YAML em uma DAG:

#### **Incorporação de YAML em uma DAG**

Para gerar DAGs dinâmicas com base nas configurações YAML, foi criada a função `create_dags_from_yaml`, que está armazenada no módulo `util.py`.

##### Exemplo de Uso
Para gerar as DAGs, basta gerar um ``arquivo.py`` dentro do diretório de DAGs com a seguinte definição.

```python
# dags/dag_exemplo.py

# Importa a função para criar DAGs a partir de arquivos YAML
# import airflow
from include.utils import create_dags_from_yaml

folder_config = "oracle_tasy_cloud"
file_prefix = None
template_type = "elt"

# Chama a função para criar e registrar DAGs com um prefixo de arquivo específico
create_dags_from_yaml(folder_config=folder_config, file_prefix=file_prefix, template_type=template_type)
```

Este código resultará na criação de várias DAGs com base na quantidade de arquivos YAML presentes na pasta `oracle_tasy_cloud` no bucket. Se o `file_prefix` for definido, apenas arquivos que correspondem a esse prefixo serão processados.

##### Descrição dos Parâmetros da função

- **template_type** (str): Tipo de template para determinar qual classe de DAG usar. Aceita "elt" e "external".
- **folder_config** (str, opcional): Caminho do diretório onde os arquivos YAML estão localizados, é possível utilizar subpastas. Se não fornecido, o diretório padrão é `configs`.
- **file_prefix** (str, opcional): Prefixo dos arquivos YAML a serem processados. Se não fornecido, todos os arquivos no diretório serão processados.

Certifique-se de não utilizar uma quantidade muito alta de arquivos YAML por DAG para evitar sobrecarregar o scheduler do Airflow.

## Jornada de Desenvolvimento

Durante a jornada de desenvolvimento, haverá duas opções para criar DAGs no Apache Airflow: através da utilização de `templates` predefinidos ou através da criação de suas próprias DAGs personalizadas.

Durante o processo de desenvolvimento, vale destacar que o *rollout* (liberação) e o *deploy* (implantação) das DAGs são realizadas automaticamente através do GitHub Actions. Isso acontece sempre que um *push* é feito na branch `dev`, acionando o deploy para o ambiente de desenvolvimento, ou na branch `main`, direcionando o deploy para o ambiente de produção.

❗**Antes de prosseguir, por favor, assegure-se de revisar todos os tópicos anteriores.**

<a name="ambientes-e-recursos-associados"></a>
### Ambientes e Recursos Associados

A seguir, estão os links para acessar a interface do usuário (UI) do Cloud Composer em cada projeto, bem como o web server do Airflow e os respectivos buckets associados:

| Ambiente | Project ID | Instância | Web Server | Bucket | 
| --- | --- | --- | --- | --- | 
| Desenvolvimento | ghm-data-dev| [ghm-composer-dev](https://console.cloud.google.com/composer/environments?project=ghm-data-dev) | [Web Server - dev](https://9b8ace68486645a8a9e7a6c2c95633bd-dot-southamerica-east1.composer.googleusercontent.com/home) | [bkt-ghm-composer-dev](https://console.cloud.google.com/storage/browser/bkt-ghm-composer-dev/dags?project=ghm-data-dev) |
| Produção | ghm-data-prod | [ghm-composer-prod](https://console.cloud.google.com/composer/environments?project=ghm-data-prod) | [Web Server - prod](https://84ac072324b6480c8d90f5945e8adb19-dot-southamerica-east1.composer.googleusercontent.com/home) | [bkt-ghm-composer-prod](https://console.cloud.google.com/storage/browser/bkt-ghm-composer-prod/dags?project=ghm-data-prod) |

### Desenvolvimento

Durante a fase de desenvolvimento, é crucial seguir boas práticas para garantir a qualidade e a consistência das DAGs, utilizando os padrões recomendados:

1. **Padronização**: Mantenha a padronização, seguindo as diretrizes previamente estabelecidas, como nomenclatura, uso de tags entre outros, para garantir uma uniformidade no ambiente;
2. **Modelo de DAG**: Escolha entre utilizar templates predefinidos ou criar sua DAG personalizada, alinhando-se às necessidades específicas;
3. **Criação do YAML**: Após definir o modelo de DAG, crie o arquivo YAML contendo os argumentos necessários. Para templates, alguns argumentos já são predefinidos. Consulte a documentação [aqui](plugins/include/configs). 
 Certifique-se de carregar os argumentos no caminho ``plugins/include/configs`` dentro do bucket de dev;
4. **Criação da DAG**: Com base no modelo escolhido e nos argumentos definidos, desenvolva o arquivo da DAG, seja utilizando lógica personalizada ou seguindo a documentação de templates existentes. Os arquivos DAG devem ser carregados no caminho `dags` dentro do bucket referente ao Composer;
5. **Teste e Acesse a DAG**: Após a criação da DAG, acesse o Console do Airflow para testar e validar o comportamento da DAG no ambiente. Certifique-se de que tudo está funcionando conforme esperado.

### Produção

Ao implementar as DAGs em produção, siga estas instruções:

1. **Implementação Automatizada**
    - Após concluir os testes no ambiente de desenvolvimento, abra um *merge request* da branch `dev` para a branch `main`. Após a aprovação, o processo de deploy será iniciado automaticamente. Aguarde a finalização do deploy para o ambiente de produção antes de prosseguir.
3. **Monitoramento**
    - Monitore e esteja atento ao comportamento do processo. Caso necessário, reverta as alterações.
4. **Revisão Contínua**
    - Mantenha uma prática contínua de revisão de código para incorporar melhorias e correções à medida que novas funcionalidades são adicionadas ou requisitos evoluem.
5. **Documentação**
    - Mantenha a documentação atualizada, refletindo as mudanças e atualizações implementadas nas DAGs.

A jornada de desenvolvimento, seguindo os padrões estabelecidos, desde o ambiente de desenvolvimento até a produção, visa garantir que as DAGs sejam desenvolvidas, testadas e implementadas de maneira eficiente, mantendo a consistência e a confiabilidade em todo o ciclo de vida do projeto.

## Contas de Serviço

**Contas de Serviço e Gerenciamento de Acessos no IAM**

As Contas de Serviço são identidades utilizadas para executar tarefas em nome de um aplicativo ou serviço. O [Identity and Access Management](https://cloud.google.com/security/products/iam) (IAM) é a ferramenta de gestão de acessos e permissões em um projeto Google Cloud.

A tabela abaixo oferece uma visão geral das Contas de Serviço utilizadas pelo Composer, destacando as informações cruciais sobre as roles atribuídas a cada uma:

| Projeto | Service Account| Descrição | Role-comn |
| --- | --- | --- | --- |
| ghm-data-{env} | sa-composer@ghm-data-{env}.iam.gserviceaccount.com | SA principal do Cloud Composer | Cloud Run Invoker<br>Composer Worker<br>Secret Manager Secret Accessor<br>Service Account Token Creator<bn> BigQuery Data Editor<br>BigQuery Job User<br>Editor de Objetos do Cloud Storage<br>Dataflow Developer<br>Dataform Editor<br>Service Account User |

Certifique-se de substituir os placeholders marcadas com `{env}` para o ambiente desejado.
