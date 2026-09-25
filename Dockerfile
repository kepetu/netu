FROM python:3.14-slim

WORKDIR /app
COPY appmod.cpython-314-x86_64-linux-gnu.so /app/
COPY run.py /app/app.py
COPY www /app/www/
EXPOSE 3000

CMD ["python3", "app.py"]
