FROM handcraftedbits/nginx-unit:1.1.2
MAINTAINER HandcraftedBits <opensource@handcraftedbits.com>

COPY data /

CMD [ "/bin/bash", "/opt/container/script/run-static.sh" ]
