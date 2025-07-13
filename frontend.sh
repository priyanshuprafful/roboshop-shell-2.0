source common_shell_script.sh

echo -e "${color}Installing Nginx Server\e[0m"
dnf install nginx -y &>>/tmp/roboshop.log

echo -e "\e[33mRemoving old app content${exit_color}"
rm -rf /usr/share/nginx/html/* &>>${log_file}


echo -e "\e[33mDownloading Frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log


echo -e "\e[33mExtract Frontend Content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[33mUpdate Roboshop Configurations\e[0m"
cp /home/centos/roboshop-shell-2.0/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log

echo -e "\e[33mStarting Nginx Server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log

