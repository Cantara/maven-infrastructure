FROM cantara/jvmprep

MAINTAINER totto@totto.org
# Based upon work by josh@grahamis.com

# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
# Replace duplicate files in JDK bin with links to JRE bin
RUN \
  checksum="2f93b2f4c64782c3159004f749963c01" && \
  url="http://cdn.azulsystems.com/zulu/bin/zulu1.9.0_pre-9.0.0.1-x86lx64.zip" && \
  referer="http://www.azulsystems.com/zuludoc" && \
  etag=$(curl -sI --referer "${referer}" "${url}" | awk -F"\"|:" '/^ETag: / {print $3}') && \
  if [ "X${checksum}" == "X${etag}" ]; then \
    curl -O -L --referer "${referer}" "${url}"; \
  else \
    echo "[FATAL] Java ZIP ETag ${etag} doesn't match checksum ${checksum}. Exiting." >&2 && \
    exit 1; \
  fi && \
  unzip -q *.zip && \
  rm *.zip && \
  mkdir -p $(dirname ${JAVA_HOME}) && \
  mv * ${JAVA_HOME} && \
  cd .. && \
  rmdir ${OLDPWD} && \
  cd ${JAVA_HOME} && \
  rm -rf *.zip demo man sample && \
  for ff in ${JAVA_HOME}/bin/*; do f=$(basename $ff); if [ -e ${JRE}/bin/$f ]; then ln -snf ${JRE}/bin/$f $ff; fi; done && \
#  chmod a+w ${JRE}/lib ${JRE}/lib/net.properties && \
  rm -rf /var/cache/apk/*

WORKDIR /root


