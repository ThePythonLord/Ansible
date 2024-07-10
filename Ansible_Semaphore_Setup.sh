sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
sudo systemctl start mysql
sudo systemctl enable mysql

---reset root pass---
sudo mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'new_password';
FLUSH PRIVILEGES;
exit;
---

sudo apt install git
(if error: sudo apt --fix-broken install)
sudo apt install ansible
ansible --version


wget https://github.com/semaphoreui/semaphore/releases/download/v2.10.11/semaphore_2.10.11_linux_amd64.deb
sudo dpkg -i semaphore_2.10.11_linux_amd64.deb
semaphore setup


CREATE DATABASE semaphore;
(SHOW DATABASES;)
CREATE USER 'semaphore'@'localhost' IDENTIFIED BY 'your_password_here';
GRANT ALL PRIVILEGES ON semaphore.* TO 'semaphore'@'localhost';
FLUSH PRIVILEGES;
(SHOW GRANTS FOR 'semaphore'@'localhost';)
exit;

---Run as a service---

sudo nano /etc/systemd/system/semaphore.service

----------
[Unit]
Description=Semaphore Ansible
Documentation=https://github.com/semaphoreui/semaphore
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/bin/semaphore server --config=/path/to/config.json
SyslogIdentifier=semaphore
Restart=always
RestartSec=10s

[Install]
WantedBy=multi-user.target
----------

sudo systemctl daemon-reload
sudo systemctl start semaphore
sudo systemctl enable semaphore
sudo systemctl status semaphore
