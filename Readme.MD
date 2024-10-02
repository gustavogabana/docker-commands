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
```

## Docker Swarm é uma ferramenta de orquestração de contêineres que permite gerenciar um cluster de nós Docker como um único sistema virtual. Ele facilita a implementação e o gerenciamento de aplicações em contêineres em larga escala.

### Comandos Docker Swarm

- **`Inicializar um Swarm:`**
  docker swarm init

- **`Adicionar um nó ao Swarm:`**
  docker swarm join --token <token> <IP_DO_MANAGER>:<PORTA>

- **`Listar serviços:`**
  docker service ls

- **`Criar um serviço:`**
  docker service create --name <NOME_SERVIÇO> --replicas <NÚMERO_DE_REPLICAS> <IMAGEM>

```
  docker service create \
    --name giropops \
    --replicas 3 \
    -p 8080:80 \
    --mount type=volume,src=giropops,dst=/usr/share/nginx/html/ \
    --hostname host_um \
    --limit-cpu 0.25 \
    --limit-memory 64M \
    --env variavel=value \
    --dns 8.8.8.8 \
    nginx
  ```

- **`Listar os serviços:`**
  docker service ls

- **`Exibir informações detalhadas sobre o serviço:`**
  docker service ps <NOME_SERVIÇO>

- **`Inspecionar um serviço:`**
  docker service inspect <NOME_SERVIÇO>

- **`Atualizar um serviço:`**
  docker service update --image <NOVA_IMAGEM> <NOME_SERVIÇO>

- **`Escalar um serviço:`**
  docker service scale <service_name>=<replica_count>

- **`Remover um serviço:`**
  docker service rm <NOME_SERVIÇO>

- **`Listar tarefas de um serviço:`**
  docker service ps <NOME_SERVIÇO>

- **`Visualizar logs de um serviço:`**
  docker service logs <NOME_SERVIÇO>

- **`Deixar o modo Swarm:`**
  docker swarm leave --force

### Comandos Docker Node

- **`Listar nós do Swarm:`**
  docker node ls

- **`Promover um nó a manager:`**
  docker node promote <NOME_DO_NO>

- **`Rebaixar um nó de manager para worker:`**
  docker node demote <NOME_DO_NO>

- **`Remover um nó do Swarm:`**
  docker node rm <NOME_DO_NO>

- **`Inspecionar um nó:`**
  docker node inspect <NOME_DO_NO>

- **`Atualizar um nó:`**
  docker node update <opções> <NOME_DO_NO>

  ### 1. `--availability`
  - Modifica a disponibilidade do nó. Pode ser definido como:
    - `active`: O nó pode executar tarefas.
    - `pause`: O nó não pode receber novas tarefas, mas as tarefas existentes continuam a rodar.
    - `drain`: O nó não pode executar novas tarefas e as tarefas existentes são realocadas para outros nós.

    **Exemplo**: 
    docker node update --availability drain <node>

  ### 2. `--label-add`
  - Adiciona uma nova etiqueta ao nó.

    **Exemplo**: 
    docker node update --label-add env=production <node>

  ### 3. `--label-rm`
  - Remove uma etiqueta existente do nó.

    **Exemplo**: 
    docker node update --label-rm env <node>

  ### 4. `--help`
  - Exibe a ajuda para o comando `docker node update`, mostrando as opções disponíveis.

    **Exemplo**: 
    docker node update --help

  ### 5. `--role`
  - Modifica a função do nó, que pode ser `manager` ou `worker`. Para alterar a função de um nó para `manager`, você deve ter permissões de administrador.

    **Exemplo**: 
    docker node update --role manager <node>

# Docker Network

## Descrição

O Docker Network é um componente fundamental do Docker que permite a comunicação entre contêineres, seja no mesmo host ou entre diferentes hosts em um cluster. Ele oferece várias opções para criar e gerenciar redes, possibilitando que contêineres se conectem uns aos outros de maneira segura e eficiente.

### Tipos de Redes

1. **Bridge Network**:
   - A rede padrão criada pelo Docker.
   - Permite que contêineres em um mesmo host se comuniquem entre si.
   - Ideal para aplicações que precisam de isolamento de rede.

2. **Host Network**:
   - O contêiner compartilha a rede do host, sem isolamento.
   - Usado quando é necessário um desempenho máximo e acesso direto à rede do host.

3. **Overlay Network**:
   - Permite a comunicação entre contêineres que estão em diferentes hosts, frequentemente utilizada em ambientes de cluster com Docker Swarm.
   - Proporciona isolamento e segurança.

4. **Macvlan Network**:
   - Permite que contêineres se comportem como dispositivos físicos na rede.
   - Usado quando é necessário um endereço MAC exclusivo para cada contêiner.

### Comandos Comuns

- Criar uma Rede:
  docker network create <network_name>

- Listar Redes:
  docker network ls

- Inspecionar uma Rede:
  docker network inspect <network_name>

- Conectar um Contêiner a uma Rede:
  docker network connect <network_name> <container_name>

- Desconectar um Contêiner de uma Rede:
  docker network disconnect <network_name> <container_name>

- Remover uma Rede:
  docker network rm <network_name>

# Docker Secrets

## Descrição

Docker Secrets é um recurso do Docker Swarm que permite armazenar e gerenciar informações sensíveis, como senhas, chaves de API e certificados, de maneira segura. Os segredos são criptografados e somente contêineres que têm permissão podem acessá-los. Isso ajuda a proteger dados sensíveis durante a execução de aplicações em contêineres.

### Criar um Segredo

Para criar um segredo, use o seguinte comando:

docker secret create <secret_name> <secret_file>

Exemplo:
docker secret create my_secret ./my_secret.txt

### Listar Segredos

Para listar todos os segredos disponíveis no Swarm:

docker secret ls

### Inspecionar um Segredo

Para obter detalhes sobre um segredo específico:

docker secret inspect <secret_name>

### Remover um Segredo

Para remover um segredo:

docker secret rm <secret_name>

### Usar Segredos em um Serviço

Ao criar um serviço, você pode usar segredos da seguinte forma:

docker service create \
  --name my_service \
  --secret my_secret \
  nginx

Os segredos são disponibilizados em contêineres como arquivos no diretório `/run/secrets/`. Por exemplo, o segredo `my_secret` estará acessível em:

/run/secrets/my_secret

# Docker Compose

## Descrição

Docker Compose é uma ferramenta que permite definir e executar aplicações Docker compostas por múltiplos contêineres. Usando um arquivo de configuração (geralmente chamado `docker-compose.yml`), você pode descrever os serviços, redes e volumes necessários para sua aplicação de maneira simples e organizada.

### Características Principais

1. **Definição de Serviços**:
   - Você pode definir múltiplos serviços em um único arquivo, especificando como cada contêiner deve ser configurado, suas imagens, volumes, variáveis de ambiente e dependências.

2. **Facilidade de Uso**:
   - Comandos simples como `docker-compose up` e `docker-compose down` permitem iniciar e parar todos os contêineres de uma aplicação com um único comando, facilitando o gerenciamento do ciclo de vida da aplicação.

3. **Ambientes de Desenvolvimento**:
   - Ideal para configurar ambientes de desenvolvimento locais, onde você pode orquestrar serviços como bancos de dados, servidores web e aplicações de backend de forma coesa e eficiente.

4. **Escalabilidade**:
   - Você pode escalar serviços facilmente, aumentando o número de instâncias de um contêiner com um simples comando, o que é útil para testar a performance e a resiliência da aplicação.

5. **Rede de Serviços**:
   - O Docker Compose cria uma rede interna onde os serviços podem se comunicar entre si, permitindo que você defina quais serviços podem interagir.

6. **Volume de Dados**:
   - Você pode definir volumes persistentes para armazenar dados de forma segura, garantindo que os dados não sejam perdidos quando os contêineres são parados ou removidos.

### Estrutura do Arquivo docker-compose.yml

Um exemplo básico de um arquivo `docker-compose.yml`:
```yaml
version: '3.8'

