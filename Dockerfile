FROM cypress/browsers:latest

ARG PORT=443
ENV PORT=${PORT}

RUN apt-get update && apt-get install -y python3 python3-venv python3-pip

WORKDIR /app

COPY requirements.txt .

# Cria e ativa ambiente virtual e instala dependências
RUN python3 -m venv venv
RUN ./venv/bin/pip install --upgrade pip
RUN ./venv/bin/pip install -r requirements.txt

COPY . .

CMD ["./venv/bin/gunicorn", "main:app", "--host", "0.0.0.0", "--port", "${PORT}"]


