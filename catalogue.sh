component=catalogue


echo -e "\e[33mDisabling nodejs module and enabling 18 module\e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "\e[33mInstalling NodeJs\e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mAdding Roboshop User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mCreating App Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log


echo -e "\e[33mDownloading and extracting app content \e[0m"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/${component}.zip &>>/tmp/roboshop.log


echo -e "\e[33mInstalling Dependencies\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[33mCopying ${component} Service File\e[0m"
cp /home/centos/roboshop-shell-2.0/${component}.service /etc/systemd/system/${component}.service &>>/tmp/roboshop.log


echo -e "\e[33mStarting ${component} Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable ${component} &>>/tmp/roboshop.log
systemctl start ${component} &>>/tmp/roboshop.log

echo -e "\e[33mCopying Mongodb Repo File\e[0m"
cp /home/centos/roboshop-shell-2.0/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling mongodb server\e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33mLoading Schema\e[0m"
mongo --host mongodb-dev.devopspro.fun </app/schema/${component}.js &>>/tmp/roboshop.log