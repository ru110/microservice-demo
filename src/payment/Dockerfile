FROM python:3.9

EXPOSE 8080
USER root

ENV INSTANA_SERVICE_NAME=payment

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install opentelemetry-sdk install opentelemetry-api
RUN pip3 install opentelemetry-instrumentation opentelemetry-exporter-jaeger opentelemetry-instrumentation-flask
#RUN pip install opentelemetry-instrumentation  
#RUN pip install opentelemetry-exporter-jaeger
#RUN pip install opentelemetry-instrumentation-flask
COPY *.py /app/
COPY payment.ini /app/

CMD ["python", "payment1.py"]
#CMD ["uwsgi", "--ini", "payment.ini"]

