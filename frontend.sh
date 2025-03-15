source common.sh 

echo -e "${color}Installing Nginx Server${nocolor}"
dnf install nginx -y &>>${log_file}
status_check $?

echo -e "${color}Removing Old Content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${log_file}
status_check $?

echo -e "${color}Downloading Frontend content${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
status_check $?

echo -e "${color}Extracting Frontend Content${nocolor}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}
status_check $?

echo -e "${color}Update Frontend Configuration${nocolor}"
cp /root/roboshop-shell-2.0/roboshop.conf /etc/nginx/default.d/roboshop.conf
status_check $?


echo -e "${color}Starting Nginx Server${nocolor}"
systemctl enable nginx &>>${log_file}
systemctl restart nginx &>>${log_file}
status_check $?