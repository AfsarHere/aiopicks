FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=7860

WORKDIR /app

# Copy requirements first for better caching
COPY pyproject.toml README.md ./
COPY app ./app
COPY .env.sample ./

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir .

EXPOSE 7860

# Use PORT from environment for HuggingFace compatibility
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "7860"]
