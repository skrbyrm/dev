#!/bin/bash

# Update and upgrade Ubuntu
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y ca-certificates curl gnupg ca-certificates lsb-release

# Install Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
# Add the current user to the docker group to run Docker commands without sudo
sudo usermod -aG docker $USER

# Enable UFW (Uncomplicated Firewall)
sudo ufw enable

# Open ports in UFW
sudo ufw allow 22
sudo ufw allow 1433
sudo ufw allow 3306
sudo ufw allow 3000
sudo ufw allow 5000
sudo ufw allow 5432
sudo ufw allow 80
sudo ufw allow 8080
sudo ufw allow 6443
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250
sudo ufw allow 10259
sudo ufw allow 10257
sudo ufw allow 30000:32000/tcp

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLNbC8lAN49RmKbNGP20kVtkz3my4++X55j4Qy07UU8G/6NG0lYcUv5de7z/Ci82NRL5tg73adsj/TcxO4FK+1MehXrFMpLTRnVAbdBBSlldzM7YkbyQIf/uNdp3mw1XDP0JxhmAsccoat41VXJpmy1sAUGgrSdoEYEqK9aihQc7PVxyH21hIbw+xLRU7bMEABCBZwq8BGkppZeAeQB/1xhIZcpJB7+GNq4DZzDkxZ1OD76AMPFay9NNYiAaLm3rXb2ItOdCdmeto92GjLQ6aS1uGoJY5V62EuFXarBuD9w8xf3JdWvDKTCP/MI+uvQlgbVUhf6EUJwSWCXtQBB5RKi46OHtEJP5wq4rWx1//t1D7/kroAGFnkJ+NXpnAfJntjDJhm26hglHt7MF9ye8UQO1nYJ4WDPEsTjvtRavqxZi5qG2yckX9ozjOvlyWPZr1iVSUUtcOIEIYa59jUoKHWDOGnY/qI6l2uegmi4/XWrfRFHnCjNtG0AX8UnEMxKsU= sakir@Kuasar" >> /root/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2MSyylNiTzXFnsKNClA1qnH2sRoHH0SlU2gsDsDu61Ty2ppsF4T7EzfsmqKE1KLBSkf0Sj1ho6bJi1a6jO7JycRF55Dn9OMTn9Vjf9j/Axts1bKKxSbRPYI2Jxs9bGX5cTN3N6DY3YpzGboTiR2Pc/C0+/TAx066no/bZdC71zHIXa74dL+IDJ3/7ltdhbuj3VzW8VIXmVutCrvjoSKuOx/a4SaRo3ATqzsxcf3h64SG8piUvQeLkedCicOm8hlV7Cj8hpzN+Ey9yPnazKsy93DzmVdYmNDSzRIMAQUM3TqGrPV0Okuvp0UkPtKbHdJY52D92UcNIyAl5cPNLDbAD root" >> /root/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDsUNqYkllTrpE4pOLDjRuHRuftwzhx9+PJOtu7r2NuiKmw7k+jRBAKpmxBAKb1KNAL1o2e3UIUwa8j8xrdCiPH51Hw7N33+jF66L9yfmL523Ne2kvK3HjxC6AVK5JtSX5RN2ToTeFWJAKkhfqV6hROZw7rv99IvVAV2zfAhs1XVWyY8yrgkfvyGcWgfj3vX3fH+JC+EOpwnAIKqz5ceE1p5MH2S8HTPyEVxTmfMN387otdBA0aF7Mib8EWfvcHbwjrfUH8JHDKJzPzjb4v04Lq8RHQ0Z8jZt5S77YrPkAU6HYWpv+/Yz8mvbfmShK2KeBw5Z6UomoBC6illpI/t1775jLm5MaZT8hy2YQBOqaYucsQKUJBzUY95rF1CpsZsV5KTDYRrhPDmGaHAu/AiLyXbcDNg1SkYJnX115/2Pmi8tminzaVLLHkiC+jH05QbIUb1JoTX8nf494nHIcnEvsbiotYWg0FZiiA3CgHN+jY7YBfP/Xm3qj/o3UdFdo4giE= root@instance-1" >> /root/.ssh/authorized_keys
