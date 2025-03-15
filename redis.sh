source common.sh
component=redis

echo -e "${color}Enable Redis module ${nocolor}"
dnf module enable redis:6 -y &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Installing Redis ${nocolor}"
dnf install redis -y &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Update redis listen address ${nocolor}"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Start redis service ${nocolor}"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log
status_check $?