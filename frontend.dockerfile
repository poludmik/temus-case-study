FROM python:3.10-slim

RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc git && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /app

WORKDIR /app

COPY requirements_frontend.txt /app/requirements_frontend.txt
COPY streamlit_app.py /app/streamlit_app.py
COPY GCP/key_service_account.json /app/GCP/key_service_account.json

RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements_frontend.txt

# Set environment variables (if the automatic detection doesn't work later)
# ENV BACKEND="https://backend-c4xxjrjd3q-ew.a.run.app"

# ENV GOOGLE_APPLICATION_CREDENTIALS="GCP/key_service_account.json"

EXPOSE 8080

CMD ["streamlit", "run", "streamlit_app.py", "--server.port", "8080"]
