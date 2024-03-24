FROM ubuntu:latest
COPY app.sh /app/
WORKDIR /app
RUN apt-get update && apt-get install -y curl
RUN chmod +x app.sh
CMD ["/bin/bash", "/app/app.sh"]