FROM centos:7
WORKDIR "/app"

RUN cd /etc/yum.repos.d/ && rm -rf *.* && curl -O http://mirrors.aliyun.com/repo/Centos-7.repo && curl -O http://mirrors.aliyun.com/repo/epel-7.repo && curl -O https://mirrors.aliyun.com/remi/enterprise/remi-release-7.rpm && yum clean all && yum makecache

RUN yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm && yum -y install yum-utils && yum-config-manager --enable remi-php74 && yum -y update && yum -y install php74-php-cli php74-php-fpm

RUN ln -s /bin/php74 /bin/php

RUN yum -y install php74-php-gd && yum -y install php74-php-mbstring && yum -y install php74-php-dom && yum -y install php74-php-zip && yum -y install php74-php-bcmath && yum -y install php74-php-pdo

RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer

RUN yum -y install git && yum -y install wget

# RUN wget https://nodejs.org/dist/v12.16.2/node-v12.16.2-linux-x64.tar.xz RUN wget https://cdn.npm.taobao.org/dist/node/v12.16.2/node-v12.16.2-linux-x64.tar.xz && xz -d node-v12.16.2-linux-x64.tar.xz && tar -xf node-v12.16.2-linux-x64.tar && mv node-v12.16.2-linux-x64 /usr/local/share/node-v12.16.2-linux-x64 && ln -s /usr/local/share/node-v12.16.2-linux-x64/bin/node /usr/bin/node && ln -s /usr/local/share/node-v12.16.2-linux-x64/bin/npm /usr/bin/npm && rm -rf node-v12.16.2-linux-x64.tar

# RUN wget https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz && #     tar -C /usr/local -xzf go1.14.2.linux-amd64.tar.gz && #     echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile && #     source /etc/profile && #     echo 'source /etc/profile' > /etc/rc.d/rc.local && #     echo 'source /etc/profile' >> /etc/bashrc
RUN yum -y install go