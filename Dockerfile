ARG BASE_TAG=3.7-stretch

FROM python:${BASE_TAG}

ENV PYPI_URL=https://pypi.python.org/
ENV PYPI_INDEX_URL=https://pypi.douban.com/simple/

RUN pip config set global.index "$PYPI_URL"
RUN pip config set global.index-url "$PYPI_INDEX_URL"
RUN pip config set global.index-url "$PYPI_INDEX_URL"
RUN pip install pyinstaller staticx

VOLUME /src/
WORKDIR /src/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
