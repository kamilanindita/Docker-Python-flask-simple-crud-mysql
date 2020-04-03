FROM python:3.8.1-alpine3.11

RUN apk add --update --no-cache mariadb-connector-c-dev \
	&& apk add --no-cache --virtual .build-deps \
		mariadb-dev \
		gcc \
		musl-dev \
	&& pip install mysqlclient==1.4.6 \
	&& apk del .build-deps

ENV FLASK_APP "server.py"
ENV FLASK_ENV "development"
ENV FLASK_DEBUG True

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt
EXPOSE 5000
CMD flask run --host=0.0.0.0