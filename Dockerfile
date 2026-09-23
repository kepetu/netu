FROM python:3.14-slim

WORKDIR /tmp

COPY run.py appmod.cpython-314-x86_64-linux-gnu.so ./
COPY www ./www/

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssl bash curl && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3000

CMD ["python3", "run.py"]
