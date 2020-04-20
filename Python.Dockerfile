FROM python:3.7.3-slim as base

# Makes apt noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONPATH=/backend/

RUN pip install --upgrade --upgrade-strategy only-if-needed "pip==19.2.3" "virtualenv==16.7.9" "pipenv==2018.11.26"

RUN addgroup --gid 2000 python \
  && adduser --uid 2000 --gid 2000 --disabled-password \
  --home /home/python --shell /bin/sh \
  --gecos "Python runtime user" python

# Home workdir
ENV HOME /backend/
WORKDIR /backend/
COPY Pipfile Pipfile.lock /backend/
RUN pipenv install
COPY . /backend/
USER 2000:2000
CMD ["pipenv", "run", "python", "app.py"]