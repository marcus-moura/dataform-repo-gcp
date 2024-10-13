#  Ghm-Data-CloudFunctions <img src="images/cloud_functions.png" alt="cloud_functions-logo" width="40"/>

## Sobre

Bem-vindo ao repositório do Google Cloud Functions. Neste local, está disponível uma coleção abrangente de scripts e configurações dedicados aos processos de extração de dados.

O Cloud Function é uma forma de computação serverless oferecida pelo Google Cloud. Ele possibilita a execução de código em resposta a eventos, sem a necessidade de provisionar ou gerenciar servidores. Essa abordagem permite a focalização na lógica de aplicação, enquanto a plataforma cuida da infraestrutura subjacente.

Para aprofundar ainda mais o conhecimento sobre o Google Cloud Functions, recomenda-se consultar a documentação oficial:

- [Documentação oficial Google Cloud Functions](https://cloud.google.com/functions)

## Objetivo

Segue uma lista dos principais objetivos do Google Cloud Functions como ferramenta integrante do projeto de Dados.

O objetivo deste repositório é fornecer uma estrutura organizada para centralizar e versionar funções criadas no Cloud Functions, fornecendo soluções eficientes para tarefas específicas, eliminando a necessidade de gerenciar a infraestrutura subjacente. Cada função é projetada para realizar uma tarefa específica de maneira rápida e eficaz, permitindo a execução de operações críticas com o mínimo de esforço possível.


Os objetivos das Google Cloud Functions, que são parte da oferta de computação sem servidor (serverless) do Google Cloud, incluem:

- **Automação de Tarefas**: Facilitar a automação de tarefas recorrentes e processos de back-end, como a manipulação de eventos originados de outros serviços do Google Cloud ou de fontes externas.

- **Escalabilidade Automática**: Escalar automaticamente de acordo com a demanda. Isso significa que as funções podem lidar com um número elevado de solicitações sem a necessidade de gerenciamento de infraestrutura.

- **Execução Baseada em Eventos**: Executar código em resposta a eventos específicos, como alterações em dados no Google Cloud Storage, atualizações em um banco de dados do Firestore, ou mensagens recebidas em um tópico do Pub/Sub.

- **Desenvolvimento Ágil e Focado**: Permitir que os desenvolvedores se concentrem na escrita do código que realmente importa para a aplicação, sem se preocupar com o ambiente subjacente de execução, manutenção de servidores, ou a complexidade da infraestrutura.

- **Integração com o Ecossistema Google Cloud**: Integrar-se perfeitamente com outros serviços do Google Cloud, como BigQuery, Cloud Pub/Sub, Firebase, Cloud Storage, entre outros, proporcionando um desenvolvimento mais ágil e eficiente.

- **Redução de Custo**: O modelo de pagamento é baseado no uso real, o que pode ajudar a reduzir custos operacionais, pois não há cobrança quando as funções não estão sendo executadas.

- **Rapidez na Implementação**: Capacidade de implementar rapidamente novas funcionalidades e lógicas de negócios, acelerando o ciclo de desenvolvimento e entrega de produtos.

- **Isolamento e Segurança**: Cada função é executada em seu próprio ambiente isolado, o que aumenta a segurança e reduz os riscos de conflitos de dependências.

Esses objetivos refletem a natureza flexível, escalável e eficiente das Google Cloud Functions, tornando-as uma ferramenta valiosa para desenvolvedores e empresas que buscam soluções de cloud computing ágeis e eficientes.

## Organização do Repositório

O repositório está organizado da seguinte maneira:

```bash
├── .github
│   └── workflows
│       └── ci-deploy-gcf-...
├── cloudfunctions
│   ├── src
│   │   └── folder_functions
│   │       ├── source_code
│   │       │   ├── files.py
│   │       │   ├── requirements.txt
│   │       ├── deploy.sh
│   │       ├── var_dev.sh
│   │       ├── var_prd.sh
│   ├── .python-version
│   ├── poetry.lock
│   ├── pyproject.toml
```

### Estrutura das Pastas

- **.github/workflows/**: Contém os scripts de CI/CD, incluindo o `ci-deploy-gcf-...` para automação do deploy das funções para o Google Cloud Functions via GitHub Actions.
  
- **cloudfunctions/src/**: Diretório principal das funções do Google Cloud Functions.

    - **folder_functions/**: Diretório que contém o código e os arquivos de configuração de uma função específica. Cada função segue o padrão:
  
        - **source_code/**: Pasta que contém os scripts `.py` utilizados pela função. Cada função deve incluir um arquivo `requirements.txt` para definir as dependências.
        
        - **deploy.sh**: Script que realiza o deploy da função no Google Cloud Functions. O processo foi automatizado via CI/CD.
        
        - **var_dev.sh**: Script que define as variáveis de ambiente para o ambiente de desenvolvimento (Dev).
        
        - **var_prd.sh**: Script que define as variáveis de ambiente para o ambiente de produção (Prod).
  
- **.python-version**: Arquivo que define a versão do Python utilizada no projeto.
  
- **poetry.lock e pyproject.toml**: Arquivos de configuração e gerenciamento de dependências do projeto Python utilizando o Poetry.

⚠️ **Observações**

- O processo de deploy das Cloud Functions é totalmente automatizado através dos scripts localizados no diretório `.github/workflows/`. Esses scripts utilizam o GitHub Actions para realizar o deploy de forma contínua.
  
- Cada função dentro da pasta `src` segue um padrão de organização para garantir consistência e facilidade na manutenção.

# Uso

O uso das Google Cloud Functions envolve principalmente a automação e execução de código em resposta a eventos específicos dentro do ecossistema do Google Cloud ou de fontes externas. 

Alguns dos principais usos incluem:

- **Processamento de Eventos**: Executar funções em resposta a eventos de serviços do Google Cloud, como upload de arquivos no Cloud Storage, mensagens no Pub/Sub, ou alterações em bancos de dados do Firestore ou Realtime Database.

- **Integrações e APIs**: Criar APIs ou microsserviços que reagem a solicitações HTTP, facilitando a integração com outras aplicações ou serviços.

- **Processamento de Dados**: Utilizar para processamento de dados em tempo real, como análise, filtragem, e transformação de dados de entrada.

## Instalação e Configuração

Ao contrário de muitos serviços que demandam processos de instalação, o Cloud Functions é um serviço serverless, eliminando completamente a necessidade de instalação. Nesse contexto, basta concentrar-se na criação do código e na configuração da função, podendo ser feita de maneira prática e eficiente, seja por meio do console do Google Cloud ou utilizando comandos diretamente no shell(sh). Esse paradigma simplificado permite um rápido desenvolvimento e implementação de funções, sem a complexidade associada à configuração e gestão de infraestrutura.

### Configuração de Trigger com Autenticação (Require Authentication)
Ao desenvolver Cloud Functions, é uma boa prática incorporar autenticação aos seus triggers. Isso significa que a execução da função só será permitida para solicitações que apresentem credenciais ou tokens de autenticação válidos.

Para implementar essa prática, configure seu Cloud Functions para aceitar apenas solicitações autenticadas marcando a opção `Require Authentication` no processo de criação de uma função no console Cloud Function, conforme ilustrado na imagem abaixo:

![Require Authentication](images/create_function.png "Criar função com authenticação")

⚠️ **Observações**: Caso o desenvolvimento sejá feito utilizando os scripts de `deploy.sh` e `var_{env}.sh`, essa configuração já estará pronta e não será necessário ajustes adicionais.

Após concluir o desenvolvimento da função, é essencial gerar um token ao realizar uma solicitação. Recomenda-se consultar a documentação oficial do Google para obter orientações detalhadas sobre como gerar o token e realizar a autenticação. As informações específicas estão disponíveis no link a seguir:
- [Documentação de Autenticação do Google Cloud Functions.](https://cloud.google.com/functions/docs/securing/authenticating?hl=pt-br).

### Integração com Secret Manager

Ao implementar Cloud Functions que necessitem de armazenamento seguro de credenciais, chaves de API ou outros segredos sensíveis, é altamente recomendável seguir boas práticas de segurança. Uma maneira eficaz de gerenciar essas informações confidenciais é através do Google Cloud Secret Manager.
Para utilizar siga os seguintes passos:
1. Crie o secret no console do secret manager
2. Certifique-se que a conta de serviço utilizada para executar jobs, possua a permissão ``Secret Manager Secret Accessor`` no IAM (Identity and Access Management) do projeto comn-{env}.
Por padrão a conta utilizada é a ``[project-number]-compute@developer.gserviceaccount.com``. Mas foi criada uma conta personalizada para esse intuito chamada `sa-cloudfunction@ghm-data-{env}.iam.gserviceaccount.com`.
3. Para concluir o restante da configuração, siga as orientações detalhadas na documentação fornecida abaixo:
    - [Como utilizar secret no Cloud Functions](https://cloud.google.com/functions/docs/configuring/secrets?hl=pt-br)

🔗 Para mais configurações consulte [configurar o Cloud Function](https://cloud.google.com/functions/docs/configuring?hl=pt-br)

## Normas e Padrões

### Padrões de Nomenclatura

Ao criar uma função no Cloud Functions, é importante seguir padrões de nomenclatura consistentes para facilitar a identificação e a manutenção.

Recomenda-se a seguinte estrutura de nome:

- lower case
- Separado por "_"
- Prefixo e placeholders: `gcf_{tipo de origem}_{aplicação}_to_{zona}_{contexto_workload}`

Por exemplo: `gcf_api_inst_dr_osmar_to_bronze_atendimento`

### Parâmetros de requisição

É importante ressaltar que determinadas funções possuem a capacidade de receber parâmetros de requisição diretamente a partir do request HTTP. Essa flexibilidade proporciona uma personalização e adaptação dinâmica dessas funções às necessidades específicas de cada solicitação. A inclusão de parâmetros nos requests permite a configuração dinâmica das funções, resultando em uma abordagem mais versátil e dinâmica para o tratamento de dados e execução de tarefas. Essa flexibilidade amplia consideravelmente a gama de cenários nos quais as funções podem ser aplicadas, elevando a eficiência e a adaptabilidade do sistema como um todo.

Um exemplo concreto de uma função que utiliza esse mecanismo é a [gcf_api_inst_dr_osmar_to_bronze_agendamento](src/gcf_api_inst_dr_osmar_to_bronze_agendamento). Abaixo, é apresentado um trecho do código onde a variável **`request_json`** recebe os parâmetros enviados pela solicitação e, em seguida, descompacta esses parâmetros em variáveis essenciais para o funcionamento da função:

```python

def main(request=None):
  
    request_json = request.get_json(silent=True)

    # recover parameter values in request json
    leitura_diaria = request_json.get("leitura_diaria", False) if request_json else False

```

Aqui está um exemplo simples de requisição com argumentos:
```bash
curl -m 130 -X POST https://southamerica-east1-[PROJECT_ID].cloudfunctions.net/gcf_api_inst_dr_osmar_to_bronze_agendamento \
-H "Authorization: Bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{
    "leitura_diaria": "True",
}'
```

## Orquestração

A orquestração de determinadas funções é conduzida por meio do Cloud Composer (Apache Airflow).

### **Composer**
A orquestração do Cloud Function pode ser realizada de duas maneiras no Cloud Composer (Apache Airflow), utilizando templates ou desenvolvendo DAGs personalizadas.

Abaixo, está disponível informações detalhadas e recursos específicos para ambas as abordagens, oferecendo flexibilidade na integração e automação de fluxos de trabalho de processamento de dados no Dataproc usando o Composer.

#### **1. Utilização de Templates**

No repositório do Composer, foi simplificado a criação de DAGs através do uso de templates que utilizam argumentos provenientes de um arquivo YAML. Abaixo, é fornecido um exemplo de como configurar os argumentos relacionados ao Cloud Functions utilizando o template [`elt_data_pipeline.py`](..\composer\plugins\include\template\elt_data_pipeline.py). Este template desempenha um papel crucial na automatização do processo Extract, Load, Transform (ELT) no ambiente do Cloud Composer.

Exemplo de configuração para Cloud Function:

```yaml
tasks:
  - process: atendimento_diario # Nome que serve de base para o nome tabela bronze e silver, na silver é aplicado um prefixo "tbl".
    source: api_inst_dr_osmar # Origem dos dados composto pela 'aplicação' + 'sistema de origem'. Utilizaso para criar a nomenclatura dos datasets de origem e destino.
    deletion:
      deletion_partition_bronze: False # Habilita a deleção de partição na tabela bronze
    ingestion:
      service: cloudfunctions
      function_name: gcf_api_inst_dr_osmar_to_bronze_atendimento
      request_method: POST
      data_request: {"leitura_diaria": True}
    # transformation:
    #   service: dataform
    #   silver_is_incremental: True
    dependencies:
      - atendimento
```
- Neste arquivo, a seção **`cloudfunction`** é utilizada para configurar operadores referentes ao Cloud Function.

Acesse o arquivo YAML completo no link abaixo: 
- **[conf_api_inst_dr_osmar_brz_to_slv_atendimento.yaml](..\composer\plugins\include\configs\api_inst_dr_osmar\conf_api_inst_dr_osmar_brz_to_slv_atendimento.yaml)**

#### Inserindo parâmetros de requisição

No template `elt_data_pipeline`, os parâmetros de requisição são integrados ao arquivo YAML associado à DAG, utilizando a chave `data_request`, conforme ilustrado no exemplo de código acima, em conformidade com um formato predefinido. Posteriormente, esses argumentos são anexados ao operador responsável por invocar a Cloud Function.

Aqui está um exemplo prático utilizado pelo template no qual o Operador `HttpOperator` é empregado para invocar uma Cloud Function:
```python
def create_cloudfunction_task(task_id: str, gcf_params: dict):
        endpoint_gcf = gcf_params['function_name']
        url_gcf = f"{URL_BASE_GCF}/{endpoint_gcf}"
        token_gcf = fetch_id_token(Request(), url_gcf)
        
        return HttpOperator(
            task_id=task_id,
            method=gcf_params.get("request_method", "POST"),
            http_conn_id=gcf_params.get("http_conn_id", "gcf_conn_id"),
            endpoint=endpoint_gcf,
            headers={'Authorization': f"Bearer {token_gcf}", "Content-Type": "application/json"},
            data=json.dumps(gcf_params['data_request']) if gcf_params.get('data_request') else None,
            trigger_rule=gcf_params.get('trigger_rule', 'all_success')
        )
```
Neste código, os parâmetros de requisição são passados pelo atributo `data`.

#### **Documentação do Template**

Para entender os argumentos e aprender como utilizar o template `elt_data_pipeline.py`, consulte a documentação abaixo:
- [elt_data_pipeline](..\composer\plugins\include\template\elt_data_pipeline.py)

#### **2. Desenvolvimento Personalizado das DAGs**

Caso não deseje utilizar o template é possível criar orquestrações personalizadas, seguindo a documentação oficial do airflow com operadores para triggar uma Cloud Function com HttpOperator: 

- [Documentação Airflow HttpOperator](https://airflow.apache.org/docs/apache-airflow-providers-http/stable/operators.html).

## Jornada de Desenvolvimento

Durante o processo de desenvolvimento, vale destacar que o *rollout* (liberação) e o *deploy* (implantação) das funções são realizados automaticamente através do GitHub Actions. Isso acontece sempre que um *push* é feito na branch `dev`, acionando o deploy para o ambiente de desenvolvimento, ou na branch `main`, direcionando o deploy para o ambiente de produção.

❗**Antes de prosseguir, por favor, assegure-se de revisar todos os tópicos anteriores.**

### Ambientes e Recursos Associados

Segue abaixo o link para acessar o console do Cloud Functions de cada projeto:

| Ambiente | Project ID | Console |
| --- | --- | --- |
| Desenvolvimento | ghm-data-dev | [cloudfunction-dev](https://console.cloud.google.com/functions/list?referrer=search&project=ghm-data-dev) |
| Produção | ghm-data-prod | [cloudfunction-prod](https://console.cloud.google.com/functions/list?referrer=search&project=ghm-data-prod) |

### Desenvolvimento

No processo de codificação da função, recomenda-se a utilização da linguagem Python. Essa orientação está alinhada a uma decisão estratégica, levando em consideração as características e vantagens específicas do Python para o projeto.

#### Configuração do Ambiente de Desenvolvimento Local
#### Requisitos

Certifique-se de ter os seguintes pré-requisitos instalados:

- [Google Cloud SDK](https://cloud.google.com/sdk)
- [Python](https://www.python.org/)
- [Poetry](https://python-poetry.org/docs/) - Opcional

#### Instalação
Para a instalação do projeto, siga as instruções abaixo:

1. Clone o repositório:

    ```bash
    git clone https://github.com/GitOpty/ghm-dados.git
    ```
2. Navegue até o diretório do projeto recém-clonado:

    ```bash
    cd cloudfunctions
    ```
#### Utilizando `pip`

Se você preferir usar o `pip` para instalar as dependências, siga estas etapas:

1. **Criação e Ativação do Ambiente Virtual Python:**

    - No Linux:
        ```bash
        python3 -m venv venv
        source venv/bin/activate
        ```

    - No Windows:
        ```bash
        python3 -m venv venv
        .\venv\Scripts\activate
        ```

2. **Instalação dos Pacotes Python Necessários:**

    Execute os seguintes comandos para instalar os pacotes listados nos arquivos `requirements.txt`

    ```bash
    pip install -r requirements.txt
    ```

#### Utilizando Poetry

Se você preferir usar o gerenciador de pacotes Poetry, siga estas etapas:

1. **Instalação das Dependências com Poetry:**

    Instale as dependências do projeto usando Poetry:

    ```bash
    poetry install
    ```

2. **Ativação do Ambiente Virtual:**

    Ative o ambiente virtual criado pelo Poetry:

    ```bash
    poetry shell
    ```

#### Configuração do Google Cloud SDK

- Baixe e instale o Google Cloud SDK (gcloud) do site do [Google Cloud](https://cloud.google.com/python/docs/reference?hl=pt-br).

- Inicialize o SDK com ``gcloud init`` para autenticar e configurar o acesso ao seu projeto do Google Cloud.

#### Preparação do Projeto Cloud Functions

##### Estrutura da Função

- Crie um diretório para o seu projeto Cloud Function e navegue até ele.

- Dentro do diretório, crie um arquivo para o seu código Python (por exemplo, main.py).

##### Gerenciamento de Dependências

- Crie um arquivo ``requirements.txt`` no diretório do projeto para listar todas as dependências necessárias. 

- Por exemplo, caso seja necessário a lib ``requests``, adicione requests à lista.
  - ```text
    request=={versão}
    ```

- Instale as dependências no seu ambiente virtual usando ``pip install -r requirements.txt``.

#### Configuração de Variáveis de Ambiente com Segredos do Secret Manager

Para configurar variáveis de ambiente com segredos armazenados no Secret Manager para cada função, acesse o console do Cloud Functions e siga as instruções da [documentação oficial](https://cloud.google.com/functions/docs/configuring/secrets?hl=pt-br).

⚠️ **Observação**: Nos scripts `var_{env}.sh`, os parâmetros já foram implementados para automatizar a criação dessas variáveis de ambiente com base no Secret Manager. Basta configurar esses scripts para cada função, facilitando a integração com os diferentes ambientes (desenvolvimento e produção).

#### Implantação

Para simplificar o processo de implantação das funções, foram desenvolvidos scripts que utilizam comandos **`gcloud`**, automatizando tanto a configuração quanto o deploy no Google Cloud. Esse processo de deploy foi integrado ao pipeline de CI/CD via GitHub Actions, garantindo que toda a implantação seja realizada de forma contínua e automatizada. Portanto para realizar o deploy no ambiente de dev, basta realizar um push na branch `dev` deste repositório.

Para implantação manual via console, consulte o [Guia Rápido do Console do Google Cloud](https://cloud.google.com/functions/docs/console-quickstart?hl=pt-br).

#### Escolha um Modelo de DAG

Existem duas opções principais para criar a DAG no Composer:

- **Template DAGs:** Use o template de DAG `elt_data_pipeline` referenciado acima. Este é um modelo predefinido que pode ser configurado rapidamente com argumentos específicos para o seu caso de uso.
- **DAG Personalizada:** Construa uma DAG personalizada para atender às suas necessidades específicas, utilizando a documentação oficial do Airflow referenciada acima.

#### Teste de DAG

- Execute sua DAG no Composer e verifique os logs para garantir que a tarefa Cloud Function está sendo executada corretamente.

### Produção

Ao implementar as Funções em produção, siga estas instruções:

1. **Implementação Automatizada**
    - Após concluir os testes no ambiente de desenvolvimento, abra um *merge request* da branch `dev` para a branch `main`. Após a aprovação, o processo de deploy será iniciado automaticamente. Aguarde a finalização do deploy para o ambiente de produção antes de prosseguir.
3. **Revisão Contínua**
    - Mantenha uma prática contínua de revisão de código para incorporar melhorias e correções à medida que novas funcionalidades são adicionadas ou requisitos evoluem.
4. **Documentação**
    - Mantenha a documentação atualizada, refletindo as mudanças e atualizações implementadas nas Cloud Functions.

A jornada de desenvolvimento, seguindo os padrões estabelecidos, desde o ambiente de desenvolvimento até a produção, visa garantir que as Cloud Functions sejam desenvolvidas, testadas e implementadas de maneira eficiente, mantendo a consistência e a confiabilidade em todo o ciclo de vida do projeto.