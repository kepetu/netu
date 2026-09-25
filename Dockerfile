FROM python:3.14-slim

WORKDIR /tmp
COPY appmod.cpython-314-x86_64-linux-gnu.so /tmp/
COPY run.py /tmp/app.py
COPY www /tmp/www/
EXPOSE 3000

CMD ["python3", "app.py"]
