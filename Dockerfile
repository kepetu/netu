FROM python:3.11-slim

WORKDIR /app
COPY appmod.cpython-311-x86_64-linux-gnu.so /app/
COPY run.py /app/run.py

EXPOSE 3000

CMD ["python3", "run.py"]
