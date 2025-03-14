color="\e[32m"
nocolor="\e[0m" # It disables the color
log_file="/tmp/roboshop.log" # here if special character are there then it will ignore the double quote
app_path="/app"

status_check() {
    if [ $1 -eq 0 ]; then
      echo "SUCCESS"
    else
      echo "FAILURE"
    fi
}

app_presetup(){
    echo -e "${color}Adding Roboshop User or application user ${nocolor}"
    id roboshop &>>${log_file}
    if [ $? -eq 1 ]; then # that means the user is not already there
      useradd roboshop &>>${log_file}
    fi
    status_check $? # $? is the first argument and we catch that above in the function

    echo -e "${color}Creating App Directory ${nocolor}"
    rm -rf ${app_path} # to delete the old content , if present
    mkdir ${app_path}
    status_check $?

    echo -e "${color}Download Application content${nocolor}"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
    status_check $?


    echo -e "${color}Extracting Application content${nocolor}"
    cd ${app_path}
    unzip /tmp/${component}.zip &>>${log_file}
    status_check $?

}

systemd_setup() {

  echo -e "${color}Setup SystemD service file${nocolor}"
  cp /root/roboshop-shell-2.0/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
  status_check $?

  echo -e "${color}Start ${component} Service${nocolor}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}
  systemctl restart ${component} &>>${log_file}
  status_check $?

}


nodejs() {
  echo -e "${color}Disable NodeJS module ${nocolor}"
  dnf module disable nodejs -y &>>${log_file}

  echo -e "${color}Enabling NodeJS 18 module ${nocolor}"
  dnf module enable nodejs:18 -y &>>${log_file}

  echo -e "${color}Installing NodeJS ${nocolor}"
  dnf install nodejs -y &>>${log_file}


  app_presetup


  echo -e "${color}Installing Dependencies ${nocolor}"
  cd ${app_path}
  npm install &>>${log_file}

  systemd_setup


}

mongo_schema_setup() {
  echo -e "${color}Copy MongoDB repo file ${nocolor}"
  cp /root/roboshop-shell-2.0/mongodb.repo /etc/yum.repos.d/mongo.repo

  echo -e "${color}Installing MongoDB server ${nocolor}"
  dnf install mongodb-org-shell -y &>>${log_file}


  echo -e "${color}Load Schema ${nocolor}"
  mongo --host mongodb-dev.saraldevops.site <${app_path}/schema/user.js &>>${log_file}
}
mysql_schema_setup(){
   echo -e "${color}Install MYSQL Client${nocolor}"
   cp /root/roboshop-shell-2.0/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
   dnf install mysql -y &>>${log_file}

   echo -e "${color} Load Schema${nocolor}"
   mysql -h mysql-dev.saraldevops.site -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql &>>${log_file}
}

maven(){
  echo -e "${color}Install Maven ${nocolor}"
  dnf install maven -y &>>${log_file}


  app_presetup


  echo -e "${color} Download Application Dependencies${nocolor}"
  mvn clean package &>>${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>>${log_file}



  mysql_schema_setup
  systemd_setup

}

python() {
  echo -e "${color}Install Python 3.6 ${nocolor}"
  dnf install python36 gcc python3-devel -y &>>${log_file}
  status_check $?

  app_presetup

  echo -e "${color}Installing Application Dependencies${nocolor}"
  cd /app
  pip3.6 install -r requirements.txt &>>${log_file}
  status_check $?

  sed -i -e "s/roboshop_app_password/$1/" /root/roboshop-shell-2.0/${component}.service
  systemd_setup
}