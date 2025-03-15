source common.sh
component=mongodb

echo -e "${color}Copy MongoDB repo file ${nocolor}"
cp /home/centos/roboshop-shell-2.0/mongodb.repo /etc/yum.repos.d/mongo.repo
status_check $?

echo -e "${color}Installing MongoDB Server${nocolor}"
dnf install mongodb-org -y &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Modifying the Config File or update the listen address   ${nocolor}"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status_check $?

echo -e "${color}Start MongoDB service${nocolor}"
systemctl enable mongod
systemctl restart mongod
status_check $?

