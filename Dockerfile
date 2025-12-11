# ---- 基础镜像 ----
FROM python:3.11-slim

# ---- 系统依赖（可选，加速构建） ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ---- 工作目录 ----
WORKDIR /app

# ---- 先拷依赖文件，利用 Docker 缓存 ----
COPY requirements.txt ./

# ---- 安装 Python 依赖 ----
RUN pip install --no-cache-dir -r requirements.txt

# ---- 把源码整目录拷进来 ----
COPY src/chinese ./

# 如果还需要模型权重，也在这行后面 COPY 进来
# COPY models ./models

# ---- 暴露端口（Railway 会注入 $PORT）----
ENV PORT=8000
EXPOSE 8000

# ---- 启动命令 ----
# 文件现在在 /app 下，因此 app 实例是 main:app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
