echo -e "\e[31mCopy MongoDB repo file \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[31mInstalling MongoDB Server\e[0m"
dnf install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[31mStart MongoDB service\e[0m"
systemctl enable mongod 
systemctl restart mongod