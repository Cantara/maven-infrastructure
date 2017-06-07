if [ -f $JAVA_HOME/conf/net.properties ]; then
  dockerRoute=$(route | grep '*')
  dockerNet=${dockerRoute/\.0.*/.*}
  sed -i $JAVA_HOME/conf/net.properties -e "s/nonProxyHosts=localhost|/nonProxyHosts=${dockerNet}|localhost|/"
fi

