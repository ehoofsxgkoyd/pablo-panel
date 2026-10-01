FROM python:3.10-slim

WORKDIR /app

# نصب پیش‌نیازها، انجین‌اکس و هسته رسمی Xray
RUN apt-get update && apt-get install -y nginx wget unzip procps curl && \
    rm -rf /etc/nginx/sites-enabled/* /etc/nginx/conf.d/* && \
    mkdir -p /usr/local/bin/xray /run /var/log/nginx && \
    wget -q https://github.com/XTLS/Xray-core/releases/download/v1.8.11/Xray-linux-64.zip && \
    unzip -q Xray-linux-64.zip -d /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray/xray && \
    rm Xray-linux-64.zip && \
    apt-get clean

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=8080
EXPOSE 8080

CMD ["python", "app.py"]
