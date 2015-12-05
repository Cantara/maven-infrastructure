if [ -f $JRE/lib/net.properties ]; then
  dockerRoute=$(route | grep '*')
  dockerNet=${dockerRoute/\.0.*/.*}
  sed -i $JRE/lib/net.properties -e "s/nonProxyHosts=localhost|/nonProxyHosts=${dockerNet}|localhost|/"
fi
