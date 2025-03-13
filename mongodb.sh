echo -e "\e[31mCopy MongoDB repo file \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[31mInstalling MongoDB Server\e[0m"
dnf install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[31mModifying the Config File or update the listen address   \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[31mStart MongoDB service\e[0m"
systemctl enable mongod
systemctl restart mongod