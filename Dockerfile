# Usa imagem base com navegador
FROM cypress/browsers:latest

# Define variável de build e de ambiente
ARG PORT=443
ENV PORT=${PORT}

# Instala dependências
RUN apt-get update && apt-get install -y python3 python3-pip

# Define caminho do Python local
RUN echo $(python3 -m site --user-base)

# Copia os arquivos necessários
COPY requirements.txt /app/requirements.txt
WORKDIR /app

# Instala pacotes do requirements
RUN pip3 install -r requirements.txt

# Copia o restante do código
COPY . .

# Executa o app
CMD ["gunicorn", "main:app", "--host", "0.0.0.0", "--port", "${PORT}"]

