source common_shell_script.sh
component=shipping

maven


echo -e "\e[33mInstalling Mysql\e[0m"
dnf install mysql -y &>>/tmp/roboshop.log


echo -e "\e[33mLoading Schema\e[0m"
mysql -h mysql-dev.devopspro.fun -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

systemd_setup