FROM python:3.11

RUN mkdir /app
WORKDIR /app/

RUN pip install --upgrade pip
RUN pip install poetry
COPY pyproject.toml /app/
COPY poetry.lock /app/

# Create a virtualenv within the app directory. Poetry will use this and not create its own
RUN python -m venv /app/.venv
RUN poetry install --no-interaction --no-ansi
COPY planeten /app/planeten
COPY docker-entrypoint.sh /app/
ENTRYPOINT ["/app/docker-entrypoint.sh"]

RUN SECRET_KEY=yolo ./docker-entrypoint.sh django collectstatic --noinput
CMD ["gunicorn"]
