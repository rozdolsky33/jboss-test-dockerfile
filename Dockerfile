FROM jboss/base-jdk:7
ADD jboss-eap-6.3.0.zip /tmp/
RUN unzip /tmp/jboss-eap-6.3.0.zip -d /opt/jboss

# Add EAP_HOME environment variable, to easily upgrade the script for different EAP versions
ENV EAP_HOME /opt/jboss/jboss-eap-6.3

# Add default admin user
RUN ${EAP_HOME}/bin/add-user.sh admin admin123! --silent

# Enable binding to all network interfaces and debugging inside the EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> ${EAP_HOME}/bin/standalone.conf

# Set Permission
RUN chown -R jboss:jboss "$EAP_HOME"

WORKDIR "$EAP_HOME"

# Add volume if you want to externalize logs
VOLUME ${EAP_HOME}/standalone/logs
USER jboss

EXPOSE 9990 9999 8080 8787

ENTRYPOINT ["/opt/jboss/jboss-eap-6.3/bin/standalone.sh"]
CMD []
