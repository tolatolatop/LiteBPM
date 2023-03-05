FROM python:3.9-alpine3.16

WORKDIR /usr/src/app

COPY requirements.txt .

RUN pip3 install -r requirements.txt

EXPOSE 8000

COPY lite_bpm .

RUN python3 manage.py migrate

CMD ["python", "manage.py", "0.0.0.0:8000"]
