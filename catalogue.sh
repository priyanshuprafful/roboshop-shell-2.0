component=catalogue
color="\e[33m"
nocolor="\e[0m" # It disables the color
log_file="/tmp/roboshop.log" # here if special character are there then it will ignore the double quote 
app_path="/app"

echo -e "${color}Disable NodeJS module ${nocolor}"
dnf module disable nodejs -y &>>${log_file}

echo -e "${color}Enabling NodeJS 18 module ${nocolor}"
dnf module enable nodejs:18 -y &>>${log_file}

echo -e "${color}Installing NodeJS ${nocolor}"
dnf install nodejs -y &>>${log_file}


echo -e "${color}Adding Roboshop User or application user ${nocolor}"
useradd roboshop &>>${log_file}



echo -e "${color}Creating App Directory ${nocolor}"
rm -rf ${app_path} # to delete the old content , if present
mkdir ${app_path}

echo -e "${color}Download and Extract ${component} Content or application content ${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path}
unzip /tmp/${component}.zip &>>${log_file}

echo -e "${color}Installing Dependencies ${nocolor}"
cd ${app_path}
npm install &>>${log_file}

echo -e "${color}Copying Updated ${component} service File / Setup SystemD service ${nocolor}"
cp /root/roboshop-shell-2.0/${component}.service /etc/systemd/system/${component}.service

echo -e "${color}Updating the configuration ${nocolor}"
systemctl daemon-reload

echo -e "${color}Start ${component} Service ${nocolor}"
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}








echo -e "${color}Copy MongoDB repo file ${nocolor}"
cp /root/roboshop-shell-2.0/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "${color}Installing MongoDB server ${nocolor}"
dnf install mongodb-org-shell -y &>>${log_file}


echo -e "${color}Load Schema ${nocolor}"
mongo --host mongodb-dev.saraldevops.site <${app_path}/schema/${component}.js &>>${log_file}