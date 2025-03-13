echo -e "\e[31mDisable NodeJS module \e[0m"
dnf module disable nodejs -y &>>/tmp/roboshop.log

echo -e "\e[31mEnabling NodeJS 18 module \e[0m"
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "\e[31mInstalling NodeJS \e[0m"
dnf install nodejs -y &>>/tmp/roboshop.log


echo -e "\e[31mAdding Roboshop cart or application cart \e[0m"
useradd roboshop &>>/tmp/roboshop.log



echo -e "\e[31mCreating App Directory \e[0m"
rm -rf /app # to delete the old content , if present
mkdir /app

echo -e "\e[31mDownload and Extract cart Content or application content \e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[31mInstalling Dependencies \e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[31mCopying Updated cart service File / Setup SystemD service \e[0m"
cp /root/roboshop-shell-2.0/cart.service /etc/systemd/system/cart.service

echo -e "\e[31mUpdating the configuration \e[0m"
systemctl daemon-reload

echo -e "\e[31mStart cart Service \e[0m"
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log








