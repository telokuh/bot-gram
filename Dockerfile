FROM python:3.9

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install ffmpeg -y

WORKDIR .
COPY . .

RUN pip3 install -r requirements.txt
RUN chmod +x start.sh
CMD ["./start.sh"]
EXPOSE 8080
