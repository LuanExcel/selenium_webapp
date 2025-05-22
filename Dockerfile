FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Instala dependências do Chrome
RUN apt-get update && apt-get install -y wget gnupg2 curl unzip xvfb \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y google-chrome-stable

# Cria diretório
WORKDIR /app

# Copia e instala dependências Python
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copia o código
COPY . .

# Porta default
ENV PORT=8080

# Executa
CMD ["gunicorn", "main:app", "--bind", "0.0.0.0:$PORT"]
