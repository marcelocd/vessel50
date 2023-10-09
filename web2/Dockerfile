FROM python:3.11-alpine

RUN ls -la > /um_arquivo.txt

# Install project dependencies
RUN pip install --upgrade pip
# Install Python Dependencies
RUN pip install -r requirements.txt
# Start the Django application using the Python script
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
