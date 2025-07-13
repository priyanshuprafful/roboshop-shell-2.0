source common_shell_script.sh

echo -e "${color}Installing Nginx Server${exit_color}"
dnf install nginx -y &>>${log_file}
exit_status $?

echo -e "${color}Removing old app content${exit_color}"
rm -rf /usr/share/nginx/html/* &>>${log_file}
exit_status $?


echo -e "${color}Downloading Frontend Content${exit_color}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
exit_status $?


echo -e "${color}Extract Frontend Content${exit_color}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}
exit_status $?

echo -e "${color}Update Roboshop Configurations${exit_color}"
cp /home/centos/roboshop-shell-2.0/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
exit_status $?

echo -e "${color}Starting Nginx Server${exit_color}"
systemctl enable nginx &>>${log_file}
systemctl restart nginx &>>${log_file}
exit_status $?

