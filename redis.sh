echo -e "\e[31mEnable Redis module \e[0m"
dnf module enable redis:6 -y &>>/tmp/roboshop.log

echo -e "\e[31mInstalling Redis \e[0m"
dnf install redis -y &>>/tmp/roboshop.log

echo -e "\e[31mUpdate redis listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/'/etc/redis.conf &>>/tmp/roboshop.log

echo -e "\e[31mStart redis service \e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl start redis &>>/tmp/roboshop.log