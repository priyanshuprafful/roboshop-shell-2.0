color="\e[36m"
exit_color="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"


nodejs() {
  echo -e "${color} Disabling nodejs module and enabling 18 module ${exit_color}"
  dnf module disable nodejs -y &>>${log_file}
  dnf module enable nodejs:18 -y &>>${log_file}

  echo -e "${color} Installing NodeJs ${exit_color}"
  dnf install nodejs -y &>>${log_file}

  echo -e "${color} Adding Roboshop User ${exit_color}"
  useradd roboshop &>>${log_file}

  echo -e "${color} Creating App Directory ${exit_color}"
  rm -rf ${app_path} &>>${log_file}
  mkdir ${app_path} &>>${log_file}


  echo -e "${color} Downloading and extracting app content ${exit_color}"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
  cd ${app_path}
  unzip /tmp/${component}.zip &>>${log_file}


  echo -e "${color} Installing Dependencies ${exit_color}"
  cd ${app_path}
  npm install &>>${log_file}

  echo -e "${color} Copying ${component} Service File ${exit_color}"
  cp /home/centos/roboshop-shell-2.0/${component}.service /etc/systemd/system/${component}.service &>>${log_file}


  echo -e "${color} Starting ${component} Service ${exit_color}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}
  systemctl start ${component} &>>${log_file}

}

mongo_schema_setup () {

echo -e "${color} Copying Mongodb Repo File ${exit_color}"
cp /home/centos/roboshop-shell-2.0/mongo.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

echo -e "${color} Installing mongodb server ${exit_color}"
dnf install mongodb-org-shell -y &>>${log_file}

echo -e "${color} Loading Schema ${exit_color}"
mongo --host mongodb-dev.devopspro.fun <${app_path}/schema/${component}.js &>>${log_file}
}