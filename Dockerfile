FROM macpaw/internship

#add page with additional information about me
ADD ./index.html ./
#installing system packagees, fixing uwsgi config file and changing servername
RUN apt-get update && apt-get install -y zip logrotate dnsutils \
    && sed -i 's/wrong.py/main.py/g' uwsgi.ini \
    && sed -i 's/localhost/internship.macpaw.io/g' /etc/nginx/conf.d/nginx.conf

#add script that shows ip 
ADD ./get_ip.sh ./
#add changed main.py that is able to show ip and information from index.html
ADD ./main.py ./

#add configs for logrotate
ADD logrotate_files/* /etc/logrotate.d/
RUN chmod 644 /etc/logrotate.d/*

#optional part. uncomment for open zip
##
WORKDIR /tmp
COPY ./open_zip.sh ./
RUN ["/bin/bash", "./open_zip.sh"]
WORKDIR /app
