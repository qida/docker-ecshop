FROM tenxcloud.com/sunqida/base-apache-php
# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Configure /app folder with sample app
RUN mkdir -p /app/kod && rm -fr /var/www/html && ln -s /app /var/www/html
RUN git clone https://github.com/kalcaddle/KODExplorer.git /app/kod
#RUN mkdir -p /app/upload
#VOLUME /app/upload
#download ecshop
WORKDIR /app
ADD http://7xo5s9.dl1.z0.glb.clouddn.com/ecshop-2.7.3.zip /app
RUN unzip /app/ecshop-2.7.3.zip -d /app
EXPOSE 80
CMD ["/run.sh"]
