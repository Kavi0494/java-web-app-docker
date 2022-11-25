FROM tomcat:latest
# Dummy text to test 
COPY /var/lib/jenkins/workspace/Java-web-jenkins/target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app.war
