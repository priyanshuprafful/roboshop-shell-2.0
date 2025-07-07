echo -e "\e[33mCopying MongoDB Repo \e[0m"
cp /home/centos/roboshop-shell-2.0/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling MongoDB Server\e[0m"
dnf install mongodb-org -y &>>/tmp/roboshop.log

# Need to update listen address
echo -e "\e[33mStarting MongoDB Server\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log