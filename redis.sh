echo -e "\e[33mDisabaling Redis Module And enabling module 6\e[0m"
dnf module disable redis -y &>>/tmp/roboshop.log
dnf module enable redis:6 -y &>>/tmp/roboshop.log

echo -e "\e[33mInstalling Redis Server\e[0m"
dnf install redis -y  &>>/tmp/roboshop.log


echo -e "\e[33mUpdate Listen Address\e[0m"
sudo sed -i 's/127\.0\.0\.1/0.0.0.0/g' /etc/redis.conf &>>/tmp/roboshop.log


echo -e "\e[33mStarting Redis Server\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log