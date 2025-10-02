# safeyard-devops

# SafeYard — DevOps (Azure)

**Objetivo:** entregar a solução da disciplina **DevOps Tools & Cloud Computing** usando **Azure** (PaaS) + **App Service (Java 17)** + **Azure SQL**.  
Este repositório (e este README) descreve *exatamente* o que você deve executar na gravação do vídeo: **clonar o repositório**, **criar a infra via CLI**, **provisionar o banco**, **fazer deploy do JAR** e **testar o CRUD**.

---

## Estrutura recomendada do repositório

```
infra/
  01-variables.env           # Variáveis (edite APENAS a senha!)
  02-create-resources.sh     # Cria RG, SQL, DB, Plan e WebApp + AppSettings

db/
  script_bd.sql              # DDL (tabela obrigatória CLIENTE)
  grant_admin.sql            # (Opcional) promove seu usuário como ADMIN

deploy/
  01-deploy-jar.sh           # Faz o deploy do JAR e reinicia o WebApp
  02-logs-and-swagger.sh     # Habilita logs e imprime a URL do Swagger

tests/
  moto.http                  # Requisições REST de exemplo (substituir host/token)

README.md
```

> **Importante:** os scripts acima são referenciados por este README. Caso ainda não existam no repo, crie-os conforme as instruções dadas em aula ou copie dos exemplos fornecidos pelo time.

---

## Pré‑requisitos

- Usar **Azure Cloud Shell (Bash)** no portal Azure (não precisa instalar nada local).  
- Ter o **JAR** da sua API **Spring Boot** já gerado (ex.: `safeyard-api-0.0.1-SNAPSHOT.jar`).

---

## 0) Clonar o repositório no Cloud Shell

```bash
git clone https://github.com/<SEU_USUARIO>/<SEU_REPO>.git
cd <SEU_REPO>
```

> Se você já está dentro do repositório, apenas siga para a próxima seção.

---

## 1) Criar a **infraestrutura** no Azure (CLI)

1. **Edite a senha** dentro de `infra/01-variables.env`:  
   - chave: `SQL_ADMIN_PASS` (use uma senha forte)
2. **Carregue as variáveis** e **crie os recursos**:

```bash
# sempre que abrir um shell novo, carregue as variáveis
source infra/01-variables.env

# cria RG, SQL Server, DB, App Service Plan, WebApp e App Settings
bash infra/02-create-resources.sh
```

O script imprime o **host do WebApp** ao final (ex.: `app-safeyard-xxxx.azurewebsites.net`).

---

## 2) Provisionar o **banco** (Azure SQL)

1. No portal Azure, acesse **Azure SQL** → seu **DB** → **Query editor**.  
2. Faça **login** com:
   - **Login**: o definido em `SQL_ADMIN_USER` (padrão `sqladmin`)
   - **Senha**: a definida em `SQL_ADMIN_PASS`
3. **Cole e execute** o conteúdo de `db/script_bd.sql` (cria a tabela obrigatória `Cliente`).

> Se pedir **Set server firewall** para seu IP, aceite e tente novamente.

---

## 3) (Opcional) Dar permissão de **ADMIN** para o seu usuário

- No **Query editor**, abra `db/grant_admin.sql`, **troque o e‑mail** na linha:  
  `DECLARE @login NVARCHAR(150) = N'seu-email@dominio.com';`  
- **Execute** o script. Ele tenta marcar seu usuário como ADMIN (colunas: `admin`, `is_admin`, `role`, `roles`, etc.).

---

## 4) **Deploy** do JAR no App Service

1. **Envie** o JAR para o Cloud Shell (ícone **Arquivos** → **Upload**).  
   Recomendo renomear para `~/safeyard.jar`.
2. **Rode** o script de deploy:

```bash
# Se o JAR foi salvo como ~/safeyard.jar
bash deploy/01-deploy-jar.sh

# OU informe o caminho explicitamente
# bash deploy/01-deploy-jar.sh /caminho/para/seu.jar
```

Esse script:
- Seta `SPRING_PROFILES_ACTIVE=prod` e a porta `8080`
- Define o comando de inicialização do WebApp
- Faz **deploy** do JAR e **reinicia** o WebApp

---

## 5) Logs e **Swagger**

```bash
bash deploy/02-logs-and-swagger.sh
```

Esse script:
- Habilita **application logging (filesystem)**
- Faz **tail** nos logs (Ctrl+C para sair)
- Congela DDL em produção: `SPRING_JPA_HIBERNATE_DDL_AUTO=none`
- Imprime a URL do Swagger: `https://SEU-HOST/swagger-ui/index.html`

---

## 6) **Testes** do CRUD

- Preferencialmente via **Swagger** (faça login, gere o token e chame os endpoints).  
- Opcionalmente pelo arquivo `tests/moto.http`:
  1. Abra e **substitua**:  
     - `@host = https://SEU-HOST-AQUI.azurewebsites.net`  
     - `@token = COLOQUE_SEU_TOKEN_AQUI`
  2. Execute as requisições (com extensões de HTTP client ou ferramentas REST).

> **Requisito da disciplina:** o CRUD deve persistir no **banco na nuvem** (Azure SQL). O Swagger apenas *aciona* a API; os dados **ficam** no Azure SQL (valide no Query editor).

---

## 7) Limpeza (opcional)

Para **remover** todos os recursos:

```bash
source infra/01-variables.env
az group delete -n "$RG" --yes --no-wait
```

---

## Troubleshooting (rápido)

- **403/401** no Swagger/CRUD → gere o token novamente e/ou rode `db/grant_admin.sql` com seu e‑mail.
- **Erro de conexão** → confira App Settings do Web App (`SPRING_DATASOURCE_*`) e a regra **Allow Azure Services** no servidor SQL.
- **H2 não aceito** → o requisito exige banco **na nuvem**; este projeto usa **Azure SQL**.

---

## Licença

Uso acadêmico/educacional.
