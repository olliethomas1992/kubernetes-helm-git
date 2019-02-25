FROM alpine

LABEL maintainer="Ollie Thomas <ollie.thomas1992@gmail.co.uk>"

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
	org.label-schema.vcs-url="https://github.com/olliethomas1992/kubernetes-helm-git.git" \
	org.label-schema.build-date=$BUILD_DATE \
	org.label-schema.docker.dockerfile="/Dockerfile"

ENV HELM_LATEST_VERSION="v2.12.3"

RUN apk add --update ca-certificates \
	&& apk add --update git openssh \
	&& apk add --update -t deps wget \
	&& wget https://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
	&& tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
	&& mv linux-amd64/helm /usr/local/bin \
	&& apk del --purge deps \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /var/cache/apk/* \
	&& rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz

ENTRYPOINT ["helm"]
CMD ["help"]