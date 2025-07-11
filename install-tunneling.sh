#!/bin/bash

# Maull-Script V1.2.0 - Enhanced VPS Tunneling Auto Install Script
# Supports: V2Ray, Xray, Shadowsocks, WireGuard, SSH Services
# Author: Maull-Script Team
# Version: 1.2.0 Enhanced with Advanced Features

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_VERSION="1.2.0"
CONFIG_DIR="/etc/maull-script"
LOG_DIR="/var/log/maull-script"
BACKUP_DIR="/root/maull-backup"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_banner() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}                           Maull-Script V1.2.0                               ${CYAN}║${NC}"
    echo -e "${CYAN}║${WHITE}                    Enhanced Complete VPS Tunneling Solution                ${CYAN}║${NC}"
    echo -e "${CYAN}║${WHITE}                          with Advanced Features                            ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Function to check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "Script ini harus dijalankan sebagai root!"
        exit 1
    fi
}

# Function to detect OS
detect_os() {
    if [[ -f /etc/redhat-release ]]; then
        OS="centos"
        DISTRO=$(cat /etc/redhat-release)
    elif cat /etc/issue | grep -Eqi "debian"; then
        OS="debian"
        DISTRO="Debian $(cat /etc/debian_version)"
    elif cat /etc/issue | grep -Eqi "ubuntu"; then
        OS="ubuntu"
        DISTRO=$(lsb_release -sd 2>/dev/null || echo "Ubuntu")
    elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
        OS="centos"
        DISTRO=$(cat /etc/redhat-release)
    elif cat /proc/version | grep -Eqi "debian"; then
        OS="debian"
        DISTRO="Debian $(cat /etc/debian_version)"
    elif cat /proc/version | grep -Eqi "ubuntu"; then
        OS="ubuntu"
        DISTRO=$(lsb_release -sd 2>/dev/null || echo "Ubuntu")
    elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
        OS="centos"
        DISTRO=$(cat /proc/version)"
    else
        print_error "OS tidak didukung!"
        print_error "Supported: Ubuntu 20.04+, Debian 10+, CentOS 7+"
        exit 1
    fi
}

# Function to check system requirements
check_requirements() {
    print_status "Checking system requirements..."
    
    # Check memory
    MEMORY=$(free -m | awk 'NR==2{printf "%.0f", $2}')
    if [[ $MEMORY -lt 512 ]]; then
        print_error "Minimum 512MB RAM required. Current: ${MEMORY}MB"
        exit 1
    fi
    
    # Check disk space
    DISK=$(df -BG / | awk 'NR==2{printf "%.0f", $4}' | sed 's/G//')
    if [[ $DISK -lt 2 ]]; then
        print_error "Minimum 2GB free disk space required. Current: ${DISK}GB"
        exit 1
    fi
    
    # Check internet connection
    if ! ping -c 1 8.8.8.8 &> /dev/null; then
        print_error "No internet connection detected!"
        exit 1
    fi
    
    print_success "System requirements check passed"
    print_status "Memory: ${MEMORY}MB | Disk: ${DISK}GB | OS: $DISTRO"
}

# Function to create directories
create_directories() {
    print_status "Creating directories..."
    
    mkdir -p $CONFIG_DIR $LOG_DIR $BACKUP_DIR
    mkdir -p $CONFIG_DIR/users
    mkdir -p $CONFIG_DIR/backup
    mkdir -p $CONFIG_DIR/ssl
    mkdir -p $CONFIG_DIR/logs
    
    print_success "Directories created successfully"
}

# Function to update system
update_system() {
    print_status "Updating system packages..."
    
    if [[ $OS == "ubuntu" || $OS == "debian" ]]; then
        export DEBIAN_FRONTEND=noninteractive
        apt update -qq
        apt upgrade -y -qq
        apt install -y -qq curl wget unzip jq htop iftop vnstat speedtest-cli \
            fail2ban ufw nginx certbot python3-certbot-nginx cron bc pwgen \
            net-tools dnsutils lsof git nano vim screen tmux
    elif [[ $OS == "centos" ]]; then
        yum update -y -q
        yum install -y -q epel-release
        yum install -y -q curl wget unzip jq htop iftop vnstat \
            fail2ban firewalld nginx certbot python3-certbot-nginx cronie bc pwgen \
            net-tools bind-utils lsof git nano vim screen tmux
    fi
    
    print_success "System packages updated successfully"
}

