FROM python:latest
COPY make_changes.py .
RUN apt-get update \
    && apt-get install -y python3-dev \
    && apt-get install -y libpq-dev \
    && pip install psycopg2 \
    && pip install mysql-connector-python
CMD ["python", "make_changes.py"]
