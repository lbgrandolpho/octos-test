## Guia de Instalação Passo a Passo

### Pré-requisitos

Antes de começar, certifique-se de ter os seguintes itens instalados em sua máquina:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Elixir](https://elixir-lang.org/install.html)
- [Phoenix Framework](https://hexdocs.pm/phoenix/installation.html)

### Passo 1: Clonar o Repositório

Clone o repositório para sua máquina local:

```sh
git clone https://github.com/lbgrandolpho/octos-test
cd octos-test
```

### Passo 2: Configurar o Docker

Certifique-se de que o Docker está em execução em sua máquina. Em seguida, use o Docker Compose para configurar o banco de dados PostgreSQL:

```sh
docker-compose up -d
```

Este comando iniciará o banco de dados PostgreSQL em um contêiner Docker.

### Passo 3: Instalar Dependências do Elixir

Instale as dependências do Elixir usando o Mix:

```sh
mix deps.get
```

### Passo 4: Configurar o Banco de Dados

Configure o banco de dados executando o seguinte comando:

```sh
mix ecto.setup
```

Este comando criará o banco de dados, executará as migrações e irá populá-lo com dados de exemplo.

### Passo 5: Iniciar o Servidor Phoenix

Inicie o servidor Phoenix:

```sh
mix phx.server
```

## Acessando as APIs

### 1. GET /cameras

Para acessar a API `GET /cameras`, você pode usar a seguinte consulta GraphQL:

```graphql
query {
  cameras {
    id
    name
    email
    status
    deactivated_at
    cameras {
      id
      brand
      status
    }
  }
}
```

Você pode enviar esta consulta para o endpoint GraphQL em [`http://localhost:4000/graphql`](http://localhost:4000/graphql) com método POST (padrão GraphQL).

**Argumentos:**

Alternativamente, você pode utilizar argumentos de paginação, filtragem e ordenação para sua consulta. Os argumentos possíveis são:

- `limit`: O número máximo de usuários a ser retornado. (`default: 10`)
- `offset`: O número de usuários a serem ignorados antes de começar a retornar os resultados. (`default: 0`)
- `camera_brand`: Filtra as câmeras que serão retornadas para os usuários pela marca fornecida. (`default: nil`)
- `order_by_camera_brand`: Ordena as câmeras dos usuários alfabeticamente por suas marcas. (`default: false`)

```graphql
query {
  cameras(limit: 2, offset: 5, camera_brand: "Intelbras", order_by_camera_brand: true) {
    id
    name
    email
    status
    deactivated_at
    cameras {
      id
      brand
      status
    }
  }
}
```

**Exemplo de Resultado Esperado (com filtros):**

```json
{
  "data": {
    "cameras": [
      {
        "cameras": [
          {
            "brand": "Intelbras",
            "id": "289",
            "status": "inactive"
          },
          {
            "brand": "Intelbras",
            "id": "260",
            "status": "active"
          },
          {
            "brand": "Intelbras",
            "id": "280",
            "status": "inactive"
          },
          ...
        ],
        "deactivated_at": null,
        "email": "hiram2031@grimes.name",
        "id": "6",
        "name": "Ígor Alves",
        "status": "active"
      },
      {
        "cameras": [
          {
            "brand": "Intelbras",
            "id": "328",
            "status": "inactive"
          },
          {
            "brand": "Intelbras",
            "id": "329",
            "status": "inactive"
          },
          {
            "brand": "Intelbras",
            "id": "349",
            "status": "active"
          },
          ...
        ],
        "deactivated_at": null,
        "email": "hector2051@zboncak.org",
        "id": "7",
        "name": "Ian Pires",
        "status": "active"
      }
    ]
  }
}
```

### 2. POST /notify-users

Para acessar a API `POST /notify-users`, você pode usar a seguinte mutação GraphQL:

```graphql
mutation {
  notifyUsers
}
```

Você pode enviar esta mutação para o endpoint GraphQL em [`http://localhost:4000/graphql`](http://localhost:4000/graphql) com método POST (padrão GraphQL).

**Resultado Esperado:**

```json
{
  "data": {
    "notifyUsers": "Emails enviados para usuários com câmeras Hikvision"
  }
}
```

### Acessando Emails

Você pode acessar os emails enviados durante o desenvolvimento em [`http://localhost:4000/dev/mailbox`](http://localhost:4000/dev/mailbox).

## Detalhes da Implementação

### 1. Docker para Gerenciamento de Banco de Dados

Usar Docker para gerenciar o banco de dados PostgreSQL garante um ambiente de desenvolvimento consistente em diferentes máquinas. O arquivo [`docker-compose.yml`](docker-compose.yml) configura um contêiner PostgreSQL com as variáveis de ambiente necessárias e volume para persistência de dados.

### 2. GraphQL via Absinthe

Absinthe foi usado para implementar endpoints GraphQL, proporcionando uma maneira flexível e eficiente de consultar e mutar dados. Isso permite uma interação mais dinâmica com o backend em comparação com APIs REST tradicionais.

### 3. Swoosh para Manipulação de Emails

Swoosh foi integrado para manipular notificações por email. No desenvolvimento, os emails são armazenados localmente e podem ser visualizados em `/dev/mailbox`. Esta configuração garante que a funcionalidade de email possa ser testada sem enviar emails reais.

### 4. Gerenciamento de Configuração

Os arquivos de configuração estão organizados no diretório [`config`](config ), com arquivos separados para diferentes ambientes (`dev.exs`, `prod.exs`, `test.exs`). Embora apenas a configuração de ambiente dev foi utilizada para esta implementação, isso garante que as configurações específicas do ambiente sejam gerenciadas adequadamente.

### 5. Estrutura de Dados

A estrutura de dados consiste em duas tabelas principais: `users` e `cameras`.

- **Tabela de Usuários:**
  - `id`: O identificador único do usuário.
  - `name`: O nome do usuário.
  - `email`: O endereço de email do usuário.
  - `status`: O status do usuário (por exemplo, "ativo" ou "inativo").
  - `deactivated_at`: O timestamp quando o usuário foi desativado, se aplicável.

- **Tabela de Câmeras:**
  - `id`: O identificador único da câmera.
  - `brand`: A marca da câmera.
  - `status`: O status da câmera (por exemplo, "ativa" ou "inativa").
  - `user_id`: O ID do usuário ao qual a câmera pertence.

### 6. Dados de Exemplo

Os dados de exemplo são populados usando o arquivo [`priv/repo/seeds.exs`](priv/repo/seeds.exs ). Ele cria 1000 usuários, cada um com 50 câmeras, e garantindo pelo menos 1 câmera ativa para usuários ativos e todas as câmeras inativas para usuários inativos.

### 7. Detalhes do Retorno da API

- **GET /cameras**: Retorna uma lista de usuários com suas respectivas câmeras. Se um usuário estiver inativo, suas câmeras não são incluídas na resposta, mas seus dados e a data de desativação são retornados.

- **POST /notify-users**: Envia emails de notificação para usuários com câmeras Hikvision. Apenas usuários com câmeras Hikvision recebem a notificação.

## Conclusão

Seguindo estes passos, você deve ser capaz de configurar e executar o servidor em sua máquina local. As decisões de desenvolvimento tomadas ao longo do caminho garantem uma aplicação robusta, escalável e de fácil manutenção. Se você tiver alguma dúvida ou precisar de mais assistência, sinta-se à vontade para entrar em contato.