component=catalogue
color="\e[33m"

echo -e "${color}Disable NodeJS module \e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log

echo -e "${color}Enabling NodeJS 18 module \e[0m"
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "${color}Installing NodeJS \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log


echo -e "${color}Adding Roboshop User or application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log



echo -e "${color}Creating App Directory \e[0m"
rm -rf /app # to delete the old content , if present
mkdir /app

echo -e "${color}Download and Extract ${component} Content or application content \e[0m"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/${component}.zip &>>/tmp/roboshop.log

echo -e "${color}Installing Dependencies \e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "${color}Copying Updated ${component} service File / Setup SystemD service \e[0m"
cp /root/roboshop-shell-2.0/${component}.service /etc/systemd/system/${component}.service

echo -e "${color}Updating the configuration \e[0m"
systemctl daemon-reload

echo -e "${color}Start ${component} Service \e[0m"
systemctl enable ${component} &>>/tmp/roboshop.log
systemctl restart ${component} &>>/tmp/roboshop.log








echo -e "${color}Copy MongoDB repo file \e[0m"
cp /root/roboshop-shell-2.0/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "${color}Installing MongoDB server \e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log


echo -e "${color}Load Schema \e[0m"
mongo --host mongodb-dev.saraldevops.site </app/schema/${component}.js &>>/tmp/roboshop.log