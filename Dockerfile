# Base image
FROM python:3.12-slim


# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /sentiment

# Copy and install Python dependencies
COPY requirements.txt requirements.txt
RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code
COPY ./app ./app

# Install Python dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# Copy NGINX configuration
COPY nginx.conf /etc/nginx/sites-available/default

# Expose ports
# 80 for NGINX, 8000 for Gunicorn
EXPOSE 80 8000

# Copy Gunicorn configuration file
COPY gunicorn_config.py /sentiment/gunicorn_config.py


# Start Gunicorn and NGINX and run the application
CMD ["sh", "-c", "service nginx start && gunicorn -k uvicorn.workers.UvicornWorker -c /sentiment/gunicorn_config.py app.main:app"]
