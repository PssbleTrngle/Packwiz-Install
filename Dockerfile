FROM eclipse-temurin:21-jre

ARG MC_HELPER_VERSION=1.39.10
ARG MC_HELPER_REV=1
RUN curl -fsSL https://github.com/itzg/mc-image-helper/releases/download/${MC_HELPER_VERSION}/mc-image-helper-${MC_HELPER_VERSION}.tgz \
  | tar -C /usr/share -zxf - \
  && ln -s /usr/share/mc-image-helper-${MC_HELPER_VERSION}/bin/mc-image-helper /usr/bin

WORKDIR /usr/bin

ENV PATHWIZ_SIDE=both

COPY setup.sh docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]