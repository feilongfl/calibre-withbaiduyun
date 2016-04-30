FROM feilongfl/calibre-mini

RUN apt-get install -y build-essential libcurl4-openssl-dev libssl-dev
RUN git clone https://github.com/GangZhuo/BaiduPCS.git
RUN cd BaiduPCS && make && make install && cd .. && rm -rfv BaiduPCS

RUN apt-get install -y python python-pip python-dev
RUN apt-get install -y libfuse2
RUN pip install -U fusepy
RUN pip install -U progressbar
RUN pip install -U baidupcsapi
RUN pip install urllib3 --upgrade
RUN apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
RUN pip install image
RUN apt-get build-dep python-imaging
RUN apt-get install libjpeg62 libjpeg62-dev

#RUN wget -O /usr/bin/baidumount https://github.com/ly0/baidu-fuse/raw/master/baidufuse.py
#RUN wget -O /usr/bin/baidumount https://github.com/feilongfl/calibre-withbaiduyun/raw/master/baidufuse.py
ADD baidufuse.py /usr/bin/baidumount
RUN chmod +x /usr/bin/baidumount

RUN pcs login --username=gang --password=123456

RUN mkdir /baidu

EXPOSE 9090

CMD ["/usr/bin/baidumount","calibre_lib","feilong","/baidu"]
