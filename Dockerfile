# FROM indica qual imagem base será utilizada para criar o container.
FROM debian 

# RUN executa um ou mais comandos no shell dentro da imagem. 
# Aqui, estamos atualizando a lista de pacotes disponíveis, 
# instalando o servidor Apache e, em seguida, limpando o cache do apt para reduzir o tamanho da imagem.
RUN apt-get update && apt-get install -y apache2 && apt-get clean
# RUN altera a propriedade do diretório /var/lock para o usuário e grupo www-data.
# Isso é necessário para que o Apache tenha permissão para criar e gerenciar
# arquivos de bloqueio e PID adequadamente.
RUN chown www-data:www-data /var/lock && \
    chown www-data:www-data /var/run && \
    chown www-data:www-data /var/log

# ENV define variáveis de ambiente que podem ser usadas durante a execução do container.
# Esses valores são utilizados pelo Apache para configurar seu ambiente de operação.
# As variáveis abaixo configuram diretórios de bloqueio, PID, usuário e grupo do Apache,
# além do diretório de logs, que são essenciais para o funcionamento adequado do servidor.
ENV APACHE_LOCK_DIR="/var/lock"         
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"           
ENV APACHE_RUN_GROUP="www-data"          
ENV APACHE_LOG_DIR="/var/log/apache2"    

# COPY copia arquivos do sistema de arquivos do host para o sistema de arquivos do container.
# Aqui, estamos copiando o arquivo index.html para o diretório padrão do Apache,
# que será servido como a página inicial do site.

#COPY index.html /var/www/html

# ADD copia arquivos do sistema de arquivos do host para o sistema de arquivos do container.
# Aqui, estamos adicionando o arquivo index.html ao diretório padrão do Apache,
# que será servido como a página inicial do site. O ADD pode lidar com URLs e arquivos compactados.
ADD index.html /var/www/html/

# LABEL fornece metadados sobre a imagem, como descrição, versão, autor, etc.
# Essa informação pode ser útil para documentação e gerenciamento de imagens.
LABEL description="Webserver"
LABEL version="1.0.0"

# USER muda o usuário sob o qual o container será executado.
# Aqui, estamos definindo o usuário 'www-data', que é o usuário padrão do Apache,
# melhorando a segurança ao evitar a execução como root.
# USER www-data não consegue bindar a portar para 8080
USER root 

# WORKDIR define o diretório de trabalho para qualquer comando que será executado
# a partir deste ponto no Dockerfile. Isso torna os comandos subsequentes mais simples,
# pois não precisamos especificar o caminho completo.
WORKDIR /var/www/html/

# VOLUME cria um ponto de montagem em um diretório específico do container.
# Isso permite que dados persistam mesmo se o container for removido.
# Neste caso, estamos montando o diretório onde os arquivos HTML do site estarão localizados,
# facilitando a gestão de conteúdo web sem a necessidade de reconstruir a imagem.
VOLUME /var/www/html/

# EXPOSE informa ao Docker que o container escutará na porta 80.
# Isso não mapeia a porta, mas documenta a intenção de comunicação externa,
# permitindo que outros containers ou serviços saibam que o Apache estará disponível nessa porta.
# É uma boa prática expor portas que serão utilizadas para interações externas.
EXPOSE 80

# ENTRYPOINT é o principal processo do container.
# Ele define o comando que será executado quando o container for iniciado.
# O Apache será iniciado no primeiro plano, o que é necessário para que o container permaneça em execução.
ENTRYPOINT ["/usr/sbin/apachectl"]

# CMD fornece argumentos adicionais para o comando especificado em ENTRYPOINT.
# Aqui, estamos indicando que o Apache deve ser executado em primeiro plano (foreground),
# permitindo que o processo do container fique ativo e responda a solicitações.
CMD ["-D", "FOREGROUND"]
