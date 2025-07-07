# Maull-Script V1.2.0 - Enhanced Troubleshooting Guide

## 📋 Daftar Isi
1. [Masalah Instalasi](#masalah-instalasi)
2. [Masalah Service](#masalah-service)
3. [Masalah SSL/Domain](#masalah-ssldomain)
4. [Masalah Network](#masalah-network)
5. [Masalah User Management](#masalah-user-management)
6. [Masalah Performance](#masalah-performance)
7. [Masalah Automation](#masalah-automation)
8. [Recovery & Backup](#recovery--backup)
9. [Monitoring & Debugging](#monitoring--debugging)
10. [Advanced Troubleshooting](#advanced-troubleshooting)

## 🚨 Masalah Instalasi

### Script Gagal Install
**Gejala:** Script berhenti di tengah instalasi
```bash
# Cek log instalasi
tail -f /var/log/maull-script/install.log

# Cek space disk
df -h

# Cek memory
free -m

# Cek koneksi internet
ping -c 4 8.8.8.8
```

**Solusi:**
```bash
# Bersihkan instalasi yang gagal
rm -rf /etc/maull-script
rm -rf /var/log/maull-script
apt autoremove -y

# Install ulang dengan clean environment
./install-tunneling.sh install
```

### OS Tidak Didukung
**Gejala:** Error "OS not supported"
```bash
# Cek versi OS
cat /etc/os-release

# Cek apakah OS didukung
lsb_release -a
```

**Solusi:**
- Pastikan menggunakan Ubuntu 20.04+, Debian 10+, atau CentOS 7+
- Update OS ke versi yang didukung

### Permission Denied
**Gejala:** Error permission saat instalasi
```bash
# Pastikan running sebagai root
whoami

# Cek permission file script
ls -la install-tunneling.sh
```

**Solusi:**
```bash
# Jalankan sebagai root
sudo su -
chmod +x install-tunneling.sh
./install-tunneling.sh
```

### System Requirements Not Met
**Gejala:** Error system requirements
```bash
# Cek memory minimum (512MB)
free -m

# Cek disk space minimum (2GB)
df -h

# Cek internet connection
curl -I google.com
```

**Solusi:**
```bash
# Upgrade VPS jika specs tidak mencukupi
# Atau bersihkan disk space
apt clean
apt autoremove
```

## 🔧 Masalah Service

### Nginx Tidak Berjalan
**Diagnosis:**
```bash
# Cek status nginx
systemctl status nginx

# Cek konfigurasi nginx
nginx -t

# Cek log error
tail -f /var/log/nginx/error.log

# Cek port yang digunakan
netstat -tulpn | grep :80
netstat -tulpn | grep :443
```

**Solusi:**
```bash
# Restart nginx
systemctl restart nginx

# Jika ada error konfigurasi
nginx -t
# Fix error yang muncul

# Jika port sudah digunakan
lsof -i :80
kill -9 PID_YANG_MENGGUNAKAN_PORT

# Reload konfigurasi
systemctl reload nginx
```

### Xray Tidak Berjalan
**Diagnosis:**
```bash
# Cek status xray
systemctl status xray

# Test konfigurasi xray
/usr/local/bin/xray -test -config /usr/local/etc/xray/config.json

# Cek log xray
tail -f /var/log/xray/error.log

# Cek port xray
netstat -tulpn | grep :2001
```

**Solusi:**
```bash
# Restart xray
systemctl restart xray

# Jika konfigurasi error
nano /usr/local/etc/xray/config.json
# Perbaiki syntax JSON

# Regenerate config
UUID=$(cat /proc/sys/kernel/random/uuid)
# Update UUID di config

# Reload service
systemctl daemon-reload
systemctl restart xray
```

### SSH WebSocket Error
**Diagnosis:**
```bash
# Cek service ssh-ws
systemctl status ssh-ws

# Cek port 2014
netstat -tulpn | grep :2014

# Test koneksi websocket
curl -i -N -H "Connection: Upgrade" -H "Upgrade: websocket" -H "Sec-WebSocket-Key: test" -H "Sec-WebSocket-Version: 13" http://localhost:2014/
```

**Solusi:**
```bash
# Restart ssh-ws service
systemctl restart ssh-ws

# Jika service tidak ada
systemctl daemon-reload
systemctl enable ssh-ws
systemctl start ssh-ws

# Cek script ssh-ws
cat /usr/local/bin/ssh-ws
# Pastikan script ada dan executable
chmod +x /usr/local/bin/ssh-ws
```

### Shadowsocks Error
**Diagnosis:**
```bash
# Cek status shadowsocks
systemctl status shadowsocks-libev

# Cek konfigurasi
cat /etc/shadowsocks-libev/config.json

# Cek port 2016
netstat -tulpn | grep :2016
```

**Solusi:**
```bash
# Restart shadowsocks
systemctl restart shadowsocks-libev

# Jika konfigurasi error
nano /etc/shadowsocks-libev/config.json
# Pastikan JSON valid

# Regenerate password
SS_PASSWORD=$(pwgen -s 32 1)
# Update password di config
```

### Dropbear SSH UDP Error
**Diagnosis:**
```bash
# Cek status dropbear
systemctl status dropbear

# Cek port 7300
netstat -tulpn | grep :7300

# Cek konfigurasi dropbear
cat /etc/default/dropbear
```

**Solusi:**
```bash
# Restart dropbear
systemctl restart dropbear

# Jika tidak terinstall
apt install -y dropbear-bin

# Konfigurasi ulang
echo 'DROPBEAR_PORT=7300' > /etc/default/dropbear
echo 'DROPBEAR_EXTRA_ARGS="-p 7300 -j -k"' >> /etc/default/dropbear
```

## 🔐 Masalah SSL/Domain

### SSL Certificate Gagal
**Diagnosis:**
```bash
# Cek certificate
certbot certificates

# Cek domain accessibility
curl -I http://your-domain.com

# Cek DNS resolution
dig +short your-domain.com

# Cek port 80 terbuka
telnet your-domain.com 80
```

**Solusi:**
```bash
# Manual certificate request
certbot certonly --nginx -d your-domain.com

# Jika domain tidak pointing
# Update DNS A record ke IP server

# Jika port 80 blocked
ufw allow 80
systemctl restart nginx

# Force renew certificate
certbot renew --force-renewal
```

### Domain Tidak Bisa Diakses
**Diagnosis:**
```bash
# Cek DNS propagation
nslookup your-domain.com
dig your-domain.com

# Cek nginx config
nginx -t
cat /etc/nginx/sites-enabled/multiport

# Cek firewall
ufw status
```

**Solusi:**
```bash
# Tunggu DNS propagation (24-48 jam)
# Atau gunakan DNS checker online

# Fix nginx config
nano /etc/nginx/sites-enabled/multiport
nginx -t
systemctl reload nginx

# Open firewall ports
ufw allow 80
ufw allow 443
```

### Mixed Content Error
**Diagnosis:**
```bash
# Cek HTTPS redirect
curl -I http://your-domain.com

# Cek SSL configuration
openssl s_client -connect your-domain.com:443
```

**Solusi:**
```bash
# Pastikan semua HTTP redirect ke HTTPS
nano /etc/nginx/sites-enabled/multiport

# Tambahkan redirect rule:
# return 301 https://$server_name$request_uri;

systemctl reload nginx
```

## 🌐 Masalah Network

### Port Tidak Terbuka
**Diagnosis:**
```bash
# Cek firewall status
ufw status verbose

# Cek port listening
netstat -tulpn

# Test port dari luar
telnet your-server-ip port-number
```

**Solusi:**
```bash
# Buka port yang diperlukan
ufw allow 22    # SSH
ufw allow 80    # HTTP
ufw allow 443   # HTTPS
ufw allow 1194  # OpenVPN
ufw allow 7300  # SSH UDP

# Reload firewall
ufw reload
```

### Koneksi Lambat
**Diagnosis:**
```bash
# Cek bandwidth
iftop

# Cek load average
uptime

# Cek memory usage
free -m

# Cek disk I/O
iostat -x 1
```

**Solusi:**
```bash
# Optimize TCP settings
echo 'net.core.default_qdisc=fq' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_congestion_control=bbr' >> /etc/sysctl.conf
sysctl -p

# Restart network services
systemctl restart networking

# Optimize nginx
nano /etc/nginx/nginx.conf
# Increase worker_connections
# Enable gzip compression
```

### DDoS Attack
**Diagnosis:**
```bash
# Cek koneksi aktif
ss -tuln | wc -l

# Cek top connections
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n

# Cek fail2ban status
fail2ban-client status
```

**Solusi:**
```bash
# Enable rate limiting di nginx
nano /etc/nginx/nginx.conf

# Tambahkan:
# limit_req_zone $binary_remote_addr zone=login:10m rate=10r/m;
# limit_conn_zone $binary_remote_addr zone=conn_limit_per_ip:10m;

# Update fail2ban config
nano /etc/fail2ban/jail.local
# Kurangi maxretry dan bantime

systemctl restart fail2ban
systemctl reload nginx
```

## 👤 Masalah User Management

### User Tidak Bisa Login
**Diagnosis:**
```bash
# Cek user exists
id username

# Cek user expiration
chage -l username

# Cek SSH logs
tail -f /var/log/auth.log

# Test SSH connection
ssh username@localhost
```

**Solusi:**
```bash
# Reset password
passwd username

# Extend expiration
chage -E -1 username

# Unlock account
usermod -U username

# Check SSH config
nano /etc/ssh/sshd_config
systemctl restart ssh
```

### User Database Corrupt
**Diagnosis:**
```bash
# Cek user files
ls -la /etc/maull-script/users/

# Validate JSON files
for file in /etc/maull-script/users/*.json; do
    echo "Checking $file"
    jq . "$file" > /dev/null
done
```

**Solusi:**
```bash
# Backup user database
cp -r /etc/maull-script/users /root/users-backup

# Fix corrupt JSON
nano /etc/maull-script/users/corrupt-file.json

# Recreate user database
rm -rf /etc/maull-script/users
mkdir -p /etc/maull-script/users

# Re-add users manually
maull-user add username protocol
```

### User Limit Issues
**Diagnosis:**
```bash
# Cek user limits
cat /etc/maull-script/users/username.json

# Cek active connections
who | grep username

# Cek bandwidth usage
vnstat -i eth0
```

**Solusi:**
```bash
# Update user limits
maull-user edit username --ip-limit 5 --quota 20GB

# Reset quota usage
maull-user quota reset username

# Kill excess sessions
pkill -u username
```

## ⚡ Masalah Performance

### High CPU Usage
**Diagnosis:**
```bash
# Cek top processes
top -o %CPU

# Cek service yang menggunakan CPU tinggi
systemctl status service-name

# Monitor CPU usage
htop
```

**Solusi:**
```bash
# Restart service yang bermasalah
systemctl restart service-name

# Optimize nginx worker processes
nano /etc/nginx/nginx.conf
# Set worker_processes auto;

# Limit connections
# limit_conn conn_limit_per_ip 10;
```

### High Memory Usage
**Diagnosis:**
```bash
# Cek memory usage
free -m

# Cek processes menggunakan memory tinggi
ps aux --sort=-%mem | head

# Cek swap usage
swapon -s
```

**Solusi:**
```bash
# Add swap file jika belum ada
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' >> /etc/fstab

# Restart services
systemctl restart nginx xray
```

### Disk Space Full
**Diagnosis:**
```bash
# Cek disk usage
df -h

# Cek file besar
du -sh /* | sort -rh

# Cek log files
du -sh /var/log/*
```

**Solusi:**
```bash
# Clean log files
journalctl --vacuum-time=7d
logrotate -f /etc/logrotate.conf

# Clean package cache
apt clean
apt autoremove

# Clean temporary files
rm -rf /tmp/*
rm -rf /var/tmp/*
```

## 🤖 Masalah Automation

### Auto Reboot Tidak Berjalan
**Diagnosis:**
```bash
# Cek cron job
crontab -l
cat /etc/cron.d/maull-automation

# Cek cron service
systemctl status cron

# Cek log cron
tail -f /var/log/cron.log
```

**Solusi:**
```bash
# Restart cron service
systemctl restart cron

# Re-create cron job
echo "0 0 * * * root /usr/local/bin/maull-autoreboot" > /etc/cron.d/maull-automation

# Test manual
/usr/local/bin/maull-autoreboot
```

### Auto Update Gagal
**Diagnosis:**
```bash
# Cek update script
cat /usr/local/bin/maull-update

# Cek log update
tail -f /var/log/maull-script/autoupdate.log

# Test manual update
/usr/local/bin/maull-update
```

**Solusi:**
```bash
# Fix update script
chmod +x /usr/local/bin/maull-update

# Update manual
apt update && apt upgrade -y

# Re-create update script jika corrupt
```

### Auto Backup Gagal
**Diagnosis:**
```bash
# Cek backup script
cat /usr/local/bin/maull-backup

# Cek backup directory
ls -la /root/maull-backup/

# Cek log backup
tail -f /var/log/maull-script/autobackup.log
```

**Solusi:**
```bash
# Fix backup script
chmod +x /usr/local/bin/maull-backup

# Create backup directory
mkdir -p /root/maull-backup

# Test manual backup
/usr/local/bin/maull-backup
```

### Auto Kill Multi Login Tidak Berjalan
**Diagnosis:**
```bash
# Cek autokill script
cat /usr/local/bin/maull-autokill

# Cek log autokill
tail -f /var/log/maull-script/autokill.log

# Test manual
/usr/local/bin/maull-autokill
```

**Solusi:**
```bash
# Fix autokill script
chmod +x /usr/local/bin/maull-autokill

# Update cron job
echo "*/5 * * * * root /usr/local/bin/maull-autokill" >> /etc/cron.d/maull-automation

# Restart cron
systemctl restart cron
```

## 💾 Recovery & Backup

### Backup Konfigurasi
```bash
# Create backup directory
mkdir -p /root/maull-backup/$(date +%Y%m%d)

# Backup configurations
cp -r /etc/maull-script /root/maull-backup/$(date +%Y%m%d)/
cp -r /etc/nginx /root/maull-backup/$(date +%Y%m%d)/
cp -r /usr/local/etc/xray /root/maull-backup/$(date +%Y%m%d)/
cp /etc/shadowsocks-libev/config.json /root/maull-backup/$(date +%Y%m%d)/

# Backup SSL certificates
cp -r /etc/letsencrypt /root/maull-backup/$(date +%Y%m%d)/

# Create archive
tar -czf /root/maull-backup-$(date +%Y%m%d).tar.gz /root/maull-backup/$(date +%Y%m%d)
```

### Restore Konfigurasi
```bash
# Extract backup
tar -xzf /root/maull-backup-YYYYMMDD.tar.gz

# Restore configurations
cp -r /root/maull-backup/YYYYMMDD/maull-script /etc/
cp -r /root/maull-backup/YYYYMMDD/nginx /etc/
cp -r /root/maull-backup/YYYYMMDD/xray /usr/local/etc/

# Restart services
systemctl restart nginx xray shadowsocks-libev ssh-ws
```

### Emergency Recovery
```bash
# Jika script rusak total, reinstall
rm -rf /etc/maull-script
rm -rf /var/log/maull-script
rm /usr/local/bin/menu
rm /usr/local/bin/maull-*

# Download dan install ulang
wget -O install-tunneling.sh https://raw.githubusercontent.com/your-username/maull-script/main/install-tunneling.sh
chmod +x install-tunneling.sh
./install-tunneling.sh install
```

### System Recovery Mode
```bash
# Boot ke recovery mode jika sistem tidak bisa boot
# Atau gunakan VPS console

# Mount filesystem
mount /dev/vda1 /mnt

# Chroot ke sistem
chroot /mnt

# Fix critical issues
systemctl disable nginx xray
systemctl enable ssh

# Reboot
exit
reboot
```

## 🔍 Monitoring & Debugging

### Enable Debug Mode
```bash
# Set debug environment
export MAULL_DEBUG=1

# Run script dengan debug
bash -x maull-script.sh

# Enable verbose logging
echo "MAULL_DEBUG=1" >> /etc/maull-script/config.env
```

### Real-time Monitoring
```bash
# Monitor all logs
tail -f /var/log/maull-script/*.log /var/log/nginx/*.log /var/log/xray/*.log

# Monitor system resources
watch -n 1 'free -m; echo ""; df -h; echo ""; uptime'

# Monitor network connections
watch -n 1 'ss -tuln | wc -l; echo "Active connections"'

# Monitor service status
watch -n 5 'systemctl is-active nginx xray ssh dropbear shadowsocks-libev'
```

### Performance Monitoring
```bash
# Install monitoring tools
apt install -y htop iotop nethogs vnstat

# Monitor CPU and memory
htop

# Monitor disk I/O
iotop

# Monitor network usage per process
nethogs

# Monitor bandwidth usage
vnstat -l
```

### Log Analysis
```bash
# Analyze nginx access log
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr | head -10

# Analyze failed SSH attempts
grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr

# Analyze xray connections
grep "accepted" /var/log/xray/access.log | wc -l

# Check for errors
grep -i error /var/log/maull-script/*.log
```

## 🔧 Advanced Troubleshooting

### Network Connectivity Issues
```bash
# Test connectivity to different servers
ping -c 4 8.8.8.8
ping -c 4 1.1.1.1
ping -c 4 google.com

# Test DNS resolution
nslookup google.com
dig google.com

# Test specific ports
telnet google.com 80
telnet google.com 443

# Check routing
traceroute google.com
```

### SSL/TLS Issues
```bash
# Test SSL connection
openssl s_client -connect yourdomain.com:443

# Check certificate details
openssl x509 -in /etc/letsencrypt/live/yourdomain.com/cert.pem -text -noout

# Test SSL configuration
curl -I https://yourdomain.com

# Check SSL labs rating
# https://www.ssllabs.com/ssltest/
```

### Performance Optimization
```bash
# Optimize kernel parameters
cat >> /etc/sysctl.conf << EOF
# Network optimization
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.tcp_congestion_control = bbr
net.core.default_qdisc = fq

# Security
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
EOF

sysctl -p
```

### Security Hardening
```bash
# Harden SSH configuration
cat >> /etc/ssh/sshd_config << EOF
# Security hardening
Protocol 2
PermitRootLogin yes
PasswordAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
PermitEmptyPasswords no
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding no
PrintMotd no
ClientAliveInterval 300
ClientAliveCountMax 2
MaxAuthTries 3
MaxSessions 10
EOF

systemctl restart ssh
```

### Database Maintenance
```bash
# Clean user database
find /etc/maull-script/users -name "*.json" -exec jq . {} \; > /dev/null

# Optimize user database
for file in /etc/maull-script/users/*.json; do
    jq . "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done

# Backup user database
tar -czf /root/users-backup-$(date +%Y%m%d).tar.gz /etc/maull-script/users/
```

## 🆘 Emergency Contacts & Resources

### Quick Commands Reference
```bash
# Restart all services
systemctl restart nginx xray ssh dropbear shadowsocks-libev ssh-ws fail2ban

# Check all service status
systemctl status nginx xray ssh dropbear shadowsocks-libev ssh-ws fail2ban

# View all logs
journalctl -f

# Emergency stop all
systemctl stop nginx xray ssh-ws

# Emergency firewall reset
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable
```

### System Diagnostic Script
```bash
# Run comprehensive diagnostic
/usr/local/bin/maull-diagnostic

# Or manual diagnostic
cat > /tmp/diagnostic.sh << 'EOF'
#!/bin/bash
echo "=== MAULL-SCRIPT DIAGNOSTIC ==="
echo "Date: $(date)"
echo "Version: V1.2.0"
echo ""

echo "=== SYSTEM INFO ==="
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Load: $(uptime | awk -F'load average:' '{print $2}')"
echo ""

echo "=== RESOURCES ==="
echo "CPU: $(nproc) cores"
echo "Memory: $(free -h | awk 'NR==2{printf "%s/%s (%.2f%%)", $3,$2,$3*100/$2}')"
echo "Disk: $(df -h / | awk 'NR==2{printf "%s/%s (%s)", $3,$2,$5}')"
echo ""

echo "=== SERVICES ==="
services=("nginx" "xray" "ssh" "dropbear" "ssh-ws" "shadowsocks-libev")
for service in "${services[@]}"; do
    status=$(systemctl is-active $service 2>/dev/null)
    echo "$service: $status"
done
echo ""

echo "=== PORTS ==="
ports=("22" "80" "443" "7300" "1194")
for port in "${ports[@]}"; do
    status=$(ss -tuln | grep ":$port " >/dev/null && echo "OPEN" || echo "CLOSED")
    echo "Port $port: $status"
done
echo ""

echo "=== AUTOMATION ==="
echo "Cron status: $(systemctl is-active cron)"
echo "Auto reboot: $(crontab -l | grep reboot | wc -l) jobs"
echo "Auto backup: $(crontab -l | grep backup | wc -l) jobs"
echo "Auto update: $(crontab -l | grep update | wc -l) jobs"
EOF

chmod +x /tmp/diagnostic.sh
/tmp/diagnostic.sh
```

### Useful Resources
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Xray Documentation](https://xtls.github.io/)
- [Certbot Documentation](https://certbot.eff.org/)
- [UFW Documentation](https://help.ubuntu.com/community/UFW)
- [Systemd Documentation](https://systemd.io/)

### Support Channels
- GitHub Issues: Report bugs dan feature requests
- Documentation: Baca dokumentasi lengkap
- Community Forum: Diskusi dengan pengguna lain
- Emergency Contact: admin@maull-script.com

---

**Catatan:** Selalu backup konfigurasi sebelum melakukan perubahan besar. Jika masalah masih berlanjut, jangan ragu untuk membuat issue di GitHub repository dengan informasi diagnostic lengkap.

**Emergency Recovery:** Jika sistem benar-benar rusak, gunakan VPS console untuk boot ke recovery mode dan jalankan emergency recovery script.