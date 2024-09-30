# Multi-stage build permite criar imagens Docker mais leves, 
# separando a construção do aplicativo da execução. 
# Isso significa que podemos usar uma imagem mais pesada (como golang) para 
# construir o aplicativo e, em seguida, copiar apenas o binário para uma 
# imagem mais leve (como alpine), reduzindo o tamanho final da imagem.

# Define a imagem base como golang e nomeia o estágio de construção como "buildando"
FROM golang:1.20 AS buildando

# Define o diretório de trabalho dentro do container para /app
WORKDIR /app
# Copia todos os arquivos do diretório atual para o diretório de trabalho no container
ADD . /app
# Desativa o uso de módulos
RUN go env -w GO111MODULE=off
# Compila o aplicativo Go e gera um binário chamado "meugo"
RUN go build -o meugo

# Inicia um novo estágio com uma imagem base leve (alpine)
FROM alpine
# Define o diretório de trabalho no novo estágio para /app
WORKDIR /app
# Copia o binário "meugo" do estágio de construção para o novo estágio
COPY --from=buildando /app/meugo /app
# Define o ponto de entrada do container para executar o binário "meugo"
ENTRYPOINT ./meugo
