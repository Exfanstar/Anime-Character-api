FROM python:3.12-alpine
LABEL maintainer="UdehChinecherem"

ENV PYTHONUNBUFFERED 1

WORKDIR /app

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

ARG  DEV=false
RUN python -m venv /py &&\
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser -D -H django-user

COPY ./app /app

ENV PATH="/py/bin:$PATH"

USER django-user

EXPOSE 8000
