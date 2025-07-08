source common_shell_script.sh

component=catalogue

nodejs


echo -e "${color} Copying Mongodb Repo File ${exit_color}"
cp /home/centos/roboshop-shell-2.0/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

echo -e "${color} Installing mongodb server ${exit_color}"
dnf install mongodb-org-shell -y &>>${log_file}

echo -e "${color} Loading Schema ${exit_color}"
mongo --host mongodb-dev.devopspro.fun <${app_path}/schema/${component}.js &>>${log_file}