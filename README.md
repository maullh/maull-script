# Maull-Script V1.2.0 - Enhanced Complete VPS Tunneling Solution

![Maull-Script V1.2.0](https://img.shields.io/badge/Maull--Script-V1.2.0-blue.svg)
![OS Support](https://img.shields.io/badge/OS-Ubuntu%20%7C%20Debian%20%7C%20CentOS-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Automation](https://img.shields.io/badge/Automation-100%25-brightgreen.svg)
![Maintenance](https://img.shields.io/badge/Maintenance-Zero-success.svg)

Script otomatis untuk menginstall dan mengelola berbagai protokol tunneling di VPS Linux dengan interface yang elegan, fitur lengkap, dan **MULTIPORT ARCHITECTURE** (semua protokol menggunakan port 443/80) plus **ADVANCED AUTOMATION FEATURES**.

## 🚀 Fitur Utama

### 🔌 Protokol Tunneling
- **SSH WebSocket & SSL** - SSH over WebSocket dengan enkripsi SSL/TLS
- **SSH UDP** - SSH melalui protokol UDP menggunakan Dropbear
- **SSH SlowDNS** - SSH tunneling melalui DNS queries
- **SSH OpenVPN** - VPN dengan protokol OpenVPN
- **ShadowSOCKS** - Proxy dengan enkripsi AES-256-GCM
- **VMess** - V2Ray protocol dengan berbagai transport
- **VLess** - Xray protocol yang lebih ringan
- **Trojan** - Protokol yang menyamar sebagai HTTPS
- **NoobzVPN** - VPN sederhana dan cepat

### 🔐 Enkripsi & Keamanan
- **TLS Multiport 443** - Semua protokol dengan enkripsi TLS pada port 443
- **Non-TLS Multiport 80** - Semua protokol tanpa enkripsi pada port 80
- **Fail2ban Integration** - Perlindungan dari brute force attack
- **Traffic Obfuscation** - Penyamaran traffic untuk menghindari deteksi

### 🚄 Transport Protokol
- **WebSocket** - Transport melalui WebSocket
- **gRPC** - Transport menggunakan gRPC protocol
- **XHTTP** - Transport HTTP yang dioptimasi
- **HTTP Upgrade** - Upgrade koneksi HTTP ke WebSocket
- **Hysteria 2** - Protocol UDP yang cepat
- **TUIC** - Too Unity in Complexity protocol
- **Reality** - VLess Reality untuk bypass DPI

### ⚡ **FITUR AUTOMATION TERBARU**

#### 🕐 **Auto Scheduling**
- **Auto Reboot 00:00** (dapat diubah) - Reboot otomatis setiap hari
- **Auto Update 01:15** - Update script otomatis
- **Auto Backup 11:15** (dapat diubah) - Backup konfigurasi otomatis
- **Auto Delete Expired 02:00** - Hapus user expired otomatis
- **Auto Kill Multi Login** - Kill user yang login berlebihan

#### 🔧 **System Management**
- **CEK RUNNING SERVICE** - Monitor status semua service
- **RESTART SERVICE** - Restart semua service dengan satu klik
- **MONITOR VPS** - Real-time monitoring sistem
- **SPEEDTEST** - Test kecepatan internet VPS
- **FIXX ERROR DOMAIN** - Perbaikan error domain otomatis
- **FIXX ERROR PROXY** - Perbaikan error proxy otomatis
- **FIXX NGINX** - Perbaikan konfigurasi Nginx
- **FIXX WS ePRO** - Perbaikan WebSocket ePRO
- **MENU CLEANER** - Pembersihan menu dan cache

#### 👥 **Advanced User Management**
- **CREATE & DELETE & RENEW & TRIAL ACCOUNT** - Manajemen akun lengkap
- **LOCK & UNLOCK ACCOUNT** - Kunci/buka akun user
- **LIST ACCOUNT** - Daftar semua akun dengan detail
- **LIMIT IP & QUOTA** - Batasi IP dan kuota per user
- **AUTOKILL ACCOUNT** - Kill otomatis user yang melanggar
- **DETAIL ACCOUNT** - Detail lengkap penggunaan akun
- **CEK LOGIN UDP** - Monitor login UDP real-time
- **RECOVERY ACCOUNT** - Pemulihan akun yang bermasalah
- **EDIT LIMIT IP & QUOTA** - Edit batasan user

#### 🌐 **Network & Performance**
- **LIMIT SPEED** - Batasi kecepatan per user
- **SWITCH ON & OFF LIMIT** - Toggle limit speed
- **MONITOR ACCOUNT** - Monitor penggunaan akun real-time
- **MULTI PATH** - Support OPOK ISAT dengan multi path
- **CHANGE DOMAIN** - Ganti domain dengan mudah
- **CHANGE BANNER** - Kustomisasi banner script

#### 💾 **Backup & Restore**
- **BACKUP & RESTORE** - Backup dan restore konfigurasi
- **AUTOBACKUP** - Backup otomatis terjadwal
- **Recovery System** - Sistem pemulihan otomatis

### 📊 Sistem Monitoring
- **Real-time System Monitor** - Monitor CPU, RAM, Disk, Network
- **Service Status Monitoring** - Status semua service secara real-time
- **User Account Management** - Kelola akun user dengan mudah
- **Bandwidth Monitoring** - Monitor penggunaan bandwidth
- **Alert System** - Notifikasi untuk berbagai event

## 🖥️ Sistem yang Didukung

### Ubuntu
- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS  
- Ubuntu 24.04 LTS

### Debian
- Debian 10 (Buster)
- Debian 11 (Bullseye)
- Debian 12 (Bookworm)

### CentOS
- CentOS 7
- CentOS 8
- CentOS Stream

## 📦 Instalasi

### Instalasi Otomatis
```bash
wget -O maull-script.sh https://raw.githubusercontent.com/your-username/maull-script/main/maull-script.sh
chmod +x maull-script.sh
sudo ./maull-script.sh install
```

### Instalasi Langsung
```bash
bash <(curl -L https://raw.githubusercontent.com/your-username/maull-script/main/maull-script.sh)
```

### Instalasi dengan Git
```bash
git clone https://github.com/your-username/maull-script.git
cd maull-script
chmod +x install-tunneling.sh
sudo ./install-tunneling.sh
```

## 🎯 Cara Penggunaan

### Akses Menu
Setelah instalasi, ketik perintah berikut untuk mengakses menu:
```bash
menu
```

### Interface Menu Enhanced
Script ini memiliki interface yang elegan dengan informasi sistem lengkap:
- System information (OS, RAM, Uptime, IP, City, ISP, CPU Usage)
- Service status monitoring real-time
- User account statistics per protokol
- Storage dan bandwidth usage
- Auto scheduling status

## 🌐 MULTIPORT ARCHITECTURE

### 🔥 **REVOLUSI MULTIPORT**
Semua protokol menggunakan **HANYA 5 PORT**:
- **Port 443** (HTTPS/TLS) - Untuk semua protokol dengan enkripsi
- **Port 80** (HTTP/Non-TLS) - Untuk semua protokol tanpa enkripsi
- **Port 22** (SSH) - SSH standard
- **Port 1194** (OpenVPN) - OpenVPN UDP
- **Port 7300** (Dropbear) - SSH UDP

### 📍 **Path-Based Routing Enhanced**
Setiap protokol dan transport memiliki path unik:

#### **VMess Paths:**
- `/vmess-ws` - VMess WebSocket (Port 2001 → 443/80)
- `/vmess-grpc` - VMess gRPC (Port 2002 → 443/80)
- `/vmess-httpupgrade` - VMess HTTP Upgrade (Port 2003 → 443/80)

#### **VLess Paths:**
- `/vless-ws` - VLess WebSocket (Port 2005 → 443/80)
- `/vless-grpc` - VLess gRPC (Port 2006 → 443/80)
- `/vless-httpupgrade` - VLess HTTP Upgrade (Port 2007 → 443/80)

#### **Trojan Paths:**
- `/trojan-ws` - Trojan WebSocket (Port 2010 → 443/80)
- `/trojan-grpc` - Trojan gRPC (Port 2011 → 443/80)

#### **SSH & Other Paths:**
- `/ssh-ws` - SSH WebSocket (Port 2014 → 443/80)
- `/shadowsocks` - Shadowsocks (Port 2016 → 443/80)

## 🔧 **AUTOMATION FEATURES**

### **Auto Scheduling Configuration**
```bash
# Auto Reboot (default 00:00)
0 0 * * * root /sbin/reboot

# Auto Update (01:15)
15 1 * * * root /usr/local/bin/maull-update

# Auto Backup (default 11:15)
15 11 * * * root /usr/local/bin/maull-backup auto

# Auto Delete Expired (02:00)
0 2 * * * root /usr/local/bin/maull-user delete-expired

# Auto Kill Multi Login (every 5 minutes)
*/5 * * * * root /usr/local/bin/maull-autokill
```

### **System Management Commands**
```bash
# Check all running services
systemctl status nginx xray ssh dropbear ssh-ws shadowsocks-libev fail2ban

# Restart all services
systemctl restart nginx xray ssh dropbear ssh-ws shadowsocks-libev

# Monitor VPS real-time
maull-monitor

# Run speedtest
maull-speedtest

# Delete expired users
maull-user delete-expired
```

### **Advanced User Management**
```bash
# Create user with limits
maull-user create username protocol --limit-ip 2 --quota 10GB

# Lock/unlock user
maull-user lock username
maull-user unlock username

# Monitor user login
maull-user monitor username

# Check user details
maull-user detail username

# Edit user limits
maull-user edit username --limit-ip 5 --quota 20GB
```

## 📱 **Enhanced Client Configuration**

### **VMess WebSocket (TLS) dengan Multi Path**
```json
{
  "v": "2",
  "ps": "Maull-Script VMess WS TLS",
  "add": "yourdomain.com",
  "port": "443",
  "id": "your-uuid-here",
  "aid": "0",
  "scy": "auto",
  "net": "ws",
  "type": "none",
  "host": "yourdomain.com",
  "path": "/vmess-ws",
  "tls": "tls",
  "sni": "yourdomain.com",
  "alpn": "h2,http/1.1"
}
```

### **VLess gRPC (TLS) Enhanced**
```json
{
  "v": "2",
  "ps": "Maull-Script VLess gRPC TLS",
  "add": "yourdomain.com",
  "port": "443",
  "id": "your-uuid-here",
  "aid": "0",
  "scy": "auto",
  "net": "grpc",
  "type": "gun",
  "host": "yourdomain.com",
  "path": "vless-grpc",
  "tls": "tls",
  "sni": "yourdomain.com",
  "alpn": "h2"
}
```

### **Trojan gRPC (TLS) Configuration**
```json
{
  "v": "2",
  "ps": "Maull-Script Trojan gRPC TLS",
  "add": "yourdomain.com",
  "port": "443",
  "id": "your-trojan-uuid-here",
  "aid": "0",
  "scy": "auto",
  "net": "grpc",
  "type": "gun",
  "host": "yourdomain.com",
  "path": "trojan-grpc",
  "tls": "tls",
  "sni": "yourdomain.com",
  "alpn": "h2"
}
```

**Port Trojan gRPC:** 2011 → 443/80

## 🔧 **Enhanced System Management**

### **Service Management**
```bash
# Check running services
menu → System Management → Check Running Services

# Restart all services
menu → System Management → Restart All Services

# Auto reboot settings
menu → System Management → Auto Reboot Settings

# Monitor VPS
menu → System Management → Monitor VPS

# Speedtest
menu → System Management → Speedtest

# Delete expired users
menu → System Management → Delete All Expired Users
```

### **Fix & Repair Tools**
```bash
# Fix domain errors
menu → System Management → Fix Error Domain

# Fix proxy errors
menu → System Management → Fix Error Proxy

# Fix Nginx configuration
menu → System Management → Fix Nginx

# Fix WebSocket ePRO
menu → System Management → Fix WS ePRO

# Menu cleaner
menu → System Management → Menu Cleaner
```

## 👥 **Advanced User Management**

### **Create Account with Limits**
```bash
menu → SSH Menu → Create Account
# Input: username, password, expired days, IP limit, quota limit
```

### **Monitor Account Usage**
```bash
menu → Monitor & Tools → Monitor Account Usage
# Real-time monitoring user activity
```

### **Account Management**
```bash
# Lock account
menu → SSH Menu → Lock Account

# Unlock account
menu → SSH Menu → Unlock Account

# Detail account
menu → SSH Menu → Detail Account

# Recovery account
menu → SSH Menu → Recovery Account
```

## 🌐 **Multi Path Support (OPOK ISAT)**

### **Path Configuration**
```bash
# Enable multi path
menu → Advanced Settings → Multi Path Settings

# Configure paths for different ISP
/vmess-ws-opok    # Optimized for OPOK
/vmess-ws-isat    # Optimized for ISAT
/vmess-ws-tsel    # Optimized for Telkomsel
/vmess-ws-xl      # Optimized for XL
```

## 🔐 **Enhanced Security Features**

### **Limit Speed & Quota**
```bash
# Set speed limit per user
menu → Advanced Settings → Limit Speed Settings

# Switch limit ON/OFF
menu → Advanced Settings → Switch ON/OFF Limit

# Set IP & quota limits
menu → Advanced Settings → Limit IP & Quota Settings
```

### **Auto Kill Configuration**
```bash
# Configure auto kill settings
menu → Monitor & Tools → Auto Kill Settings

# Set max login per user
# Set kill interval
# Enable/disable auto kill
```

## 💾 **Enhanced Backup & Restore**

### **Auto Backup Configuration**
```bash
# Configure auto backup
menu → Advanced Settings → Auto Backup Settings

# Set backup time
# Set backup retention
# Enable/disable auto backup
```

### **Manual Backup & Restore**
```bash
# Create backup
menu → Backup & Restore → Create Backup

# Restore backup
menu → Backup & Restore → Restore Backup

# List backups
menu → Backup & Restore → List Backups

# Delete old backups
menu → Backup & Restore → Delete Old Backups
```

## 📊 **Enhanced Monitoring**

### **Real-time Monitoring**
```bash
# System monitor
menu → Monitor & Tools → Real-time System Monitor

# Account usage monitor
menu → Monitor & Tools → Monitor Account Usage

# Bandwidth monitor
menu → Monitor & Tools → Bandwidth Monitor

# Service status monitor
menu → Monitor & Tools → Service Status Monitor
```

### **Log & Statistics**
```bash
# View logs
menu → Monitor & Tools → Log Viewer

# Network statistics
menu → Monitor & Tools → Network Statistics

# Process monitor
menu → Monitor & Tools → Process Monitor

# Disk usage monitor
menu → Monitor & Tools → Disk Usage Monitor
```

## 🎨 **Customization Features**

### **Change Banner**
```bash
menu → Advanced Settings → Change Banner
# Customize script banner with your own text/logo
```

### **Domain Management**
```bash
menu → Domain Management → Change Domain
# Change domain with automatic SSL configuration
```

## 🔄 **Auto Update System**

### **Auto Update Configuration**
```bash
# Configure auto update
menu → Advanced Settings → Auto Update Settings

# Set update time
# Enable/disable auto update
# Set update channel (stable/beta)
```

### **Manual Update**
```bash
# Update script
menu → Update Script

# Or use command
maull-update
```

## 🛠️ **Troubleshooting Enhanced**

### **Auto Fix Tools**
```bash
# Fix domain errors
menu → System Management → Fix Error Domain

# Fix proxy errors
menu → System Management → Fix Error Proxy

# Fix Nginx
menu → System Management → Fix Nginx

# Fix WebSocket ePRO
menu → System Management → Fix WS ePRO
```

### **Manual Troubleshooting**
```bash
# Check service status
systemctl status nginx xray ssh dropbear ssh-ws shadowsocks-libev

# Restart services
systemctl restart nginx xray ssh-ws

# Check logs
tail -f /var/log/maull-script/*.log
tail -f /var/log/nginx/error.log
tail -f /var/log/xray/error.log
```

## 🌟 **Keunggulan Enhanced Features**

### **Automation Benefits**
- **Zero Maintenance** - Semua berjalan otomatis
- **Auto Recovery** - Sistem perbaikan otomatis
- **Smart Monitoring** - Monitoring cerdas dengan alert
- **Efficient Resource** - Optimasi penggunaan resource

### **User Management Benefits**
- **Advanced Control** - Kontrol user yang sangat detail
- **Real-time Monitoring** - Monitor user secara real-time
- **Flexible Limits** - Batasan yang fleksibel dan mudah diatur
- **Auto Enforcement** - Penegakan aturan otomatis

### **Performance Benefits**
- **Multi Path Optimization** - Optimasi jalur untuk berbagai ISP
- **Speed Limiting** - Kontrol kecepatan yang presisi
- **Resource Management** - Manajemen resource yang efisien
- **Load Balancing** - Distribusi beban yang optimal

## 📞 **Support & Community**

### **Documentation**
- [Installation Guide](INSTALLATION.md)
- [Advanced Features Guide](ADVANCED-FEATURES.md)
- [Troubleshooting Guide](TROUBLESHOOTING-GUIDE.md)
- [GitHub Setup Guide](GITHUB-SETUP.md)

### **Community**
- GitHub Issues: Bug reports dan feature requests
- Telegram Group: @MaullScript
- Discord Server: discord.gg/maullscript
- YouTube Channel: Tutorial dan update

## 📄 **Changelog V1.2.0**

### **New Features**
- ✅ Auto Reboot dengan waktu yang dapat diatur
- ✅ Auto Update terjadwal
- ✅ Auto Backup dengan retention policy
- ✅ Enhanced user management dengan limit IP & quota
- ✅ Multi path support untuk berbagai ISP
- ✅ Speed limiting per user
- ✅ Auto kill multi login
- ✅ Real-time monitoring dashboard
- ✅ Advanced troubleshooting tools
- ✅ Custom banner support
- ✅ Enhanced backup & restore system

### **Improvements**
- 🔧 Optimized multiport architecture
- 🔧 Enhanced security features
- 🔧 Better error handling
- 🔧 Improved performance
- 🔧 Enhanced logging system
- 🔧 Better user interface

### **Bug Fixes**
- 🐛 Fixed SSL certificate auto-renewal
- 🐛 Fixed WebSocket connection issues
- 🐛 Fixed user expiration handling
- 🐛 Fixed service restart issues
- 🐛 Fixed backup corruption issues

## ⚠️ **Disclaimer**

- Script ini dibuat untuk tujuan edukasi dan penggunaan pribadi
- Pengguna bertanggung jawab penuh atas penggunaan script ini
- Pastikan mematuhi hukum dan regulasi setempat
- Gunakan dengan bijak dan bertanggung jawab

## 🙏 **Acknowledgments**

Terima kasih kepada:
- V2Ray/Xray development team
- Nginx development team
- OpenVPN community
- Shadowsocks community
- Semua kontributor dan beta tester
- Community feedback dan suggestions

---

**Maull-Script V1.2.0** - The Ultimate Automated VPS Tunneling Solution! 🚀

### 🔥 **AUTOMATION REVOLUTION**
*"One Script, Full Automation, Zero Maintenance"*

**Traditional VPS Management:** Manual setup, manual monitoring, manual maintenance  
**Maull-Script V1.2.0:** Full automation, smart monitoring, zero maintenance

*Making VPS tunneling fully automated, intelligent, and powerful!*

### 📈 **Performance Stats**
- **Setup Time:** 5-10 minutes (fully automated)
- **Maintenance Time:** 0 minutes (fully automated)
- **Monitoring:** Real-time (automated alerts)
- **Backup:** Automated with retention
- **Updates:** Automated with rollback
- **User Management:** Advanced with limits
- **Troubleshooting:** Automated fix tools

**Experience the future of VPS management today!** 🌟

### 🎯 **Quick Start**
```bash
# One-line installation
bash <(curl -L https://raw.githubusercontent.com/your-username/maull-script/main/install-tunneling.sh)

# Access menu after installation
menu
```

### 🔗 **Useful Links**
- 📖 [Documentation](README.md)
- ⚡ [Advanced Features](ADVANCED-FEATURES.md)
- 🛠️ [Troubleshooting](TROUBLESHOOTING-GUIDE.md)
- 🐙 [GitHub Setup](GITHUB-SETUP.md)
- 🌐 [Preview Interface](preview.html)

**Ready to revolutionize your VPS management? Install now!** 🚀