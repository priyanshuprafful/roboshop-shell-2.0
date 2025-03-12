echo -e "\e[31mInstalling Nginx Server\e[0m"
dnf install nginx -y

echo -e "\e[31mRemoving Old Content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[31mDownloading Frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[31mExtracting Frontend Content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

## we need to copy config file
echo -e "\e[31mStarting Nginx Server\e[0m"
systemctl enable nginx
systemctl restart nginx