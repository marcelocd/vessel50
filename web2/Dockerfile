FROM python:3.11-alpine
# Setup Variables and Group
ENV APP_SERVICE=/django
ENV APP_USER=docker
ENV APP_USER_PW=docker
ENV MOD_PERMISSION=777
# Setting code folder
WORKDIR $APP_SERVICE
# Copy Project
COPY . .
# Setup Environment Variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# Install project dependencies
RUN pip install --upgrade pip
# Install Python Dependencies
RUN pip install -r requirements.txt
# Start the Django application using the Python script
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
