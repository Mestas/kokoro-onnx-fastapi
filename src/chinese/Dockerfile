# # 使用官方 Python 运行时作为父镜像
# FROM python:3.12-slim

# # 安装 uv
# RUN pip install uv

# # 设置工作目录
# WORKDIR /app

# # 安装依赖
# # COPY requirements.txt .
# # RUN uv pip install --no-cache-dir -r requirements.txt --system

# # 复制应用代码到工作目录
# COPY src/chinese /app
# # COPY main.py .
# # COPY cache.py .
# # COPY download_deps.py .
# # COPY . . # 或者直接复制所有内容，如果确定没有其他不必要的文件

# # 创建模型和音频输出目录 (这些目录将通过 docker-compose volumes 映射)
# # 在 Dockerfile 中创建可以确保它们在容器内部存在，即使卷没有立即挂载或用于其他目的。
# RUN mkdir -p /app/models && mkdir -p /app/generated_audio

# # 暴露应用运行的端口
# EXPOSE 8210

# # 定义环境变量（可选，但有时有用）
# # ENV PYTHONPATH=/app

# # 运行 FastAPI 应用
# # 注意：download_deps.py 会在 main.py 启动时运行以下载模型
# # CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
# # 使用 uv run python main.py 确保依赖下载逻辑被触发
# CMD ["uv", "run", "python", "main.py"] 


# ---- 基础镜像 ----
FROM python:3.12-slim

# ---- 系统依赖 ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ---- 工作目录 ----
WORKDIR /app

# ---- 复制依赖文件 ----
COPY src/chinese/requirements.txt /app/

# ---- 安装 Python 依赖 ----
RUN pip install --no-cache-dir -r requirements.txt

# ---- 复制源码 ----
COPY src/chinese /app        # 把 src/chinese 整个目录放进 /app
# 如果 requirements.txt 也在 src/chinese 就改成 COPY src/chinese/requirements.txt /app/

# ---- 暴露端口（Railway 会注入 $PORT）----
ENV PORT=8210
EXPOSE 8210

# ---- 启动命令 ----
# 注意：文件在 /app 下，因此 app 实例是 main:app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
