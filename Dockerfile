#FROM ubuntu:trusty
#MAINTAINER Allen <sunqida@foxmail.com>
# Install base packages
#RUN apt-get update && \
#    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
#        git \
#        zip \
#        curl \
#        apache2 \
#        libapache2-mod-php5 \
#        php5-mysql \
#        php5-mcrypt \
#        php5-gd \
#        php5-curl \
#        php-pear \
#        php-apc && \
#    rm -rf /var/lib/apt/lists/* && \
#    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#RUN /usr/sbin/php5enmod mcrypt
#RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
#    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
#ENV ALLOW_OVERRIDE **False**
# 

FROM daocloud.io/sunqida/base-apache-php:master-init
# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Configure /app folder with sample app
RUN mkdir -p /app/kod && rm -fr /var/www/html && ln -s /app /var/www/html

#download ecshop
ADD http://7xo5s9.dl1.z0.glb.clouddn.com/ecshop-2.7.4.beta1.zip /app/
RUN unzip /app/ecshop-2.7.4.beta1.zip -d /app
RUN git clone https://github.com/kalcaddle/KODExplorer.git /app/kod
RUN rm -Rf /app/kod/.git
RUN mkdir -p /app/upload
VOLUME /app/upload
WORKDIR /app
EXPOSE 80
CMD ["/run.sh"]
