echo -e "\e[33mCopying MongoDB Repo \e[0m"
cp /home/centos/roboshop-shell-2.0/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

#cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log # both above and this will work

echo -e "\e[33mInstalling MongoDB Server\e[0m"
dnf install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33mUpdate MongoDB Listen Address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf

echo -e "\e[33mStarting MongoDB Server\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log