FROM tomcat:9.0

RUN rm -rf /usr/local/tomcat/webapps/*

COPY LibraryManagementSystems/src/main/webapp /usr/local/tomcat/webapps/ROOT

EXPOSE 8080

CMD ["catalina.sh", "run"]