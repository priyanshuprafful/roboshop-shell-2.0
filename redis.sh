echo -e "\e[33mDisabaling Redis Module And enabling module 6\e[0m"
dnf module disable redis -y &>>/tmp/roboshop.log
dnf module enable redis:6 -y &>>/tmp/roboshop.log

echo -e "\e[33mInstalling Redis Server\e[0m"
dnf install redis -y  &>>/tmp/roboshop.log


echo -e "\e[33mUpdate Listen Address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>/tmp/roboshop.log

echo -e "\e[33mStarting Redis Server\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl start redis &>>/tmp/roboshop.log