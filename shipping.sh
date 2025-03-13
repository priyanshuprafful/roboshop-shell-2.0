echo -e "\e[31mInstall Maven \e[0m"
dnf install maven -y &>>/tmp/roboshop.log


echo -e "\e[31mAdding application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log



echo -e "\e[31mCreating application directory \e[0m"
mkdir /app &>>/tmp/roboshop.log


echo -e "\e[31mDownload Application content\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log

cd /app

echo -e "\e[31mExtracting Application content\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log


cd /app

echo -e "\e[31m Download Application Dependencies\e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log





echo -e "\e[31mInstall MYSQL Client\e[0m"
cp /root/roboshop-shell-2.0/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
dnf install mysql -y &>>/tmp/roboshop.log

echo -e "\e[31m Load Schema\e[0m"
mysql -h mysql-dev.saraldevops.site -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[31mStart Shipping Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log
