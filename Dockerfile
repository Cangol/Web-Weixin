FROM openjdk:8-jdk
MAINTAINER Cangol  wxw404@gmail.com
WORKDIR /root
USER root

RUN apt-get --quiet update --yes
RUN apt-get install perl-modules --yes
RUN apt-get install libssl-dev --yes
RUN apt-get install libnet-ssleay-perl --yes
RUN apt-get install libcrypt-ssleay-perl --yes
RUN apt-get install python-yaml --yes
RUN apt-get install build-essential --yes
RUN apt-get install libcrypt-openssl-bignum-perl libcrypt-openssl-rsa-perl

RUN cpan -i App::cpanminus
RUN cpanm Mojo::Weixin

EXPOSE 5000
VOLUME /tmp

CMD perl -MMojo::Weixin -e 'Mojo::Weixin->new(log_encoding=>"utf8")->load(["ShowMsg","UploadQRcode"])->load("Openwx",data=>{listen =>[{host=>"0.0.0.0",port=>5000}]})->run()'
