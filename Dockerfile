FROM tomcat:8.5-jre8
COPY target/*.war /usr/local/tomcat/webapps
