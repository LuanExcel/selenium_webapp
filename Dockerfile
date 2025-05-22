ARG PORT = 443
FROM cypress/browsers:latest
RUN apt-get install python 3-y
RUN echo $(python3 -m site --user-base)
COPY requirements.txt
ENV PTH /home/root/.local/bin:${PATH}
RUN apt-ge update && apt-get install -y python3-pip && install -r requirements.txt
COPY . .
CMD unicorn main:app --host 0.0.0.0 --port $PORT