echo 'cleaning cache'
sudo yum clean all
sudo yum makecache
sudo yum install wget
echo 'installing MySQL'
cd ~
#sudo wget https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm
#sudo md5sum mysql80-community-release-el8-1.noarch.rpm
#sudo rpm –ivh mysql80-community-release-el8-1.noarch.rpm
sudo wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo yum install epel-release -y
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
sudo yum update -y
sudo yum install mysql-server -y
mysql --version
echo 'mysql installed********************************************************************'

sudo yum install maven
mvn -version
echo 'maven installed*********************************************************************'

echo Installing Authbind
sudo yum install wget -y
sudo yum install vim -y

sudo groupadd tomcat
sudo mkdir /opt/tomcat
sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
cd ~
wget ftp://apache.cs.utah.edu/apache.org/tomcat/tomcat-8/v8.5.47/bin/apache-tomcat-8.5.47.tar.gz
sudo tar -zxvf apache-tomcat-8.5.47.tar.gz -C /opt/tomcat/ --strip-components=1
cd /opt/tomcat/
sudo chgrp -R tomcat conf
sudo chmod -R g+rwx conf
sudo chown -R tomcat logs/ temp/ webapps/ work/
sudo chgrp -R tomcat bin
sudo chgrp -R tomcat lib
sudo chmod g+rwx bin
cd /usr/lib/systemd/system
sudo touch tomcat.service
sudo chmod 777 tomcat.service
echo '[Unit]' > tomcat.service
echo 'Description=Apache Tomcat Web Application Container' >> tomcat.service
echo 'After=syslog.target network.target' >> tomcat.service
echo '[Service]' >> tomcat.service
echo 'Type=forking' >> tomcat.service
echo 'Environment=JAVA_HOME=/usr/lib/jvm/jre' >> tomcat.service
echo 'Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid' >> tomcat.service
echo 'Environment=CATALINA_HOME=/opt/tomcat' >> tomcat.service
echo 'Environment=CATALINA_BASE=/opt/tomcat' >> tomcat.service
echo 'Environment=\"CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC\"' >> tomcat.service
echo 'Environment=\"JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom\"' >> tomcat.service
echo 'ExecStart=/opt/tomcat/bin/startup.sh' >> tomcat.service
echo 'ExecStop=/opt/tomcat/bin/shutdown.sh' >> tomcat.service
echo 'User=tomcat' >> tomcat.service
echo 'Group=tomcat' >> tomcat.service
echo 'UMask=0007' >> tomcat.service
echo 'RestartSec=10' >> tomcat.service
echo 'Restart=always' >> tomcat.service
echo '[Install]' >> tomcat.service
echo 'WantedBy=multi-user.target' >> tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat.service
sudo systemctl status tomcat.service
sudo systemctl stop tomcat.service
echo 'Tomcat installed*********************************************************************'


