## 7. Dockerfile

### O que é um Dockerfile?

Um **Dockerfile** é um arquivo de texto que contém uma série de instruções para construir uma imagem Docker. Essas instruções definem o ambiente que a imagem deve ter, incluindo o sistema operacional base, as dependências e os arquivos que devem ser incluídos.

### Como usar um Dockerfile

1. **Crie um arquivo chamado `Dockerfile`** no diretório onde você deseja construir a imagem.
2. **Adicione instruções** ao Dockerfile para definir o ambiente da imagem.
3. **Construa a imagem** usando o comando `docker build`.

### Principais Instruções do Dockerfile

- **`FROM [imagem]`**
  - **Descrição**: Define a imagem base a partir da qual você está construindo sua imagem.
  - **Exemplo**: `FROM ubuntu:20.04`

- **`RUN [comando]`**
  - **Descrição**: Executa um comando durante o processo de construção da imagem. Usado para instalar pacotes ou configurar o ambiente.
  - **Exemplo**: `RUN apt-get update && apt-get install -y python3`

- **`COPY [origem] [destino]`**
  - **Descrição**: Copia arquivos ou diretórios do contexto de construção para o sistema de arquivos da imagem.
  - **Exemplo**: `COPY ./app /usr/src/app`

- **`ADD [origem] [destino]`**
  - **Descrição**: Similar ao `COPY`, mas também pode extrair arquivos de arquivos tar e baixar arquivos de URLs.
  - **Exemplo**: `ADD https://example.com/file.tar.gz /app/`

- **`WORKDIR [diretório]`**
  - **Descrição**: Define o diretório de trabalho para as instruções seguintes.
  - **Exemplo**: `WORKDIR /usr/src/app`

- **`CMD [comando]`**
  - **Descrição**: Define o comando padrão a ser executado quando um contêiner é iniciado a partir da imagem. Pode ser substituído ao iniciar o contêiner.
  - **Exemplo**: `CMD ["python3", "app.py"]`

- **`ENTRYPOINT [comando]`**
  - **Descrição**: Define o comando que será executado quando o contêiner iniciar. Diferente de `CMD`, não pode ser substituído facilmente.
  - **Exemplo**: `ENTRYPOINT ["python3"]`

- **`ARG [variável]`**
  - **Descrição**: Define variáveis que podem ser passadas durante a construção da imagem. As variáveis definidas com `ARG` são acessíveis apenas durante o processo de construção e não estão disponíveis em tempo de execução no contêiner.
  - **Exemplo**: 
    ```dockerfile
    ARG MY_VAR=default_value
    RUN echo "O valor de MY_VAR é: $MY_VAR"
    ```
  - **Como usar**: Você pode passar um valor para a variável ao construir a imagem usando `--build-arg`:
    ```bash
    docker build --build-arg MY_VAR=HelloWorld -t my_image .
    ```

- **`ENV [variável]=[valor]`**
  - **Descrição**: Define variáveis de ambiente que estarão disponíveis para os processos executados dentro do contêiner.
  - **Exemplo**: `ENV APP_ENV=production`

- **`EXPOSE [porta]`**
  - **Descrição**: Documenta a porta que o contêiner escuta em tempo de execução. Não expõe a porta, mas é uma boa prática para documentação.
  - **Exemplo**: `EXPOSE 80`

- **`VOLUME [caminho]`**
  - **Descrição**: Cria um ponto de montagem para um volume no contêiner. Útil para persistir dados.
  - **Exemplo**: `VOLUME ["/data"]`

### Exemplo de Dockerfile

Aqui está um exemplo simples de um Dockerfile:

```dockerfile
# Usa a imagem base do Python
FROM python:3.8-slim

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos de aplicação para o contêiner
COPY . /app

# Instala dependências
RUN pip install -r requirements.txt

# Define o comando para rodar a aplicação
CMD ["python", "app.py"]
