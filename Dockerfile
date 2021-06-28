# ARG BASE_TAG=3.7-stretch
ARG BASE_TAG=3.8-buster
FROM python:${BASE_TAG}

ARG PYINSTALLER_UID="1000"
ARG PYINSTALLER_GID="1000"
ARG PYINSTALLER_VERSION=4.2
ARG PYINSTALLER_USER_HOME_DIR=/home/pyinstaller
ARG STATICX_VERSION=0.12.1
ARG PYPI_URL_ARG=https://pypi.python.org/
ARG PYPI_INDEX_URL_ARG=https://pypi.python.org/simple/

ENV PYPI_URL=$PYPI_URL_ARG
ENV PYPI_INDEX_URL=$PYPI_INDEX_URL_ARG
ENV PYINSTALLER_UID=${PYINSTALLER_UID}
ENV PYINSTALLER_GID=${PYINSTALLER_GID}
ENV PYINSTALLER_USER_HOME_DIR=${PYINSTALLER_USER_HOME_DIR}

RUN addgroup --gid "${PYINSTALLER_GID}" "pyinstaller"
RUN useradd -m --uid "${PYINSTALLER_UID}" \
        --gid "${PYINSTALLER_GID}" \
        --home-dir "${PYINSTALLER_USER_HOME_DIR}" pyinstaller

ARG PYINSTALLER_HOME
ENV PYINSTALLER_HOME=${PYINSTALLER_HOME}
USER ${PYINSTALLER_UID}

# RUN mkdir /home/appuser
# RUN mkdir /home/appuser/.local
# RUN mkdir /home/appuser/.local/bin
# RUN chown -R appuser /home/appuser/
# RUN ls -lha /home/appuser
RUN echo $HOME/.local
RUN id -u
RUN echo 'export PYUSER_PATH="$HOME/.local"' >> ~/.bashrc
RUN echo 'export PATH="$PYUSER_PATH/bin:$PATH"' >> ~/.bashrc
RUN . ~/.bashrc

RUN pip config set global.index "$PYPI_URL"
RUN pip config set global.index-url "$PYPI_INDEX_URL"
RUN pip install --user pyinstaller==$PYINSTALLER_VERSION staticx==$STATICX_VERSION -U --no-warn-script-location
RUN python --version

VOLUME /src/
WORKDIR /src/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