services:
  web:
    image: nginx
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
    networks:
      - frontend

  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: example
    volumes:
      - db_data:/var/lib/mysql
    networks:
      - backend

networks:
  frontend:
  backend:

volumes:
  db_data:
```
### Comandos Comuns

- Subir os Serviços:
  docker-compose up

- Subir os Serviços em Modo Destacado (detached):
  docker-compose up -d

- Parar os Serviços:
  docker-compose down

- Verificar o Status dos Serviços:
  docker-compose ps

- Escalar um Serviço:
  docker-compose up --scale web=3

- Visualizar os Logs dos Serviços:
  docker-compose logs

- Executar um Comando em um Contêiner:
  docker-compose exec web bash

### Exemplos de Uso

1. **Aplicação Web Simples**:
   - Você pode criar uma aplicação web com Nginx servindo arquivos estáticos e um banco de dados MySQL.

2. **Ambiente de Desenvolvimento**:
   - Utilize o Docker Compose para criar um ambiente de desenvolvimento local que simule seu ambiente de produção, facilitando testes.

3. **Integração Contínua**:
   - Combine o Docker Compose com ferramentas de CI/CD para criar pipelines de integração contínua, onde cada build pode ser feito em um ambiente isolado e consistente.

# Docker Stack

## Descrição

Docker Stack é uma funcionalidade do Docker que permite implantar e gerenciar aplicações multi-contêiner em ambientes de produção, especialmente no contexto do Docker Swarm. Ele permite a definição de uma aplicação composta por múltiplos serviços, redes e volumes, utilizando um único arquivo de configuração chamado `docker-compose.yml`.

### Características Principais

1. **Implantação de Aplicações Complexas**:
   - Permite a orquestração de aplicações que consistem em vários serviços interdependentes.

2. **Gerenciamento Simplificado**:
   - Facilita o gerenciamento do ciclo de vida das aplicações, incluindo a escalabilidade e a atualização dos serviços.

3. **Configuração de Rede**:
   - Configura redes automaticamente, permitindo que os serviços se comuniquem entre si de forma eficiente.

4. **Persistência de Dados**:
   - Suporte para volumes persistentes que garantem que os dados não sejam perdidos mesmo quando os contêineres são removidos.

5. **Configurações de Segurança**:
   - Permite a integração com Docker Secrets para gerenciar informações sensíveis de forma segura.

### Comandos Comuns

- **Implantar um Stack**:
  docker stack deploy -c docker-compose.yml <stack_name>

- **Listar Stacks**:
  docker stack ls

- **Ver Serviços de um Stack**:
  docker stack services <stack_name>

- **Remover um Stack**:
  docker stack rm <stack_name>

- **Ver Logs de um Serviço**:
  docker service logs <service_name>