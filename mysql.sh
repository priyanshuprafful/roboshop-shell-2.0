source common_shell_script.sh

echo -e "\e[33mDisabling Mysql module \e[0m"
dnf module disable mysql -y &>>/tmp/roboshop.log
exit_status $?

echo -e "\e[33mCopying Mysql Repo File\e[0m"
cp /home/centos/roboshop-shell-2.0/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
exit_status $?


echo -e "\e[33mInstalling Mysql Server\e[0m"
dnf install mysql-community-server -y &>>/tmp/roboshop.log
exit_status $?


echo -e "\e[33mStarting Mysql Service\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log
exit_status $?


echo -e "\e[33mSetting Password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log
#mysql -uroot -pRoboShop@1
exit_status $?