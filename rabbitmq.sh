source common_shell_script.sh

echo -e "\e[33mInstalling Erlang \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log
exit_status $?


echo -e "\e[33mInstalling RabbitMQ Server \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log


dnf install rabbitmq-server -y &>>/tmp/roboshop.log
exit_status $?


echo -e "\e[33mStarting RabbitMQ Server \e[0m"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl restart rabbitmq-server &>>/tmp/roboshop.log
exit_status $?


echo -e "\e[33mAdding RabbitMQ User and setting permissions \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log
exit_status $?