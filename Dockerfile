# Define variável de ambiente para porta
ARG PORT=443
ENV PORT=${PORT}

# Usa imagem base com navegador
FROM cypress/browsers:latest

# Atualiza pacotes e instala Python e pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Define diretório de trabalho
WORKDIR /app

# Copia dependências e instala
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Copia o restante dos arquivos
COPY . /app

# Expõe a porta
EXPOSE ${PORT}

# Comando para rodar o app com gunicorn
CMD ["gunicorn", "main:app", "--bind", "0.0.0.0:443"]
