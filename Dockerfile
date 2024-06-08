FROM python:3.7-slim

<<<<<<< HEAD
# The environment variable ensures that the python output is set straight
=======
# The enviroment variable ensures that the python output is set straight
>>>>>>> master
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1

ARG PROJECT=lmnad

# Install Package Libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    default-libmysqlclient-dev \
    libfreetype6-dev \
    zlib1g-dev \
    net-tools \
    vim \
    git \
<<<<<<< HEAD
    netcat-traditional \
=======
    netcat \
>>>>>>> master
    gettext \
    && rm -rf /var/lib/apt/lists/*

# Install any needed packages specified in requirements.txt
COPY requirements.txt /tmp/requirements.txt
<<<<<<< HEAD
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r /tmp/requirements.txt \
    && pip install --no-cache-dir kombu==4.6.11 importlib-metadata==2.0.0
=======
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r /tmp/requirements.txt
>>>>>>> master

# Install uwsgi server
RUN pip install --no-cache-dir uwsgi

# set work directory
WORKDIR /$PROJECT

# copy run_app.sh
COPY ./run_app.sh .
RUN sed -i 's/\r//' run_app.sh && chmod +x run_app.sh

# copy project
COPY . .
RUN mv wait-for /bin/wait-for && chmod +x /bin/wait-for

<<<<<<< HEAD
CMD ["/lmnad/run_app.sh"]
=======
CMD ["/lmnad/run_app.sh"]
>>>>>>> master
