FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    WORKS_HOST=0.0.0.0 \
    WORKS_DATA_DIR=/var/data \
    WORKS_SECURE_COOKIE=1

WORKDIR /opt/works

COPY SHIFT_SUPERVISOR_DELUXE_Works_iPhone_Edition_1.2.0.zip /tmp/works.zip

RUN python -c "import zipfile; z=zipfile.ZipFile('/tmp/works.zip'); z.extractall('/opt/works'); z.close()" \
    && test -f /opt/works/SHIFT_SUPERVISOR_DELUXE_Works_iPhone_Edition_1.2.0/server/works_server.py \
    && test -f /opt/works/SHIFT_SUPERVISOR_DELUXE_Works_iPhone_Edition_1.2.0/app/index.html \
    && rm /tmp/works.zip

EXPOSE 10000

CMD ["python", "/opt/works/SHIFT_SUPERVISOR_DELUXE_Works_iPhone_Edition_1.2.0/server/works_server.py", "serve"]
