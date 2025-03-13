echo -e "\e[31mInstall GOlang \e[0m"
dnf install golang -y &>>/tmp/roboshop.log

echo -e "\e[31mAdding Application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31mCreating App directory\e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[31mDownloading App content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log

cd /app

echo -e "\e[31mExtract App content \e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
cd /app


echo -e "\e[31mInstalling App dependencies \e[0m"
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[31mCopy SystemD files \e[0m"
cp /root/roboshop-shell-2.0/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log


echo -e "\e[31mStarting Service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log
