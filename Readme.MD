# Cheatsheet Docker

## 1. Informações e Configurações

- `docker --version`
  - Exibe a versão do Docker instalada.

- `docker info`
  - Fornece informações detalhadas sobre a instalação do Docker, incluindo configurações do sistema, versão do servidor e informações sobre contêineres e imagens.

- `docker version`
  - Exibe as versões do Docker Client e do Docker Server.

## 2. Imagens

- `docker image pull [imagem]`
  - Baixa uma imagem do Docker Hub ou de um registro especificado.

- `docker image build -t [nome-imagem]:[tag] [diretório]`
  - Constrói uma nova imagem a partir de um Dockerfile no diretório especificado. A tag é opcional e ajuda na versão da imagem.

- `docker images` ou `docker image ls`
  - Lista todas as imagens locais, incluindo informações sobre tags, IDs e tamanhos.

- `docker rmi [imagem]`
  - Remove uma ou mais imagens. Use `-f` para forçar a remoção de imagens que estão sendo utilizadas por contêineres.

- `docker image tag [imagem]:[tag] [novo-nome]:[nova-tag]`
  - Marca uma imagem existente com um novo nome e/ou tag.

- **`docker commit [opções] <container_id> <nome_da_imagem>:<tag>`**
  - Cria uma nova imagem a partir de um contêiner existente.
  - **Exemplo**: 
    ```bash
    docker commit -m "Adicionando o servidor Apache" meu_container minha_imagem:1.0
    ```
  - **Opções**:
    - `-m "mensagem"`: Adiciona uma mensagem de commit.
    - `-a "autor"`: Define o autor da imagem.

## 3. Contêineres

- `docker container run [opções] [imagem] [comando]`
  - Cria e inicia um contêiner a partir de uma imagem. Exemplos de opções:
    - `-d`: executa o contêiner em modo destacado.
    - `-ti`: o -it no Docker combina as opções -i (interativa) e -t (pseudo-terminal), permitindo que você execute um contêiner de forma interativa, com acesso ao terminal e entrada padrão.
    - `-p [porta_host]:[porta_container]`: mapeia portas.
    - `--name [nome]`: dá um nome ao contêiner.

- `docker container ls`
  - Lista contêineres em execução.

- `docker container ls -a`
  - Lista todos os contêineres, incluindo os parados.

- `docker container stop [contêiner]`
  - Para um contêiner em execução.

- `docker container start [contêiner]`
  - Inicia um contêiner parado.

- `docker container attach [contêiner]`
  - Conecta com um contêiner em execução.

- `docker container restart [contêiner]`
  - Reinicia um contêiner.

- `docker container rm [contêiner]`
  - Remove um ou mais contêineres. Use `-f` para forçar a remoção de contêineres em execução.

- `docker container exec -it [contêiner] [comando]`
  - Executa um comando em um contêiner em execução. O `-it` permite interação no terminal.

- `docker container logs -f [contêiner]`
  - Exibe os logs de um contêiner.

- `docker container stats [contêiner]`
  - Mostra o status do contêiner.

- `docker container top [contêiner]`
  - Exibe os processos que estão executando dentro do contêiner.
  - `--format` para formatar o output "table {{.PID}}\t{{.USER}}\t{{.COMMAND}}"

- `docker container update [opções] [contêiner]`
  - Usado para atualizar as configurações de um contêiner em execução.
  - `--cpu-shares:` Define a prioridade da CPU (valor numérico).
  - `--memory:` Define a quantidade máxima de memória (por exemplo, 512m para 512 megabytes).
  - `--restart:` Altera a política de reinício do contêiner.
  - `--cpus:` Limita o número de CPUs disponíveis para o contêiner.

- `docker container prune`
  - Remove todos os contêineres parados no docker.

## 4. Volumes

- `docker container run -ti --mount type=tipo,src=origem,dst=destino [imagem]`
  - `--mount`: Usado para especificar o tipo de montagem.
  - `type`: Pode ser bind, volume ou tmpfs.
  - `src/source`: O caminho da origem. Para bind, é o caminho no host. Para volume, é o nome do volume.
  - `dst/destination`: O caminho onde a origem será montada dentro do contêiner.
  - `ro`: Opção de Read Only

- `docker volume create [nome-volume]`
  - Cria um novo volume para persistência de dados.

- `docker volume ls`
  - Lista todos os volumes disponíveis.

- `docker volume rm [volume]`
  - Remove um ou mais volumes.

- `docker inspect [volume]`
  - Exibe detalhes sobre um volume, incluindo informações de configuração e uso.

- `docker volume prune`
  - Remove todos os volumes que não estiverem sendo utilizados por algum contêiner.

## 5. Redes

- `docker network create [nome-rede]`
  - Cria uma nova rede para contêineres.

- `docker network ls`
  - Lista todas as redes disponíveis.

- `docker network rm [rede]`
  - Remove uma rede, se não houver contêineres conectados.

- `docker network inspect [rede]`
  - Exibe detalhes sobre uma rede, incluindo contêineres conectados.

## 6. Docker Compose

- `docker-compose up`
  - Inicia e executa os serviços definidos no `docker-compose.yml`. Use `-d` para executar em modo destacado.

- `docker-compose down`
  - Para e remove os contêineres e redes criados pelo `docker-compose up`.

- `docker-compose build`
  - Constrói as imagens definidas no `docker-compose.yml`.

- `docker-compose logs`
  - Exibe logs dos serviços em execução.

- `docker-compose ps`
  - Lista os contêineres gerenciados pelo Docker Compose.

- `docker-compose exec [serviço] [comando]`
  - Executa um comando em um serviço em execução.

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
