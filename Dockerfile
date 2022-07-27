FROM tomcat:8.5.81-jre17
COPY target/*.war /usr/local/tomcat/webapps
