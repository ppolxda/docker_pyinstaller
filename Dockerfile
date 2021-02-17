# ARG BASE_TAG=3.7-stretch
ARG BASE_TAG=3.8-buster
FROM python:${BASE_TAG}

ENV PYPI_URL=https://pypi.python.org/
ENV PYPI_INDEX_URL=https://pypi.python.org/simple/

RUN useradd -m appuser
USER appuser
# RUN mkdir /home/appuser
# RUN mkdir /home/appuser/.local
# RUN mkdir /home/appuser/.local/bin
# RUN chown -R appuser /home/appuser/
# RUN ls -lha /home/appuser
RUN echo 'export PYUSER_PATH="$HOME/.local"' >> ~/.bashrc
RUN echo 'export PATH="$PYUSER_PATH/bin:$PATH"' >> ~/.bashrc
RUN . ~/.bashrc

RUN pip config set global.index "$PYPI_URL"
RUN pip config set global.index-url "$PYPI_INDEX_URL"
RUN pip install --user pyinstaller staticx -U

VOLUME /src/
WORKDIR /src/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
