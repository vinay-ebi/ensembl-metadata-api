FROM python:3.9.6-slim-buster
RUN apt-get update && apt-get install -y \
  default-libmysqlclient-dev \
  gcc \
  && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home appuser
USER appuser
WORKDIR /home/appuser

# Copying actuall application
COPY . /home/appuser

RUN python -m venv /home/appuser/venv
ENV PATH="/app/src/venv/bin:/home/appuser/.local/bin:$PATH"
RUN pip install -r requirements.txt
RUN pip install .

CMD ["/usr/local/bin/python", "-m", "ensembl.production.metadata_api.app.main"]
