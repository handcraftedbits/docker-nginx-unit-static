FROM handcraftedbits/nginx-unit:1.0.1
MAINTAINER HandcraftedBits <opensource@handcraftedbits.com>

COPY data /

RUN apk update && \
  apk add bash

CMD ["/bin/sh", "/opt/container/script/run-static.sh"]
