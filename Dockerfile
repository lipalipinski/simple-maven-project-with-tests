FROM sapmachine:17.0.6
WORKDIR /opt/app
COPY /target/*.jar app.jar
EXPOSE 8080
CMD [ "java", "-jar", "app.jar" ]