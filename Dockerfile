FROM python:3.9-alpine3.13
LABEL mainter="davidecastelli.tech"

ENV PYHONUNBUFFURED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    # create the client that we need for the apline img
    apk add --update --no-cache postgresql-client && \
    # install and group all the dep that we need to remove later on   
    apk add --update --no-cache --virtual .tmp-build-deps \
    ## list the depndecies that we need to install the db client 
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    ## remove all the packages that we installed at line 19
    apk del .tmp-build-deps && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user