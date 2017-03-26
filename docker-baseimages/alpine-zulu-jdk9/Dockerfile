FROM alpine:3.5

RUN GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
 && GLIBC_PACKAGE_VERSION="2.25-r0" \
 && GLIBC_BASE_PACKAGE="glibc-${GLIBC_PACKAGE_VERSION}.apk" \
 && GLIBC_BIN_PACKAGE="glibc-bin-${GLIBC_PACKAGE_VERSION}.apk" \
 && GLIBC_I18N_PACKAGE="glibc-i18n-${GLIBC_PACKAGE_VERSION}.apk" \
 && ZULU_VERSION="9.0.0.10-ea-jdk9.0.0" \
 && ZULU_ARCHIVE_BASE="zulu${ZULU_VERSION}-linux_x64" \
 && apk update \
 && apk upgrade --no-cache  \
 && apk add --no-cache \
            --virtual=.build-dependencies \
            ca-certificates \
            curl \
 && curl -fSL \
         "https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/sgerrand.rsa.pub" \
         -o "/etc/apk/keys/sgerrand.rsa.pub" \
 && curl -fSL \
         "${GLIBC_BASE_URL}/${GLIBC_PACKAGE_VERSION}/${GLIBC_BASE_PACKAGE}" \
         -o "/tmp/${GLIBC_BASE_PACKAGE}" \
 && curl -fSL \
         "${GLIBC_BASE_URL}/${GLIBC_PACKAGE_VERSION}/${GLIBC_BIN_PACKAGE}" \
         -o "/tmp/${GLIBC_BIN_PACKAGE}" \
 && curl -fSL \
         "${GLIBC_BASE_URL}/${GLIBC_PACKAGE_VERSION}/${GLIBC_I18N_PACKAGE}" \
         -o "/tmp/${GLIBC_I18N_PACKAGE}" \
 && apk add --no-cache \
            "/tmp/${GLIBC_BASE_PACKAGE}" \
            "/tmp/${GLIBC_BIN_PACKAGE}" \
            "/tmp/${GLIBC_I18N_PACKAGE}" \
 && rm -f "/etc/apk/keys/sgerrand.rsa.pub" \
 && /usr/glibc-compat/bin/localedef --force --inputfile en_US --charmap UTF-8 en_US.UTF-8 || true \
 && apk del glibc-i18n \
 && rm -f "/tmp/${GLIBC_BASE_PACKAGE}" \
          "/tmp/${GLIBC_BIN_PACKAGE}" \
          "/tmp/${GLIBC_I18N_PACKAGE}" \
 && echo 'export LANG=en_US.UTF-8' > /etc/profile.d/locale.sh \
 && apk add --no-cache dumb-init \
 && curl -fSL \
         "https://cdn.azul.com/zulu-pre/bin/${ZULU_ARCHIVE_BASE}.tar.gz" \
         -o "/tmp/${ZULU_ARCHIVE_BASE}.tar.gz" \
 && mkdir -p /opt \
 && tar xzf "/tmp/${ZULU_ARCHIVE_BASE}.tar.gz" -C /opt \
 && rm -f "/tmp/${ZULU_ARCHIVE_BASE}.tar.gz" \
 && mv "/opt/${ZULU_ARCHIVE_BASE}" /opt/jdk \
 && chown -R root:root /opt/jdk \
 && rm -rf /opt/jdk/demo \
           /opt/jdk/man \
           /opt/jdk/sample \
           /opt/jdk/src.zip \
 && echo 'export JAVA_HOME=/opt/jdk' > /etc/profile.d/jdk.sh  \
 && apk del .build-dependencies \
 && rm -f /var/cache/apk/*.tar.gz

ENV LANG=en_US.UTF-8 \
    JAVA_HOME=/opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

ENTRYPOINT ["/usr/bin/dumb-init", "--"]