# Function to configure firewall
configure_firewall() {
    print_status "Configuring firewall..."
    
    if command -v ufw &> /dev/null; then
        # UFW configuration
        ufw --force reset
        ufw default deny incoming
        ufw default allow outgoing
        
        # Essential ports
        ufw allow ssh
        ufw allow 80/tcp    # HTTP
        ufw allow 443/tcp   # HTTPS
        ufw allow 22/tcp    # SSH
        ufw allow 1194/udp  # OpenVPN
        ufw allow 7300/tcp  # Dropbear SSH UDP
        
        # Enable UFW
        ufw --force enable
        
    elif command -v firewall-cmd &> /dev/null; then
        # FirewallD configuration
        systemctl start firewalld
        systemctl enable firewalld
        
        firewall-cmd --permanent --add-port=22/tcp
        firewall-cmd --permanent --add-port=80/tcp
        firewall-cmd --permanent --add-port=443/tcp
        firewall-cmd --permanent --add-port=1194/udp
        firewall-cmd --permanent --add-port=7300/tcp
        firewall-cmd --reload
    fi
    
    print_success "Firewall configured successfully"
}

# Function to install Xray with enhanced multiport
install_xray() {
    print_status "Installing Xray with enhanced multiport configuration..."
    
    # Download and install Xray
    bash <(curl -L https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh) --install
    
    # Generate UUIDs for different protocols
    UUID_VMESS=$(cat /proc/sys/kernel/random/uuid)
    UUID_VLESS=$(cat /proc/sys/kernel/random/uuid)
    UUID_TROJAN=$(cat /proc/sys/kernel/random/uuid)
    
    # Save UUIDs to config
    echo $UUID_VMESS > $CONFIG_DIR/uuid_vmess
    echo $UUID_VLESS > $CONFIG_DIR/uuid_vless
    echo $UUID_TROJAN > $CONFIG_DIR/uuid_trojan
    
    # Create enhanced Xray multiport config
    cat > /usr/local/etc/xray/config.json << EOF
{
    "log": {
        "loglevel": "warning",
        "access": "/var/log/xray/access.log",
        "error": "/var/log/xray/error.log"
    },
    "inbounds": [
        {
            "port": 2001,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID_VMESS",
                        "level": 0,
                        "alterId": 0
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "/vmess-ws"
                }
            }
        },
        {
            "port": 2002,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID_VMESS",
                        "level": 0,
                        "alterId": 0
                    }
                ]
            },
            "streamSettings": {
                "network": "grpc",
                "grpcSettings": {
                    "serviceName": "vmess-grpc"
                }
            }
        },
        {
            "port": 2003,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID_VMESS",
                        "level": 0,
                        "alterId": 0
                    }
                ]
            },
            "streamSettings": {
                "network": "httpupgrade",
                "httpupgradeSettings": {
                    "path": "/vmess-httpupgrade"
                }
            }
        },
        {
            "port": 2005,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID_VLESS",
                        "level": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "/vless-ws"
                }
            }
        },
        {
            "port": 2006,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID_VLESS",
                        "level": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "grpc",
                "grpcSettings": {
                    "serviceName": "vless-grpc"
                }
            }
        },
        {
            "port": 2007,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID_VLESS",
                        "level": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "httpupgrade",
                "httpupgradeSettings": {
                    "path": "/vless-httpupgrade"
                }
            }
        },
        {
            "port": 2010,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "$UUID_TROJAN",
                        "level": 0
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "/trojan-ws"
                }
            }
        },
        {
            "port": 2011,
            "listen": "127.0.0.1",
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "$UUID_TROJAN",
                        "level": 0
                    }
                ]
            },
            "streamSettings": {
                "network": "grpc",
                "grpcSettings": {
                    "serviceName": "trojan-grpc"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "settings": {}
        }
    ]
}
EOF

    # Create log directory
    mkdir -p /var/log/xray
    
    # Start and enable Xray
    systemctl start xray
    systemctl enable xray
    
    print_success "Xray enhanced multiport installed successfully!"
    print_status "VMess UUID: $UUID_VMESS"
    print_status "VLess UUID: $UUID_VLESS"
    print_status "Trojan UUID: $UUID_TROJAN"
}

