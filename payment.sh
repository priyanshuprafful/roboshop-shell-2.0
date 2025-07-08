echo -e "\e[33mInstalling Python\e[0m"
dnf install python36 gcc python3-devel -y &>>/tmp/roboshop.log


echo -e "\e[33mAdding app user\e[0m"
useradd roboshop &>>/tmp/roboshop.log


echo -e "\e[33mCreating App Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log


echo -e "\e[33mDownloading and extracting app content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/payment.zip &>>/tmp/roboshop.log

echo -e "\e[3333mInstalling Dependencies\e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[33mCopying Service File\e[0m"
cp /home/centos/roboshop-shell-2.0/payment.service /etc/systemd/system/payment.service

echo -e "\e[33mStarting payment service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log
