FROM python:3.9-slim

# Create working dir and install deps
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy service content
COPY service/ ./service/

# Create and switch to non-root user
RUN useradd --uid 1000 theia
RUN chown -R theia /app
USER theia

# run
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]