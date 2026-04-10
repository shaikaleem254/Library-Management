FROM tomcat:9.0
COPY library.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]