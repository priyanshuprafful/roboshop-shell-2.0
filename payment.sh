echo -e "\e[31mInstall Python 3.6 \e[0m"
dnf install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[31mAdding Application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[31mCreating App directory \e[0m"
rm -rf /app
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[31mDownload App content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[31mExtract App content\e[0m"
unzip /tmp/payment.zip &>>/tmp/roboshop.log

echo -e "\e[31mInstalling Python Dependencies\e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[31mSetup SystemD files\e[0m"
cp /root/roboshop-shell-2.0/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[31mStarting Payment Service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log