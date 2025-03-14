color="\e[32m"
nocolor="\e[0m" # It disables the color
log_file="/tmp/roboshop.log" # here if special character are there then it will ignore the double quote
app_path="/app"


nodejs() {
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


}

mongo_schema_setup() {
  echo -e "\e[31mCopy MongoDB repo file \e[0m"
  cp /root/roboshop-shell-2.0/mongodb.repo /etc/yum.repos.d/mongo.repo

  echo -e "\e[31mInstalling MongoDB server \e[0m"
  dnf install mongodb-org-shell -y &>>/tmp/roboshop.log


  echo -e "\e[31mLoad Schema \e[0m"
  mongo --host mongodb-dev.saraldevops.site </app/schema/user.js &>>/tmp/roboshop.log
}