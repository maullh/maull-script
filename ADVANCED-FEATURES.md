# Maull-Script V1.2.0 - Advanced Features Documentation

## 📋 Daftar Isi
1. [Auto Scheduling Features](#auto-scheduling-features)
2. [Advanced User Management](#advanced-user-management)
3. [System Management Tools](#system-management-tools)
4. [Monitoring & Analytics](#monitoring--analytics)
5. [Multi Path Configuration](#multi-path-configuration)
6. [Speed Limiting & Quota](#speed-limiting--quota)
7. [Backup & Recovery System](#backup--recovery-system)
8. [Troubleshooting Tools](#troubleshooting-tools)
9. [Customization Options](#customization-options)
10. [API & Integration](#api--integration)

## 🕐 Auto Scheduling Features

### **Auto Reboot System**
Sistem reboot otomatis yang dapat dikonfigurasi untuk menjaga stabilitas server.

#### **Konfigurasi Auto Reboot**
```bash
# Akses menu
menu → Advanced Settings → Auto Reboot Time Settings

# Atau edit manual
echo "0 0" > /etc/maull-script/reboot_time  # 00:00 setiap hari
echo "30 2" > /etc/maull-script/reboot_time  # 02:30 setiap hari
```

#### **Cron Configuration**
```bash
# Auto reboot cron job
0 0 * * * root /sbin/reboot

# Custom time example
30 2 * * * root /sbin/reboot  # Reboot at 02:30
```

### **Auto Update System**
Update otomatis script dan komponen sistem.

#### **Konfigurasi Auto Update**
```bash
# Default: Update setiap hari jam 01:15
15 1 * * * root /usr/local/bin/maull-update

# Custom configuration
menu → Advanced Settings → Auto Update Settings
```

#### **Update Channels**
- **Stable Channel** - Update stabil yang sudah ditest
- **Beta Channel** - Update terbaru dengan fitur experimental
- **Security Channel** - Hanya security updates

### **Auto Backup System**
Backup otomatis konfigurasi dan data user.

#### **Konfigurasi Auto Backup**
```bash
# Default: Backup setiap hari jam 11:15
15 11 * * * root /usr/local/bin/maull-backup auto

# Custom backup time
menu → Advanced Settings → Auto Backup Settings
```

#### **Backup Retention Policy**
```bash
# Keep last 7 days
BACKUP_RETENTION=7

# Keep last 30 days
BACKUP_RETENTION=30

# Unlimited (not recommended)
BACKUP_RETENTION=0
```

### **Auto Delete Expired Users**
Hapus otomatis user yang sudah expired.

#### **Konfigurasi**
```bash
# Default: Check setiap hari jam 02:00
0 2 * * * root /usr/local/bin/maull-user delete-expired

# Custom configuration
menu → System Management → Delete All Expired Users
```

### **Auto Kill Multi Login**
Kill otomatis user yang login berlebihan.

#### **Konfigurasi Auto Kill**
```bash
# Check setiap 5 menit
*/5 * * * * root /usr/local/bin/maull-autokill

# Configuration file
/etc/maull-script/autokill.conf
```

#### **Auto Kill Settings**
```bash
# Maximum login per user
MAX_LOGIN=2

# Kill action (disconnect/lock/ban)
KILL_ACTION=disconnect

# Grace period before kill (seconds)
GRACE_PERIOD=300

# Whitelist users (comma separated)
WHITELIST_USERS=admin,vip1,vip2
```

## 👥 Advanced User Management

### **Create Account with Advanced Options**
Buat akun dengan berbagai opsi lanjutan.

#### **SSH Account Creation**
```bash
menu → SSH Menu → Create Account

# Input options:
# - Username
# - Password
# - Expired days
# - IP limit (max simultaneous connections)
# - Quota limit (bandwidth quota)
# - Speed limit (Mbps)
# - Multi login limit
```

#### **User Database Structure**
```json
{
  "username": "testuser",
  "password": "encrypted_password",
  "protocol": "ssh",
  "created_date": "2024-01-15",
  "exp_date": "2024-02-15",
  "ip_limit": 2,
  "quota_limit": "10GB",
  "speed_limit": "10Mbps",
  "multi_login_limit": 2,
  "status": "active",
  "last_login": "2024-01-20 10:30:00",
  "total_usage": "2.5GB",
  "login_history": []
}
```

### **Account Management Operations**

#### **Lock/Unlock Account**
```bash
# Lock account
menu → SSH Menu → Lock Account
# atau
maull-user lock username

# Unlock account
menu → SSH Menu → Unlock Account
# atau
maull-user unlock username
```

#### **Account Details & Statistics**
```bash
# View detailed account info
menu → SSH Menu → Detail Account

# Command line
maull-user detail username

# Output example:
Username: testuser
Protocol: SSH
Status: Active
Created: 2024-01-15
Expires: 2024-02-15
IP Limit: 2
Quota Limit: 10GB
Speed Limit: 10Mbps
Current Usage: 2.5GB (25%)
Active Connections: 1
Last Login: 2024-01-20 10:30:00
```

#### **Edit Account Limits**
```bash
# Edit account limits
menu → SSH Menu → Edit Account

# Command line
maull-user edit username --ip-limit 5 --quota 20GB --speed 20Mbps
```

### **Account Monitoring**

#### **Real-time Account Monitor**
```bash
# Monitor specific account
menu → Monitor & Tools → Monitor Account Usage

# Command line
maull-user monitor username

# Real-time output:
[10:30:15] testuser: 1 connection, 150KB/s down, 50KB/s up
[10:30:20] testuser: 1 connection, 200KB/s down, 75KB/s up
[10:30:25] testuser: 2 connections, 300KB/s down, 100KB/s up
```

#### **Check Login UDP**
```bash
# Check UDP login status
menu → Monitor & Tools → Check Login UDP

# Shows:
# - Active UDP connections
# - User mapping
# - Bandwidth usage
# - Connection duration
```

### **Account Recovery**
```bash
# Recover problematic account
menu → SSH Menu → Recovery Account

# Recovery actions:
# - Reset password
# - Clear login sessions
# - Reset quota usage
# - Unlock account
# - Fix permissions
```

## 🔧 System Management Tools

### **Service Management**

#### **Check Running Services**
```bash
menu → System Management → Check Running Services

# Shows status of:
# - Nginx (Reverse Proxy)
# - Xray (Core Protocol)
# - SSH (Standard SSH)
# - Dropbear (SSH UDP)
# - SSH-WS (SSH WebSocket)
# - Shadowsocks (SS Protocol)
# - Fail2ban (Security)
# - UFW (Firewall)
```

#### **Restart All Services**
```bash
menu → System Management → Restart All Services

# Restart sequence:
# 1. Stop all services
# 2. Check configurations
# 3. Start services in order
# 4. Verify status
# 5. Report results
```

### **System Monitoring**

#### **Monitor VPS**
```bash
menu → System Management → Monitor VPS

# Real-time display:
# - CPU usage and load average
# - Memory usage (RAM/Swap)
# - Disk usage and I/O
# - Network statistics
# - Active connections
# - Service status
# - Temperature (if available)
```

#### **Speedtest**
```bash
menu → System Management → Speedtest

# Tests:
# - Download speed
# - Upload speed
# - Ping latency
# - Jitter
# - Server location
# - ISP information
```

### **Fix & Repair Tools**

#### **Fix Error Domain**
```bash
menu → System Management → Fix Error Domain

# Fixes:
# - DNS resolution issues
# - SSL certificate problems
# - Nginx domain configuration
# - Domain pointing verification
# - Certificate renewal
```

#### **Fix Error Proxy**
```bash
menu → System Management → Fix Error Proxy

# Fixes:
# - Proxy configuration errors
# - Backend connection issues
# - Load balancing problems
# - Upstream server errors
# - Proxy headers
```

#### **Fix Nginx**
```bash
menu → System Management → Fix Nginx

# Fixes:
# - Configuration syntax errors
# - Permission issues
# - Log rotation problems
# - Virtual host conflicts
# - SSL configuration
```

#### **Fix WebSocket ePRO**
```bash
menu → System Management → Fix WS ePRO

# Fixes:
# - WebSocket connection issues
# - Upgrade header problems
# - Proxy pass configuration
# - Connection timeout
# - Buffer size issues
```

#### **Menu Cleaner**
```bash
menu → System Management → Menu Cleaner

# Cleans:
# - Temporary files
# - Log files (old)
# - Cache files
# - Orphaned processes
# - Unused configurations
```

## 📊 Monitoring & Analytics

### **Real-time System Monitor**
```bash
menu → Monitor & Tools → Real-time System Monitor

# Dashboard shows:
# - CPU usage graph
# - Memory usage graph
# - Disk I/O graph
# - Network traffic graph
# - Active processes
# - System load
# - Temperature sensors
```

### **Bandwidth Monitor**
```bash
menu → Monitor & Tools → Bandwidth Monitor

# Features:
# - Real-time bandwidth usage
# - Per-user bandwidth tracking
# - Daily/monthly statistics
# - Top bandwidth users
# - Traffic analysis
# - Export reports
```

### **Service Status Monitor**
```bash
menu → Monitor & Tools → Service Status Monitor

# Monitors:
# - Service uptime
# - Response time
# - Error rates
# - Resource usage per service
# - Restart history
# - Performance metrics
```

### **Log Viewer**
```bash
menu → Monitor & Tools → Log Viewer

# Available logs:
# - System logs (syslog)
# - Nginx access/error logs
# - Xray logs
# - SSH logs
# - Authentication logs
# - Custom application logs
```

### **Network Statistics**
```bash
menu → Monitor & Tools → Network Statistics

# Shows:
# - Interface statistics
# - Connection states
# - Routing table
# - Firewall rules
# - Port usage
# - Protocol distribution
```

### **Process Monitor**
```bash
menu → Monitor & Tools → Process Monitor

# Features:
# - Real-time process list
# - CPU/Memory usage per process
# - Process tree view
# - Kill process capability
# - Process history
# - Resource alerts
```

### **Disk Usage Monitor**
```bash
menu → Monitor & Tools → Disk Usage Monitor

# Shows:
# - Disk space usage
# - Inode usage
# - Large files finder
# - Directory size analysis
# - Disk I/O statistics
# - Mount point status
```

## 🌐 Multi Path Configuration

### **Multi Path Support (OPOK ISAT)**
Konfigurasi jalur khusus untuk berbagai provider ISP Indonesia.

#### **Path Configuration**
```bash
menu → Advanced Settings → Multi Path Settings

# Available paths:
/vmess-ws-opok     # Optimized for OPOK
/vmess-ws-isat     # Optimized for Indosat
/vmess-ws-tsel     # Optimized for Telkomsel
/vmess-ws-xl       # Optimized for XL Axiata
/vmess-ws-tri      # Optimized for 3 (Tri)
/vmess-ws-smart    # Optimized for Smartfren
```

#### **ISP-Specific Optimization**
```nginx
# OPOK optimization
location /vmess-ws-opok {
    proxy_pass http://127.0.0.1:2001;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_connect_timeout 60s;
    proxy_send_timeout 60s;
    proxy_read_timeout 60s;
    proxy_buffering off;
}

# Indosat optimization
location /vmess-ws-isat {
    proxy_pass http://127.0.0.1:2001;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_connect_timeout 30s;
    proxy_send_timeout 30s;
    proxy_read_timeout 30s;
    proxy_buffer_size 4k;
    proxy_buffers 8 4k;
}
```

#### **Client Configuration for Multi Path**
```json
{
  "v": "2",
  "ps": "Maull-Script VMess OPOK",
  "add": "yourdomain.com",
  "port": "443",
  "id": "your-uuid-here",
  "aid": "0",
  "scy": "auto",
  "net": "ws",
  "type": "none",
  "host": "yourdomain.com",
  "path": "/vmess-ws-opok",
  "tls": "tls",
  "sni": "yourdomain.com",
  "alpn": "h2,http/1.1"
}
```

## ⚡ Speed Limiting & Quota

### **Speed Limiting Configuration**
```bash
menu → Advanced Settings → Limit Speed Settings

# Global speed limit
GLOBAL_SPEED_LIMIT=100Mbps

# Per-user speed limit
USER_SPEED_LIMIT=10Mbps

# VIP user speed limit
VIP_SPEED_LIMIT=50Mbps
```

#### **Traffic Control Implementation**
```bash
# Install traffic control tools
apt install -y iproute2 tc

# Create speed limit script
cat > /usr/local/bin/speed-limit << 'EOF'
#!/bin/bash
# Speed limiting using tc (traffic control)

USER=$1
SPEED=$2

# Create class for user
tc class add dev eth0 parent 1: classid 1:$USER htb rate $SPEED

# Add filter for user traffic
tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip src $USER_IP flowid 1:$USER
EOF
```

### **Quota Management**
```bash
# Set user quota
maull-user quota set username 10GB

# Check quota usage
maull-user quota check username

# Reset quota
maull-user quota reset username

# Quota warning levels
QUOTA_WARNING_75=true
QUOTA_WARNING_90=true
QUOTA_SUSPEND_100=true
```

#### **Quota Monitoring Script**
```bash
cat > /usr/local/bin/quota-monitor << 'EOF'
#!/bin/bash
# Monitor user quota usage

for user_file in /etc/maull-script/users/*.json; do
    username=$(jq -r '.username' $user_file)
    quota_limit=$(jq -r '.quota_limit' $user_file)
    current_usage=$(jq -r '.total_usage' $user_file)
    
    # Calculate percentage
    usage_percent=$(echo "scale=2; $current_usage * 100 / $quota_limit" | bc)
    
    # Check warning levels
    if (( $(echo "$usage_percent >= 100" | bc -l) )); then
        # Suspend user
        maull-user suspend $username
        echo "User $username suspended - quota exceeded"
    elif (( $(echo "$usage_percent >= 90" | bc -l) )); then
        # Send warning
        echo "Warning: User $username at 90% quota usage"
    elif (( $(echo "$usage_percent >= 75" | bc -l) )); then
        # Send notification
        echo "Notice: User $username at 75% quota usage"
    fi
done
EOF
```

### **Switch Limit ON/OFF**
```bash
menu → Advanced Settings → Switch ON/OFF Limit

# Global limit switch
echo "enabled" > /etc/maull-script/limit_status
echo "disabled" > /etc/maull-script/limit_status

# Per-user limit switch
maull-user limit enable username
maull-user limit disable username
```

## 💾 Backup & Recovery System

### **Enhanced Backup System**
```bash
menu → Backup & Restore → Create Backup

# Backup includes:
# - All configurations (/etc/maull-script)
# - Nginx configuration (/etc/nginx)
# - Xray configuration (/usr/local/etc/xray)
# - SSL certificates (/etc/letsencrypt)
# - User database
# - System settings
# - Custom scripts
```

#### **Backup Configuration**
```bash
# Backup settings
BACKUP_DIR="/root/maull-backup"
BACKUP_RETENTION=7  # Keep 7 days
BACKUP_COMPRESSION=true
BACKUP_ENCRYPTION=false
BACKUP_REMOTE=false

# Remote backup settings
REMOTE_HOST=""
REMOTE_USER=""
REMOTE_PATH=""
REMOTE_KEY=""
```

#### **Auto Backup Script**
```bash
cat > /usr/local/bin/maull-backup << 'EOF'
#!/bin/bash
# Enhanced backup script

BACKUP_NAME="maull-backup-$(date +%Y%m%d-%H%M%S)"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

# Create backup directory
mkdir -p $BACKUP_PATH

# Backup configurations
cp -r /etc/maull-script $BACKUP_PATH/
cp -r /etc/nginx $BACKUP_PATH/
cp -r /usr/local/etc/xray $BACKUP_PATH/
cp -r /etc/letsencrypt $BACKUP_PATH/ 2>/dev/null

# Backup system info
uname -a > $BACKUP_PATH/system_info.txt
df -h > $BACKUP_PATH/disk_usage.txt
free -m > $BACKUP_PATH/memory_info.txt

# Create archive
cd $BACKUP_DIR
tar -czf $BACKUP_NAME.tar.gz $BACKUP_NAME

# Encrypt if enabled
if [[ $BACKUP_ENCRYPTION == "true" ]]; then
    gpg --symmetric --cipher-algo AES256 $BACKUP_NAME.tar.gz
    rm $BACKUP_NAME.tar.gz
fi

# Upload to remote if enabled
if [[ $BACKUP_REMOTE == "true" ]]; then
    scp -i $REMOTE_KEY $BACKUP_NAME.tar.gz* $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH/
fi

# Cleanup old backups
find $BACKUP_DIR -name "maull-backup-*.tar.gz*" -mtime +$BACKUP_RETENTION -delete

# Cleanup temp directory
rm -rf $BACKUP_NAME

echo "Backup completed: $BACKUP_NAME.tar.gz"
EOF
```

### **Recovery System**
```bash
menu → Backup & Restore → Restore Backup

# Recovery options:
# - Full restore (all configurations)
# - Partial restore (select components)
# - User data only
# - Configuration only
# - Emergency recovery
```

#### **Emergency Recovery**
```bash
# Emergency recovery script
cat > /usr/local/bin/emergency-recovery << 'EOF'
#!/bin/bash
# Emergency recovery for critical failures

echo "Starting emergency recovery..."

# Stop all services
systemctl stop nginx xray ssh-ws shadowsocks-libev

# Restore default configurations
cp /etc/maull-script/backup/nginx.conf.default /etc/nginx/nginx.conf
cp /etc/maull-script/backup/xray.json.default /usr/local/etc/xray/config.json

# Reset permissions
chown -R www-data:www-data /var/www
chmod -R 755 /var/www

# Restart services
systemctl start nginx xray ssh-ws shadowsocks-libev

# Verify services
systemctl status nginx xray ssh-ws shadowsocks-libev

echo "Emergency recovery completed"
EOF
```

## 🛠️ Troubleshooting Tools

### **Automated Diagnostic Tools**
```bash
# System diagnostic
menu → System Management → System Diagnostic

# Network diagnostic
menu → System Management → Network Diagnostic

# Service diagnostic
menu → System Management → Service Diagnostic
```

#### **System Diagnostic Script**
```bash
cat > /usr/local/bin/system-diagnostic << 'EOF'
#!/bin/bash
# Comprehensive system diagnostic

echo "=== SYSTEM DIAGNOSTIC REPORT ==="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime)"
echo ""

echo "=== SYSTEM RESOURCES ==="
echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F'%' '{print $1}')%"
echo "Memory: $(free -m | awk 'NR==2{printf "%.1f/%.1fGB (%.2f%%)", $3/1024, $2/1024, $3*100/$2}')"
echo "Disk: $(df -h / | awk 'NR==2{printf "%s/%s (%s)", $3, $2, $5}')"
echo ""

echo "=== NETWORK STATUS ==="
echo "IP Address: $(curl -s ipinfo.io/ip)"
echo "DNS Resolution: $(nslookup google.com | grep -A1 "Name:" | tail -1 | awk '{print $2}')"
echo "Internet Connectivity: $(ping -c1 8.8.8.8 >/dev/null 2>&1 && echo "OK" || echo "FAILED")"
echo ""

echo "=== SERVICE STATUS ==="
services=("nginx" "xray" "ssh" "dropbear" "ssh-ws" "shadowsocks-libev")
for service in "${services[@]}"; do
    status=$(systemctl is-active $service)
    echo "$service: $status"
done
echo ""

echo "=== PORT STATUS ==="
ports=("22" "80" "443" "7300")
for port in "${ports[@]}"; do
    status=$(netstat -tuln | grep ":$port " >/dev/null && echo "OPEN" || echo "CLOSED")
    echo "Port $port: $status"
done
echo ""

echo "=== LOG ERRORS ==="
echo "Nginx errors (last 10):"
tail -10 /var/log/nginx/error.log 2>/dev/null || echo "No errors found"
echo ""
echo "Xray errors (last 10):"
tail -10 /var/log/xray/error.log 2>/dev/null || echo "No errors found"
echo ""

echo "=== RECOMMENDATIONS ==="
# Add diagnostic recommendations based on findings
EOF
```

### **Auto Fix Tools**
```bash
# Auto fix common issues
menu → System Management → Auto Fix

# Fix categories:
# - Configuration errors
# - Permission issues
# - Service failures
# - Network problems
# - SSL certificate issues
```

## 🎨 Customization Options

### **Custom Banner**
```bash
menu → Advanced Settings → Change Banner

# Banner examples:
# ASCII art banner
# Company logo
# Custom welcome message
# System information display
```

#### **Banner Templates**
```bash
# Template 1: ASCII Art
cat > /etc/maull-script/banner << 'EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                           YOUR COMPANY NAME                                  ║
║                        VPS Tunneling Solution                               ║
║                           Powered by Maull-Script                           ║
╚══════════════════════════════════════════════════════════════════════════════╝
EOF

# Template 2: Minimalist
cat > /etc/maull-script/banner << 'EOF'
========================================
    VPS Management Panel v1.2.0
    Server: $(hostname)
    IP: $(curl -s ipinfo.io/ip)
========================================
EOF
```

### **Theme Customization**
```bash
# Color themes
menu → Advanced Settings → Theme Settings

# Available themes:
# - Default (Green/Blue)
# - Dark (Black/White)
# - Corporate (Blue/Gray)
# - Hacker (Green/Black)
# - Custom (User defined)
```

### **Menu Customization**
```bash
# Custom menu items
menu → Advanced Settings → Menu Customization

# Add custom menu items:
# - Custom scripts
# - External tools
# - Quick actions
# - Shortcuts
```

## 🔌 API & Integration

### **REST API Endpoints**
```bash
# Enable API
menu → Advanced Settings → API Settings

# API endpoints:
GET    /api/v1/status          # System status
GET    /api/v1/users           # List users
POST   /api/v1/users           # Create user
PUT    /api/v1/users/{id}      # Update user
DELETE /api/v1/users/{id}      # Delete user
GET    /api/v1/services        # Service status
POST   /api/v1/services/restart # Restart services
GET    /api/v1/stats           # System statistics
```

### **Webhook Integration**
```bash
# Configure webhooks
menu → Advanced Settings → Webhook Settings

# Webhook events:
# - User created
# - User expired
# - Service down
# - High resource usage
# - Backup completed
# - Update available
```

### **Third-party Integration**
```bash
# Telegram bot integration
TELEGRAM_BOT_TOKEN="your_bot_token"
TELEGRAM_CHAT_ID="your_chat_id"

# Discord webhook
DISCORD_WEBHOOK_URL="your_webhook_url"

# Slack integration
SLACK_WEBHOOK_URL="your_slack_webhook"

# Email notifications
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="587"
SMTP_USER="your_email@gmail.com"
SMTP_PASS="your_app_password"
```

---

**Maull-Script V1.2.0** - Advanced Features untuk VPS Management yang Powerful! 🚀

Dokumentasi ini mencakup semua fitur advanced yang tersedia. Untuk informasi lebih detail tentang implementasi atau troubleshooting, silakan merujuk ke dokumentasi teknis atau hubungi support team.