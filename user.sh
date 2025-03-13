echo -e "\e[31mDisable NodeJS module \e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log

echo -e "\e[31mEnabling NodeJS 18 module \e[0m"
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "\e[31mInstalling NodeJS \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log


echo -e "\e[31mAdding Roboshop User or application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log



echo -e "\e[31mCreating App Directory \e[0m"
rm -rf /app # to delete the old content , if present
mkdir /app

echo -e "\e[31mDownload and Extract user Content or application content \e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/user.zip &>>/tmp/roboshop.log

echo -e "\e[31mInstalling Dependencies \e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[31mCopying Updated user service File / Setup SystemD service \e[0m"
cp /root/roboshop-shell-2.0/user.service /etc/systemd/system/user.service

echo -e "\e[31mUpdating the configuration \e[0m"
systemctl daemon-reload

echo -e "\e[31mStart user Service \e[0m"
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log








echo -e "\e[31mCopy MongoDB repo file \e[0m"
cp /root/roboshop-shell-2.0/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[31mInstalling MongoDB server \e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log


echo -e "\e[31mLoad Schema \e[0m"
mongo --host mongodb-dev.saraldevops.site </app/schema/user.js &>>/tmp/roboshop.log