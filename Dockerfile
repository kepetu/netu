# 多阶段构建：builder 现场编译 .so（ABI 与运行时镜像同源），runtime 只带产物
# 产物：~97KB .so；运行时无源码、无编译器、无混淆器依赖
# 用法：docker build -t gw . && docker run -e PORT=3000 -p 3000:3000 gw

FROM python:3.14-slim AS build

RUN apt-get update && apt-get install -y --no-install-recommends gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir cython setuptools

WORKDIR /build
COPY app_obf.py appmod.py
COPY setup.py setup.py
RUN CFLAGS="-O2" python3 setup.py build_ext --inplace

FROM python:3.14-slim

WORKDIR /app
COPY --from=build /build/appmod.cpython-314-x86_64-linux-gnu.so /app/
COPY run.py /app/run.py

# 平台注入 PORT 时自动生效，缺省 3000
ENV PORT=3000
EXPOSE 3000

CMD ["python3", "run.py"]
