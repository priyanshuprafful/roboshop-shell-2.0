source common.sh
component=catalogue

nodejs

echo -e "${color}Copy MongoDB repo file ${nocolor}"
cp /root/roboshop-shell-2.0/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "${color}Installing MongoDB server ${nocolor}"
dnf install mongodb-org-shell -y &>>${log_file}


echo -e "${color}Load Schema ${nocolor}"
mongo --host mongodb-dev.saraldevops.site <${app_path}/schema/${component}.js &>>${log_file}