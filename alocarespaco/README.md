# Alocação de Espaço — Guia de Configuração

## Pré-requisitos
- Java JDK 11 ou superior
- Apache Tomcat 9 ou 10
- MySQL 8.0
- Maven 3.x

## Extensões recomendadas no VS Code
Instale pelo painel de extensões (Ctrl+Shift+X):

| Extensão                        | Para quê serve                          |
|---------------------------------|-----------------------------------------|
| Extension Pack for Java         | Suporte completo a Java                 |
| Spring Boot Extension Pack      | Facilita rodar projetos Java web        |
| Tomcat for Java                 | Integração com Tomcat dentro do VS Code |
| Community Server Connectors     | Alternativa ao Tomcat (servidor local)  |
| XML                             | Destaque de sintaxe para web.xml        |
| MySQL (cweijan)                 | Gerenciar o banco direto pelo VS Code   |

## Passos para rodar

### 1. Banco de dados
Abra o MySQL e execute o script:
```
mysql -u root -p < banco.sql
```
Ou cole o conteúdo de `banco.sql` no MySQL Workbench e execute.

### 2. Configurar conexão
Edite o arquivo:
```
src/main/java/br/com/locacao/dal/ConnectionFactory.java
```
Altere as linhas:
```java
private static final String USUARIO = "root";
private static final String SENHA   = ""; // coloque sua senha aqui
```

### 3. Compilar com Maven
No terminal do VS Code (Ctrl+`):
```
mvn clean package
```
Isso gera o arquivo `target/alocarespaco.war`

### 4. Rodar no Tomcat
- Instale a extensão **Tomcat for Java** no VS Code
- Clique no ícone do Tomcat na barra lateral
- Adicione seu Tomcat local
- Clique com botão direito no `.war` → "Run on Tomcat Server"
- Acesse: http://localhost:8080/alocarespaco

## Login padrão
- E-mail: `admin@admin.com`
- Senha: `admin123`

## Estrutura do projeto
```
alocarespaco/
├── banco.sql                          ← script do banco
├── pom.xml                            ← dependências Maven
└── src/main/
    ├── java/br/com/locacao/
    │   ├── controller/                ← Servlets (LoginController, etc.)
    │   ├── dal/                       ← ConnectionFactory (conexão MySQL)
    │   ├── dao/                       ← acesso ao banco (CRUD)
    │   └── model/                     ← classes de dados
    └── webapp/
        ├── css/estilo.css             ← estilos globais
        ├── WEB-INF/web.xml            ← mapeamento de servlets
        ├── login.jsp
        ├── menu.jsp                   ← sidebar (incluída em todas as páginas)
        ├── index.jsp                  ← dashboard
        ├── clientes.jsp
        ├── espacos.jsp
        ├── reservas.jsp
        ├── servicos.jsp
        ├── listagem.jsp
        └── logout.jsp
```
