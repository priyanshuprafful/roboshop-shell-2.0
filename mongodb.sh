source common.sh 

echo -e "${color}Copy MongoDB repo file ${nocolor}"
cp /root/roboshop-shell-2.0/mongodb.repo /etc/yum.repos.d/mongo.repo
stat_check $?

echo -e "${color}Installing MongoDB Server${nocolor}"
dnf install mongodb-org -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Modifying the Config File or update the listen address   ${nocolor}"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat_check $?

echo -e "${color}Start MongoDB service${nocolor}"
systemctl enable mongod
systemctl restart mongod
stat_check $?

