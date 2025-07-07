# Maull-Script V1 - Complete VPS Tunneling Solution

![Maull-Script V1](https://img.shields.io/badge/Maull--Script-V1.0.0-blue.svg)
![OS Support](https://img.shields.io/badge/OS-Ubuntu%20%7C%20Debian-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

Script otomatis untuk menginstall dan mengelola berbagai protokol tunneling di VPS Linux dengan interface yang elegan dan fitur lengkap.

## 🚀 Fitur Utama

### Protokol Tunneling
- **SSH WebSocket & SSL** - SSH over WebSocket dengan enkripsi SSL/TLS
- **SSH UDP** - SSH melalui protokol UDP menggunakan Dropbear
- **SSH SlowDNS** - SSH tunneling melalui DNS queries
- **SSH OpenVPN** - VPN dengan protokol OpenVPN
- **ShadowSOCKS** - Proxy dengan enkripsi AES-256-GCM
- **VMess** - V2Ray protocol dengan berbagai transport
- **VLess** - Xray protocol yang lebih ringan
- **Trojan** - Protokol yang menyamar sebagai HTTPS
- **NoobzVPN** - VPN sederhana dan cepat

### Enkripsi & Keamanan
- **TLS Multiport 443** - Enkripsi TLS pada port 443
- **Non-TLS Multiport 80** - Koneksi tanpa enkripsi pada port 80
- **Fail2ban Integration** - Perlindungan dari brute force attack
- **Traffic Obfuscation** - Penyamaran traffic untuk menghindari deteksi

### Transport Protokol
- **WebSocket** - Transport melalui WebSocket
- **gRPC** - Transport menggunakan gRPC protocol
- **XHTTP** - Transport HTTP yang dioptimasi
- **HTTP Upgrade** - Upgrade koneksi HTTP ke WebSocket
- **Hysteria 2** - Protocol UDP yang cepat
- **TUIC** - Too Unity in Complexity protocol
- **Reality** - VLess Reality untuk bypass DPI

### Sistem Monitoring
- **Real-time System Monitor** - Monitor CPU, RAM, Disk, Network
- **Service Status Monitoring** - Status semua service secara real-time
- **User Account Management** - Kelola akun user dengan mudah
- **Bandwidth Monitoring** - Monitor penggunaan bandwidth
- **Alert System** - Notifikasi untuk berbagai event

### Fitur Lanjutan
- **Auto SSL Certificate** - Otomatis mendapatkan dan memperbarui SSL
- **Domain Management** - Kelola domain dengan mudah
- **CDN Integration** - Integrasi dengan CDN untuk performa optimal
- **Traffic Engineering** - Optimasi traffic dan QoS
- **Automated Troubleshooting** - Diagnosis dan perbaikan otomatis
- **Backup & Restore** - Backup dan restore konfigurasi

## 🖥️ Sistem yang Didukung

### Ubuntu
- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS  
- Ubuntu 24.04 LTS

### Debian
- Debian 10 (Buster)
- Debian 11 (Bullseye)
- Debian 12 (Bookworm)

## 📦 Instalasi

### Instalasi Otomatis
```bash
wget -O maull-script.sh https://raw.githubusercontent.com/your-username/maull-script/main/maull-script.sh
chmod +x maull-script.sh
sudo ./maull-script.sh
```

### Instalasi Langsung
```bash
bash <(curl -L https://raw.githubusercontent.com/your-username/maull-script/main/maull-script.sh)
```

## 🎯 Cara Penggunaan

### Akses Menu
Setelah instalasi, ketik perintah berikut untuk mengakses menu:
```bash
menu
```

### Interface Menu
Script ini memiliki interface yang elegan dengan informasi sistem lengkap:
- System information (OS, RAM, Uptime, IP, City, ISP)
- Service status monitoring
- User account statistics
- Storage dan bandwidth usage

### Konfigurasi Domain
1. Pilih menu "Domain Settings"
2. Masukkan domain dan email
3. Script akan otomatis mengkonfigurasi SSL certificate
4. Nginx reverse proxy akan dikonfigurasi otomatis

## 🔧 Manajemen Service

### Restart Semua Service
```bash
systemctl restart nginx xray ssh dropbear openvpn shadowsocks-libev
```

### Cek Status Service
```bash
systemctl status nginx
systemctl status xray
systemctl status ssh
systemctl status dropbear
systemctl status openvpn
systemctl status shadowsocks-libev
```

### Cek Log Service
```bash
# Nginx logs
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log

# Xray logs
tail -f /var/log/xray/access.log
tail -f /var/log/xray/error.log

# System logs
journalctl -u xray -f
journalctl -u nginx -f
```

## 👥 Manajemen User

### Membuat User SSH
```bash
maull-user add username ssh
```

### Menghapus User
```bash
maull-user delete username ssh
```

### List Semua User
```bash
maull-user list
```

### Hitung User per Protokol
```bash
maull-user count ssh
maull-user count vless
maull-user count vmess
```

## 🔐 Konfigurasi Keamanan

### Fail2ban
Script otomatis mengkonfigurasi Fail2ban untuk:
- SSH brute force protection
- Nginx HTTP auth protection
- Rate limiting protection

### Firewall (UFW)
Port yang dibuka otomatis:
- 22 (SSH)
- 80 (HTTP)
- 443 (HTTPS)
- 8080 (SSH WebSocket)
- 8443 (SSH SSL)
- 1194 (OpenVPN)
- 7300 (SSH UDP)
- 8388 (Shadowsocks)
- 10000-10100 (Xray services)

## 📁 Struktur File

### Direktori Konfigurasi
```
/etc/maull-script/          # Konfigurasi utama
├── config.env              # Environment variables
├── users/                  # Database user
└── backup/                 # Backup files

/var/log/maull-script/      # Log files
├── install.log             # Installation log
├── access.log              # Access log
└── error.log               # Error log

/usr/local/bin/             # Executable files
├── menu                    # Menu command
├── maull-user              # User management
└── maull-script.sh         # Main script
```

### File Konfigurasi Service
```
/etc/nginx/                 # Nginx configuration
├── nginx.conf              # Main config
├── sites-available/        # Available sites
└── sites-enabled/          # Enabled sites

/usr/local/etc/xray/        # Xray configuration
└── config.json             # Xray config

/etc/shadowsocks-libev/     # Shadowsocks config
└── config.json             # SS config
```

## 🛠️ Troubleshooting

### Service Tidak Berjalan
```bash
# Cek status service
systemctl status service-name

# Restart service
systemctl restart service-name

# Cek log error
journalctl -u service-name -f
```

### SSL Certificate Error
```bash
# Renew SSL certificate
certbot renew

# Test SSL
certbot certificates

# Force renew
certbot renew --force-renewal
```

### Port Tidak Terbuka
```bash
# Cek firewall status
ufw status

# Buka port manual
ufw allow port-number

# Restart firewall
ufw reload
```

### Nginx Error
```bash
# Test konfigurasi
nginx -t

# Reload konfigurasi
nginx -s reload

# Restart nginx
systemctl restart nginx
```

### Xray Tidak Berjalan
```bash
# Cek konfigurasi
/usr/local/bin/xray -test -config /usr/local/etc/xray/config.json

# Restart xray
systemctl restart xray

# Cek log
tail -f /var/log/xray/error.log
```

## 📊 Monitoring & Maintenance

### System Monitor
Akses melalui menu untuk melihat:
- CPU usage real-time
- Memory usage
- Disk usage
- Network statistics
- Active connections
- Service status

### Log Monitoring
```bash
# Monitor semua log
tail -f /var/log/maull-script/*.log

# Monitor access log
tail -f /var/log/nginx/access.log

# Monitor system log
journalctl -f
```

### Backup Otomatis
Script menyediakan fitur backup otomatis untuk:
- Konfigurasi semua service
- Database user
- SSL certificates
- Custom settings

## 🔄 Update Script

### Manual Update
```bash
wget -O /tmp/maull-script-new.sh https://raw.githubusercontent.com/your-username/maull-script/main/maull-script.sh
chmod +x /tmp/maull-script-new.sh
cp /tmp/maull-script-new.sh /root/maull-script.sh
```

### Auto Update (Coming Soon)
Fitur auto-update akan tersedia di versi mendatang.

## 🐛 Debugging

### Debug Mode
Jalankan script dengan debug mode:
```bash
bash -x maull-script.sh
```

### Verbose Logging
Enable verbose logging:
```bash
export MAULL_DEBUG=1
./maull-script.sh
```

### Common Issues

#### 1. Domain tidak pointing ke server
```bash
# Cek DNS resolution
dig +short your-domain.com

# Bandingkan dengan server IP
curl -s ipinfo.io/ip
```

#### 2. SSL Certificate gagal
```bash
# Cek domain accessibility
curl -I http://your-domain.com

# Manual certificate request
certbot certonly --nginx -d your-domain.com
```

#### 3. Service conflict
```bash
# Cek port yang digunakan
netstat -tulpn | grep :port-number

# Kill process yang menggunakan port
kill -9 PID
```

## 📞 Support & Kontribusi

### Melaporkan Bug
Jika menemukan bug, silakan buat issue di GitHub dengan informasi:
- OS dan versi
- Error message lengkap
- Langkah untuk reproduce
- Log file terkait

### Kontribusi
Kontribusi sangat diterima! Silakan:
1. Fork repository
2. Buat feature branch
3. Commit changes
4. Push ke branch
5. Buat Pull Request

### Diskusi
Join diskusi di:
- GitHub Discussions
- Telegram Group (Coming Soon)
- Discord Server (Coming Soon)

## 📄 Lisensi

Script ini dirilis di bawah lisensi MIT. Lihat file [LICENSE](LICENSE) untuk detail lengkap.

## ⚠️ Disclaimer

- Script ini dibuat untuk tujuan edukasi dan penggunaan pribadi
- Pengguna bertanggung jawab penuh atas penggunaan script ini
- Pastikan mematuhi hukum dan regulasi setempat
- Gunakan dengan bijak dan bertanggung jawab

## 🙏 Acknowledgments

Terima kasih kepada:
- V2Ray/Xray development team
- Nginx development team
- OpenVPN community
- Shadowsocks community
- Semua kontributor open source

---

**Maull-Script V1** - Making VPS tunneling simple and powerful! 🚀