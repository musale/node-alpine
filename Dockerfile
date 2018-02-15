FROM node:8-alpine

RUN apk --update add build-base python curl bash openssh-client git

ENV CLOUD_SDK_VERSION 191.0.0

ENV PATH /google-cloud-sdk/bin:$PATH
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image

ADD https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN set -x && chmod +x /usr/local/bin/kubectl

RUN kubectl version --client
RUN gcloud --version
RUN python --version
RUN gcc --version

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD [ "node" ]