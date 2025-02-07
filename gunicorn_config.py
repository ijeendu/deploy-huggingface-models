bind = "0.0.0.0:8000"
workers = 4  # Number of worker processes
threads = 2  # Threads per worker
worker_class = "uvicorn.workers.UvicornWorker"
timeout = 120
