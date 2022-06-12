FROM rockylinux:8
COPY gitea.service rockylinux:/etc/systemd/system/
#RUN dnf -y install httpd; dnf clean all; systemctl enable httpd.service; \
RUN dnf -y install wget; \
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo; \
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key; \
dnf -y upgrade; \
dnf -y install java-11-openjdk; \
dnf -y install jenkins; \
systemctl enable jenkins; systemctl start jenkins; \
systemctl status jenkins; \
#dnf -y install curl policycoreutils openssh-server; \
#dnf -y install firewalld; \
#systemctl enable firewalld; systemctl start firewalld; \
#firewall-cmd --permanent --add-service=http; \
#firewall-cmd --permanent --add-service=https; \
#systemctl reload firewalld; \
#dnf install postfix; \
#systemctl enable postfix; systemctl start postfix; \
#curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash; \
#EXTERNAL_URL="http://localhost:8929" dnf -y install gitlab-ce; \
dnf -y install git postgresql-server; \
postgresql-setup initdb; \
su - postgresql; \
psql -c "\
CREATE ROLE gitea WITH LOGIN PASSWORD 'gitea' NOINHERIT VALID UNTIL 'infinity'; \
CREATE DATABASE gitea WITH ENCODING='UTF8' OWNER=gitea; \
"; \
exit; \
systemctl enable postgresql-server; systemctl start postgresql-server; \
wget -O gitea https://dl.gitea.io/gitea/1.16.8/gitea-1.16.8-linux-amd64; \
chmod +x gitea; \
adduser --system --shell /bin/bash --comment 'Git Version Control' --user-group gitea; \
chown -R gitea:gitea gitea; \
mkdir -p /var/lib/gitea/{custom,data,log}; \
chown -R gitea:gitea /var/lib/gitea/; \
chmod -R 750 /var/lib/gitea/; \
mkdir /etc/gitea; \
chown root:gitea /etc/gitea; \
chmod 770 /etc/gitea; \
export GITEA_WORK_DIR=/var/lib/gitea/; \
cp gitea /usr/local/bin/gitea; \
chmod 755 /etc/systemd/system/gitea.service; \
systemctl enable gitea; systemctl start gitea; \
CMD ["/usr/sbin/init"]