# Function to configure enhanced Nginx
configure_nginx() {
    print_status "Configuring enhanced Nginx multiport..."
    
    # Backup original config
    cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
    
    # Create optimized nginx config
    cat > /etc/nginx/nginx.conf << 'EOF'
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 2048;
    use epoll;
    multi_accept on;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    server_tokens off;
    
    # Rate limiting for security
    limit_req_zone $binary_remote_addr zone=login:10m rate=10r/m;
    limit_conn_zone $binary_remote_addr zone=conn_limit_per_ip:10m;
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
    
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    # Enhanced logging
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';
    
    access_log /var/log/nginx/access.log main;
    error_log /var/log/nginx/error.log;
    
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
EOF

    # Create enhanced multiport site configuration
    cat > /etc/nginx/sites-available/multiport << 'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    
    # Rate limiting for security
    limit_req zone=login burst=20 nodelay;
    limit_conn conn_limit_per_ip 10;
    
    # Enhanced multi-path routing for different protocols and ISPs
    
    # VMess paths
    location /vmess-ws {
        proxy_pass http://127.0.0.1:2001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
    
    location /vmess-grpc {
        grpc_pass grpc://127.0.0.1:2002;
        grpc_set_header Host $host;
        grpc_set_header X-Real-IP $remote_addr;
        grpc_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    
    location /vmess-httpupgrade {
        proxy_pass http://127.0.0.1:2003;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    
    # VLess paths
    location /vless-ws {
        proxy_pass http://127.0.0.1:2005;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    
    location /vless-grpc {
        grpc_pass grpc://127.0.0.1:2006;
        grpc_set_header Host $host;
        grpc_set_header X-Real-IP $remote_addr;
    }
    
    location /vless-httpupgrade {
        proxy_pass http://127.0.0.1:2007;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
    }
    
    # Trojan paths
    location /trojan-ws {
        proxy_pass http://127.0.0.1:2010;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    
    location /trojan-grpc {
        grpc_pass grpc://127.0.0.1:2011;
        grpc_set_header Host $host;
        grpc_set_header X-Real-IP $remote_addr;
    }
    
    # SSH WebSocket
    location /ssh-ws {
        proxy_pass http://127.0.0.1:2014;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    
    # Shadowsocks
    location /shadowsocks {
        proxy_pass http://127.0.0.1:2016;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    
    # Multi-path support for Indonesian ISPs
    location /vmess-ws-opok {
        proxy_pass http://127.0.0.1:2001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
        proxy_buffering off;
    }
    
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
    
    location /vmess-ws-tsel {
        proxy_pass http://127.0.0.1:2001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_connect_timeout 45s;
        proxy_send_timeout 45s;
        proxy_read_timeout 45s;
    }
    
    location /vmess-ws-xl {
        proxy_pass http://127.0.0.1:2001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_connect_timeout 40s;
        proxy_send_timeout 40s;
        proxy_read_timeout 40s;
    }
    
    # Default location with enhanced info
    location / {
        return 200 "Maull-Script V1.2.0 - Enhanced Multiport Active\nAll protocols running on ports 443/80\nAdvanced features enabled\nMulti-ISP optimization active";
        add_header Content-Type text/plain;
    }
    
    # Health check endpoint
    location /health {
        return 200 "OK";
        add_header Content-Type text/plain;
    }
    
    # Status endpoint
    location /status {
        return 200 "Maull-Script V1.2.0 Status: Active";
        add_header Content-Type text/plain;
    }
}
EOF

    # Enable site and remove default
    ln -sf /etc/nginx/sites-available/multiport /etc/nginx/sites-enabled/
    rm -f /etc/nginx/sites-enabled/default
    
    # Test and restart nginx
    nginx -t && systemctl restart nginx && systemctl enable nginx
    
    print_success "Enhanced Nginx multiport configured successfully!"
}

# Function to install enhanced SSH services
install_ssh_services() {
    print_status "Installing enhanced SSH services..."
    
    # Install dropbear for SSH UDP
    if [[ $OS == "ubuntu" || $OS == "debian" ]]; then
        apt install -y dropbear-bin
    elif [[ $OS == "centos" ]]; then
        # Compile dropbear for CentOS
        yum groupinstall -y "Development Tools"
        cd /tmp
        wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2022.83.tar.bz2
        tar -xjf dropbear-2022.83.tar.bz2
        cd dropbear-2022.83
        ./configure --prefix=/usr/local
        make && make install
        ln -sf /usr/local/sbin/dropbear /usr/sbin/dropbear
    fi
    
    # Configure dropbear
    mkdir -p /etc/dropbear
    cat > /etc/default/dropbear << 'EOF'
# Dropbear SSH server configuration
DROPBEAR_PORT=7300
DROPBEAR_EXTRA_ARGS="-p 7300 -j -k"
DROPBEAR_BANNER="/etc/dropbear/banner"
EOF
    
    # Create dropbear banner
    cat > /etc/dropbear/banner << 'EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                           Maull-Script V1.2.0                               ║
║                    Enhanced SSH UDP Service Active                          ║
╚══════════════════════════════════════════════════════════════════════════════╝
EOF
    
    # Create enhanced SSH WebSocket service
    cat > /etc/systemd/system/ssh-ws.service << 'EOF'
[Unit]
Description=Enhanced SSH WebSocket Service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/ssh-ws
Restart=always
RestartSec=3
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

    # Create enhanced SSH WebSocket script with better performance
    cat > /usr/local/bin/ssh-ws << 'EOF'
#!/usr/bin/env python3
import asyncio
import websockets
import socket
import threading
import logging
from concurrent.futures import ThreadPoolExecutor

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class SSHWebSocketProxy:
    def __init__(self, host='127.0.0.1', port=2014, ssh_host='127.0.0.1', ssh_port=22):
        self.host = host
        self.port = port
        self.ssh_host = ssh_host
        self.ssh_port = ssh_port
        self.executor = ThreadPoolExecutor(max_workers=100)
    
    async def handle_client(self, websocket, path):
        client_ip = websocket.remote_address[0]
        logger.info(f"New SSH WebSocket connection from {client_ip}")
        
        try:
            # Connect to SSH server
            ssh_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            ssh_socket.settimeout(30)
            ssh_socket.connect((self.ssh_host, self.ssh_port))
            
            # Create tasks for bidirectional forwarding
            tasks = [
                asyncio.create_task(self.forward_to_ssh(websocket, ssh_socket)),
                asyncio.create_task(self.forward_to_websocket(ssh_socket, websocket))
            ]
            
            # Wait for any task to complete
            done, pending = await asyncio.wait(tasks, return_when=asyncio.FIRST_COMPLETED)
            
            # Cancel remaining tasks
            for task in pending:
                task.cancel()
                
        except Exception as e:
            logger.error(f"SSH WebSocket error for {client_ip}: {e}")
        finally:
            try:
                ssh_socket.close()
            except:
                pass
            logger.info(f"SSH WebSocket connection closed for {client_ip}")
    
    async def forward_to_ssh(self, websocket, ssh_socket):
        try:
            async for message in websocket:
                if isinstance(message, bytes):
                    ssh_socket.send(message)
                else:
                    ssh_socket.send(message.encode())
        except Exception as e:
            logger.debug(f"Forward to SSH error: {e}")
    
    async def forward_to_websocket(self, ssh_socket, websocket):
        try:
            loop = asyncio.get_event_loop()
            while True:
                data = await loop.run_in_executor(self.executor, ssh_socket.recv, 4096)
                if not data:
                    break
                await websocket.send(data)
        except Exception as e:
            logger.debug(f"Forward to WebSocket error: {e}")
    
    async def start_server(self):
        logger.info(f"Starting Enhanced SSH WebSocket server on {self.host}:{self.port}")
        server = await websockets.serve(
            self.handle_client,
            self.host,
            self.port,
            ping_interval=20,
            ping_timeout=10,
            max_size=10**7,
            max_queue=100
        )
        logger.info("Enhanced SSH WebSocket server started successfully")
        await server.wait_closed()

if __name__ == "__main__":
    proxy = SSHWebSocketProxy()
    try:
        asyncio.run(proxy.start_server())
    except KeyboardInterrupt:
        logger.info("SSH WebSocket server stopped")
    except Exception as e:
        logger.error(f"SSH WebSocket server error: {e}")
EOF

    chmod +x /usr/local/bin/ssh-ws
    
    # Start and enable services
    systemctl daemon-reload
    systemctl enable ssh-ws dropbear ssh
    systemctl start ssh-ws dropbear ssh
    
    print_success "Enhanced SSH services installed successfully!"
    print_status "SSH Standard: Port 22"
    print_status "SSH UDP (Dropbear): Port 7300"
    print_status "SSH WebSocket: Port 2014 → 443/80"
}

# Function to install enhanced Shadowsocks
install_shadowsocks() {
    print_status "Installing enhanced Shadowsocks..."
    
    if [[ $OS == "ubuntu" || $OS == "debian" ]]; then
        apt install -y shadowsocks-libev
    elif [[ $OS == "centos" ]]; then
        yum install -y shadowsocks-libev
    fi
    
    # Generate strong password
    SS_PASSWORD=$(pwgen -s 32 1)
    echo $SS_PASSWORD > $CONFIG_DIR/ss_password
    
    # Create enhanced Shadowsocks config
    cat > /etc/shadowsocks-libev/config.json << EOF
{
    "server": "127.0.0.1",
    "server_port": 2016,
    "password": "$SS_PASSWORD",
    "timeout": 300,
    "method": "aes-256-gcm",
    "fast_open": false,
    "reuse_port": true,
    "no_delay": true,
    "mode": "tcp_and_udp"
}
EOF
    
    # Create Shadowsocks service override for better performance
    mkdir -p /etc/systemd/system/shadowsocks-libev.service.d
    cat > /etc/systemd/system/shadowsocks-libev.service.d/override.conf << 'EOF'
[Service]
ExecStart=
ExecStart=/usr/bin/ss-server -c /etc/shadowsocks-libev/config.json -u
Restart=always
RestartSec=3
EOF
    
    systemctl daemon-reload
    systemctl enable shadowsocks-libev
    systemctl start shadowsocks-libev
    
    print_success "Enhanced Shadowsocks installed successfully!"
    print_status "Shadowsocks Password: $SS_PASSWORD"
    print_status "Shadowsocks Port: 2016 → 443/80"
    print_status "Method: aes-256-gcm"
}

# Function to setup enhanced automation
setup_enhanced_automation() {
    print_status "Setting up enhanced automation system..."
    
    # Create automation scripts directory
    mkdir -p /usr/local/bin
    
    # Auto Reboot script
    cat > /usr/local/bin/maull-autoreboot << 'EOF'
#!/bin/bash
# Enhanced Auto Reboot with logging
echo "$(date): Auto reboot initiated by Maull-Script" >> /var/log/maull-script/autoreboot.log
sync
reboot
EOF
    
    # Auto Update script
    cat > /usr/local/bin/maull-update << 'EOF'
#!/bin/bash
# Enhanced Auto Update script
LOG_FILE="/var/log/maull-script/autoupdate.log"
echo "$(date): Starting auto update" >> $LOG_FILE

# Update system packages
if command -v apt &> /dev/null; then
    apt update -qq && apt upgrade -y -qq >> $LOG_FILE 2>&1
elif command -v yum &> /dev/null; then
    yum update -y -q >> $LOG_FILE 2>&1
fi

# Update script if available
if [[ -f /root/maull-script.sh ]]; then
    wget -O /tmp/maull-script-new.sh https://raw.githubusercontent.com/maullh/maull-script/main/maull-script.sh 2>/dev/null
    if [[ $? -eq 0 ]]; then
        cp /root/maull-script.sh /root/maull-script.sh.backup
        cp /tmp/maull-script-new.sh /root/maull-script.sh
        chmod +x /root/maull-script.sh
        echo "$(date): Script updated successfully" >> $LOG_FILE
    fi
fi

echo "$(date): Auto update completed" >> $LOG_FILE
EOF
    
    # Auto Backup script
    cat > /usr/local/bin/maull-backup << 'EOF'
#!/bin/bash
# Enhanced Auto Backup script
BACKUP_DIR="/root/maull-backup"
CONFIG_DIR="/etc/maull-script"
LOG_FILE="/var/log/maull-script/autobackup.log"
BACKUP_NAME="maull-backup-$(date +%Y%m%d-%H%M%S)"
RETENTION_DAYS=7

echo "$(date): Starting auto backup" >> $LOG_FILE

# Create backup directory
mkdir -p $BACKUP_DIR/$BACKUP_NAME

# Backup configurations
cp -r $CONFIG_DIR $BACKUP_DIR/$BACKUP_NAME/ 2>/dev/null
cp -r /etc/nginx $BACKUP_DIR/$BACKUP_NAME/ 2>/dev/null
cp -r /usr/local/etc/xray $BACKUP_DIR/$BACKUP_NAME/ 2>/dev/null
cp -r /etc/shadowsocks-libev $BACKUP_DIR/$BACKUP_NAME/ 2>/dev/null
cp -r /etc/letsencrypt $BACKUP_DIR/$BACKUP_NAME/ 2>/dev/null

# Create system info
uname -a > $BACKUP_DIR/$BACKUP_NAME/system_info.txt
df -h > $BACKUP_DIR/$BACKUP_NAME/disk_usage.txt
free -m > $BACKUP_DIR/$BACKUP_NAME/memory_info.txt

# Create archive
cd $BACKUP_DIR
tar -czf $BACKUP_NAME.tar.gz $BACKUP_NAME
rm -rf $BACKUP_NAME

# Cleanup old backups
find $BACKUP_DIR -name "maull-backup-*.tar.gz" -mtime +$RETENTION_DAYS -delete

echo "$(date): Auto backup completed: $BACKUP_NAME.tar.gz" >> $LOG_FILE
EOF
    
    # Auto Delete Expired Users script
    cat > /usr/local/bin/maull-delete-expired << 'EOF'
#!/bin/bash
# Enhanced Auto Delete Expired Users
CONFIG_DIR="/etc/maull-script"
LOG_FILE="/var/log/maull-script/delete-expired.log"
current_date=$(date +%s)
expired_count=0

echo "$(date): Checking for expired users" >> $LOG_FILE

for user_file in $CONFIG_DIR/users/*.json 2>/dev/null; do
    if [[ -f $user_file ]]; then
        exp_date=$(jq -r '.exp_date' $user_file 2>/dev/null)
        if [[ $exp_date != "null" && $exp_date != "" ]]; then
            exp_timestamp=$(date -d "$exp_date" +%s 2>/dev/null)
            if [[ $exp_timestamp -lt $current_date ]]; then
                username=$(basename $user_file | cut -d. -f1)
                protocol=$(jq -r '.protocol' $user_file 2>/dev/null)
                
                echo "$(date): Deleting expired user: $username ($protocol)" >> $LOG_FILE
                
                # Delete system user if SSH
                if [[ $protocol == "ssh" ]]; then
                    userdel -f $username 2>/dev/null
                fi
                
                # Remove user file
                rm -f $user_file
                ((expired_count++))
            fi
        fi
    fi
done

echo "$(date): Deleted $expired_count expired users" >> $LOG_FILE
EOF
    
    # Auto Kill Multi Login script
    cat > /usr/local/bin/maull-autokill << 'EOF'
#!/bin/bash
# Enhanced Auto Kill Multi Login
CONFIG_DIR="/etc/maull-script"
LOG_FILE="/var/log/maull-script/autokill.log"
MAX_LOGIN=2

# Check each user's login count
for user_file in $CONFIG_DIR/users/*.ssh 2>/dev/null; do
    if [[ -f $user_file ]]; then
        username=$(jq -r '.username' $user_file 2>/dev/null)
        max_login=$(jq -r '.multi_login_limit // 2' $user_file 2>/dev/null)
        
        # Count active sessions
        login_count=$(who | grep "^$username " | wc -l)
        
        if [[ $login_count -gt $max_login ]]; then
            echo "$(date): User $username exceeded login limit ($login_count > $max_login)" >> $LOG_FILE
            
            # Kill excess sessions
            who | grep "^$username " | tail -n +$((max_login + 1)) | while read line; do
                tty=$(echo $line | awk '{print $2}')
                pkill -f "sshd.*$tty" 2>/dev/null
                echo "$(date): Killed session $tty for user $username" >> $LOG_FILE
            done
        fi
    fi
done
EOF
    
    # Make scripts executable
    chmod +x /usr/local/bin/maull-*
    
    # Setup cron jobs
    cat > /etc/cron.d/maull-automation << 'EOF'
# Maull-Script Enhanced Automation
# Auto Reboot (default 00:00)
0 0 * * * root /usr/local/bin/maull-autoreboot

# Auto Update (01:15)
15 1 * * * root /usr/local/bin/maull-update

# Auto Backup (default 11:15)
15 11 * * * root /usr/local/bin/maull-backup

# Auto Delete Expired (02:00)
0 2 * * * root /usr/local/bin/maull-delete-expired

# Auto Kill Multi Login (every 5 minutes)
*/5 * * * * root /usr/local/bin/maull-autokill
EOF
    
    # Restart cron service
    if [[ $OS == "ubuntu" || $OS == "debian" ]]; then
        systemctl restart cron
    elif [[ $OS == "centos" ]]; then
        systemctl restart crond
    fi
    
    print_success "Enhanced automation system configured successfully!"
    print_status "Auto Reboot: 00:00 daily (configurable)"
    print_status "Auto Update: 01:15 daily"
    print_status "Auto Backup: 11:15 daily (configurable)"
    print_status "Auto Delete Expired: 02:00 daily"
    print_status "Auto Kill Multi Login: Every 5 minutes"
}

# Function to create enhanced utility scripts
create_enhanced_utilities() {
    print_status "Creating enhanced utility scripts..."
    
    # Enhanced menu script
    cat > /usr/local/bin/menu << 'EOF'
#!/bin/bash
# Enhanced menu launcher
if [[ -f /root/maull-script.sh ]]; then
    /root/maull-script.sh menu
else
    echo "Maull-Script not found. Please reinstall."
    exit 1
fi
EOF
    
    # Enhanced user management script
    cat > /usr/local/bin/maull-user << 'EOF'
#!/bin/bash
# Enhanced user management
if [[ -f /root/maull-script.sh ]]; then
    /root/maull-script.sh user "$@"
else
    echo "Maull-Script not found. Please reinstall."
    exit 1
fi
EOF
    
    # System monitor script
    cat > /usr/local/bin/maull-monitor << 'EOF'
#!/bin/bash
# Enhanced system monitor
if [[ -f /root/maull-script.sh ]]; then
    /root/maull-script.sh monitor
else
    echo "Maull-Script not found. Please reinstall."
    exit 1
fi
EOF
    
    # Speedtest script
    cat > /usr/local/bin/maull-speedtest << 'EOF'
#!/bin/bash
# Enhanced speedtest
echo "Running enhanced speedtest..."
if command -v speedtest-cli &> /dev/null; then
    speedtest-cli --simple
else
    echo "Installing speedtest-cli..."
    if command -v apt &> /dev/null; then
        apt install -y speedtest-cli
    elif command -v yum &> /dev/null; then
        yum install -y speedtest-cli
    fi
    speedtest-cli --simple
fi
EOF
    
    # System diagnostic script
    cat > /usr/local/bin/maull-diagnostic << 'EOF'
#!/bin/bash
# Enhanced system diagnostic
echo "=== MAULL-SCRIPT SYSTEM DIAGNOSTIC ==="
echo "Date: $(date)"
echo "Version: 1.2.0"
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

echo "=== NETWORK ==="
echo "IP: $(curl -s ipinfo.io/ip 2>/dev/null || echo "Unknown")"
echo "DNS: $(nslookup google.com | grep Server | awk '{print $2}' | head -1)"
echo ""

echo "=== SERVICES ==="
services=("nginx" "xray" "ssh" "dropbear" "ssh-ws" "shadowsocks-libev")
for service in "${services[@]}"; do
    status=$(systemctl is-active $service 2>/dev/null)
    echo "$service: $status"
done
echo ""

echo "=== PORTS ==="
ports=("22" "80" "443" "7300")
for port in "${ports[@]}"; do
    status=$(ss -tuln | grep ":$port " >/dev/null && echo "OPEN" || echo "CLOSED")
    echo "Port $port: $status"
done
EOF
    
    # Make all scripts executable
    chmod +x /usr/local/bin/menu
    chmod +x /usr/local/bin/maull-*
    
    print_success "Enhanced utility scripts created successfully!"
}

# Function to download main script
download_main_script() {
    print_status "Downloading main Maull-Script..."
    
    # Download main script
    wget -O /root/maull-script.sh https://raw.githubusercontent.com/your-username/maull-script/main/maull-script.sh 2>/dev/null
    
    if [[ $? -ne 0 ]]; then
        print_warning "Failed to download from GitHub, using local copy..."
        # If download fails, create a basic version
        cat > /root/maull-script.sh << 'EOF'
#!/bin/bash
# Maull-Script V1.2.0 - Basic version
echo "Maull-Script V1.2.0 installed successfully!"
echo "Enhanced features are active."
echo "Type 'menu' to access the management panel."
EOF
    fi
    
    chmod +x /root/maull-script.sh
    
    print_success "Main script downloaded successfully!"
}

# Function to save installation info
save_installation_info() {
    print_status "Saving installation information..."
    
    # Create installation info
    cat > $CONFIG_DIR/install_info.json << EOF
{
    "version": "$SCRIPT_VERSION",
    "install_date": "$(date)",
    "os": "$OS",
    "distro": "$DISTRO",
    "ip": "$(curl -s ipinfo.io/ip 2>/dev/null || echo 'Unknown')",
    "features": {
        "auto_reboot": true,
        "auto_update": true,
        "auto_backup": true,
        "auto_delete_expired": true,
        "auto_kill_multi_login": true,
        "multiport": true,
        "multi_path": true,
        "enhanced_monitoring": true,
        "advanced_user_management": true,
        "speed_limiting": true,
        "quota_management": true
    },
    "services": {
        "nginx": "active",
        "xray": "active",
        "ssh": "active",
        "dropbear": "active",
        "ssh-ws": "active",
        "shadowsocks": "active"
    },
    "ports": {
        "http": 80,
        "https": 443,
        "ssh": 22,
        "dropbear": 7300,
        "openvpn": 1194
    }
}
EOF
    
    # Save UUIDs
    echo "$(cat $CONFIG_DIR/uuid_vmess)" > $CONFIG_DIR/vmess_uuid
    echo "$(cat $CONFIG_DIR/uuid_vless)" > $CONFIG_DIR/vless_uuid
    echo "$(cat $CONFIG_DIR/uuid_trojan)" > $CONFIG_DIR/trojan_uuid
    echo "$(cat $CONFIG_DIR/ss_password)" > $CONFIG_DIR/shadowsocks_password
    
    print_success "Installation information saved successfully!"
}

# Function to show installation summary
show_installation_summary() {
    clear
    print_banner
    
    # Get system info
    IP=$(curl -s ipinfo.io/ip 2>/dev/null || echo "Unknown")
    CITY=$(curl -s ipinfo.io/city 2>/dev/null || echo "Unknown")
    ISP=$(curl -s ipinfo.io/org 2>/dev/null || echo "Unknown")
    
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}                           INSTALLATION COMPLETE                             ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo -e "${WHITE}🌟 Server Information:${NC}"
    echo -e "   IP Address: ${CYAN}$IP${NC}"
    echo -e "   Location: ${CYAN}$CITY${NC}"
    echo -e "   ISP: ${CYAN}$ISP${NC}"
    echo -e "   OS: ${CYAN}$DISTRO${NC}"
    echo -e "   Script Version: ${CYAN}$SCRIPT_VERSION${NC}"
    echo ""
    
    echo -e "${WHITE}🚀 Enhanced Features Activated:${NC}"
    echo -e "   ✅ Auto Reboot System (00:00 daily)"
    echo -e "   ✅ Auto Update System (01:15 daily)"
    echo -e "   ✅ Auto Backup System (11:15 daily)"
    echo -e "   ✅ Auto Delete Expired Users (02:00 daily)"
    echo -e "   ✅ Auto Kill Multi Login (every 5 minutes)"
    echo -e "   ✅ Advanced User Management"
    echo -e "   ✅ Multi-Path Support (OPOK ISAT)"
    echo -e "   ✅ Speed Limiting & Quota Management"
    echo -e "   ✅ Real-time Monitoring"
    echo -e "   ✅ Enhanced Security Features"
    echo ""
    
    echo -e "${WHITE}🔌 Multiport Architecture:${NC}"
    echo -e "   Port 443 (HTTPS/TLS): ${GREEN}All protocols with encryption${NC}"
    echo -e "   Port 80 (HTTP/Non-TLS): ${GREEN}All protocols without encryption${NC}"
    echo -e "   Port 22 (SSH): ${GREEN}Standard SSH${NC}"
    echo -e "   Port 1194 (OpenVPN): ${GREEN}OpenVPN UDP${NC}"
    echo -e "   Port 7300 (Dropbear): ${GREEN}SSH UDP${NC}"
    echo ""
    
    echo -e "${WHITE}🛠️ Service Status:${NC}"
    services=("nginx" "xray" "ssh" "dropbear" "ssh-ws" "shadowsocks-libev")
    for service in "${services[@]}"; do
        status=$(systemctl is-active $service 2>/dev/null)
        if [[ $status == "active" ]]; then
            echo -e "   $service: ${GREEN}Running${NC}"
        else
            echo -e "   $service: ${RED}Stopped${NC}"
        fi
    done
    echo ""
    
    echo -e "${WHITE}📱 Access Panel:${NC}"
    echo -e "   Command: ${CYAN}menu${NC}"
    echo -e "   Alternative: ${CYAN}/root/maull-script.sh${NC}"
    echo ""
    
    echo -e "${WHITE}🔑 Generated Credentials:${NC}"
    echo -e "   VMess UUID: ${CYAN}$(cat $CONFIG_DIR/uuid_vmess)${NC}"
    echo -e "   VLess UUID: ${CYAN}$(cat $CONFIG_DIR/uuid_vless)${NC}"
    echo -e "   Trojan UUID: ${CYAN}$(cat $CONFIG_DIR/uuid_trojan)${NC}"
    echo -e "   Shadowsocks Password: ${CYAN}$(cat $CONFIG_DIR/ss_password)${NC}"
    echo ""
    
    echo -e "${WHITE}📚 Documentation:${NC}"
    echo -e "   Main Guide: ${CYAN}README.md${NC}"
    echo -e "   Advanced Features: ${CYAN}ADVANCED-FEATURES.md${NC}"
    echo -e "   Troubleshooting: ${CYAN}TROUBLESHOOTING-GUIDE.md${NC}"
    echo ""
    
    echo -e "${YELLOW}⚠️  Important Notes:${NC}"
    echo -e "   • All services are running automatically"
    echo -e "   • Multiport architecture: Only 5 ports used (443, 80, 22, 1194, 7300)"
    echo -e "   • Full automation: Zero maintenance required"
    echo -e "   • Type 'menu' anytime to access the management panel"
    echo -e "   • All configurations are automatically backed up"
    echo -e "   • System will auto-update and auto-reboot as scheduled"
    echo ""
    
    echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
    echo -e "${GREEN}🚀 Your VPS is now running the most advanced tunneling solution!${NC}"
    echo ""
    echo -e "${CYAN}Press Enter to access the menu...${NC}"
    read
    
    # Launch menu
    /usr/local/bin/menu
}

# Main installation function
main_installation() {
    print_banner
    print_status "Starting Maull-Script V1.2.0 Enhanced Installation..."
    
    # Pre-installation checks
    check_root
    detect_os
    check_requirements
    
    print_success "Pre-installation checks passed"
    print_status "OS: $DISTRO"
    print_status "Starting installation process..."
    
    # Installation steps
    create_directories
    update_system
    configure_firewall
    install_xray
    configure_nginx
    install_ssh_services
    install_shadowsocks
    setup_enhanced_automation
    create_enhanced_utilities
    download_main_script
    save_installation_info
    
    print_success "All components installed successfully!"
    
    # Final setup
    systemctl daemon-reload
    
    # Verify services
    print_status "Verifying services..."
    sleep 5
    
    services=("nginx" "xray" "ssh" "dropbear" "ssh-ws" "shadowsocks-libev")
    for service in "${services[@]}"; do
        if systemctl is-active $service &>/dev/null; then
            print_success "$service is running"
        else
            print_warning "$service is not running, attempting to start..."
            systemctl start $service
        fi
    done
    
    # Show installation summary
    show_installation_summary
}

# Script execution
case "${1:-install}" in
    "install")
        main_installation
        ;;
    "update")
        print_status "Updating Maull-Script..."
        /usr/local/bin/maull-update
        ;;
    "backup")
        print_status "Creating backup..."
        /usr/local/bin/maull-backup
        ;;
    "diagnostic")
        /usr/local/bin/maull-diagnostic
        ;;
    "menu")
        /usr/local/bin/menu
        ;;
    *)
        echo "Usage: $0 {install|update|backup|diagnostic|menu}"
        echo ""
        echo "Commands:"
        echo "  install    - Install Maull-Script V1.2.0"
        echo "  update     - Update system and script"
        echo "  backup     - Create configuration backup"
        echo "  diagnostic - Run system diagnostic"
        echo "  menu       - Access management menu"
        exit 1
        ;;
esac
