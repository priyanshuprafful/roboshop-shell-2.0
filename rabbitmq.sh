source common.sh
component=mysql

echo -e "${color}Configure Erlang Repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Configure RabbitMQ repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Installing RabbitMQ server${nocolor}"
dnf install rabbitmq-server -y &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Start RabbitMQ service${nocolor}"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl start rabbitmq-server &>>/tmp/roboshop.log
status_check $?

echo -e "${color}Add rabbitmq application user ${nocolor}"
rabbitmqctl add_user roboshop $1 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log
status_check $?