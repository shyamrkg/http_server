FROM ruby:2.5
## CREATE APP USER ##

# Create the home directory for the new app user.
RUN mkdir -p /home/app

# Create an app user so our program doesn't run as root.
RUN groupadd -r app &&\
    useradd -r -g app -d /home/app -s /sbin/nologin -c "Docker image user" app

# Set the home directory to our app user's home.
ENV HOME=/home/app
ENV APP_HOME=/home/app/my-project

## SETTING UP THE APP ##
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# ***
# Do any custom logic needed prior to adding your code here
# ***

# Copy in the application code.
ADD . $APP_HOME

# Chown all the files to the app user.
RUN chown -R app:app $APP_HOME

# Change to the app user.
USER app
#RUN mkdir -p /var/app
#COPY . /var/app
#WORKDIR /var/app
EXPOSE 8080
CMD ["ruby", "http_server.rb"]
