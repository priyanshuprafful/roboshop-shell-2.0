echo -e "\e[31mDisable Mysql module \e[0m"
dnf module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[31mCopy Repo File \e[0m"
cp /root/roboshop-shell-2.0/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[31mInstall Mysql server \e[0m"
dnf install mysql-community-server -y &>>/tmp/roboshop.log


echo -e "\e[31mStarting MySql \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log


echo -e "\e[31mSetup and start Mysql server  \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

