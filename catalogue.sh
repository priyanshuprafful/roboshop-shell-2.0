component=catalogue
color="\e[36m"
exit_color="\e[0m"


echo -e "${color} Disabling nodejs module and enabling 18 module ${exit_color}"
dnf module disable nodejs -y &>>/tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "${color} Installing NodeJs ${exit_color}"
dnf install nodejs -y &>>/tmp/roboshop.log

echo -e "${color} Adding Roboshop User ${exit_color}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color} Creating App Directory ${exit_color}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log


echo -e "${color} Downloading and extracting app content ${exit_color}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/${component}.zip &>>/tmp/roboshop.log


echo -e "${color} Installing Dependencies ${exit_color}"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "${color} Copying ${component} Service File ${exit_color}"
cp /home/centos/roboshop-shell-2.0/${component}.service /etc/systemd/system/${component}.service &>>/tmp/roboshop.log


echo -e "${color} Starting ${component} Service ${exit_color}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable ${component} &>>/tmp/roboshop.log
systemctl start ${component} &>>/tmp/roboshop.log

echo -e "${color} Copying Mongodb Repo File ${exit_color}"
cp /home/centos/roboshop-shell-2.0/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "${color} Installing mongodb server ${exit_color}"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color} Loading Schema ${exit_color}"
mongo --host mongodb-dev.devopspro.fun </app/schema/${component}.js &>>/tmp/roboshop.log