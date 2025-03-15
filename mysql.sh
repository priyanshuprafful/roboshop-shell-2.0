source common.sh
component=mysql

echo -e "${color}Disable Mysql module ${nocolor}"
dnf module disable mysql -y &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Copy Repo File ${nocolor}"
cp /root/roboshop-shell-2.0/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Install Mysql server ${nocolor}"
dnf install mysql-community-server -y &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Starting MySql ${nocolor}"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Setup and start Mysql server  ${nocolor}"
mysql_secure_installation --set-root-pass $1 &>>/tmp/roboshop.log
status_check $?
