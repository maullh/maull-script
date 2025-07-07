# Cara Melihat Preview.html - Maull-Script V1.2.0

## 🌐 Metode 1: Langsung di Browser (Paling Mudah)

### **Download File dan Buka di Browser**
```bash
# Download file preview.html
wget https://raw.githubusercontent.com/your-username/maull-script/main/preview.html

# Atau copy paste content ke file lokal
nano preview.html
# Paste content dari preview.html

# Buka di browser
# Windows: double-click file preview.html
# Linux: firefox preview.html atau google-chrome preview.html
# Mac: open preview.html
```

## 🖥️ Metode 2: Local Web Server

### **Menggunakan Node.js (Recommended - Lebih Stabil)**
```bash
# Menggunakan npm script (Node.js built-in server)
npm run preview

# Akses di browser: http://localhost:8080/preview.html
```

### **Menggunakan Python (Jika sudah diperbaiki)**
```bash
# Perbaiki Python installation terlebih dahulu jika ada error
sudo apt-get update && sudo apt-get install --reinstall python3 python3-dev

# Kemudian jalankan server
npm run preview-python

# Atau manual:
python3 -m http.server 8080

# Akses di browser: http://localhost:8080/preview.html
```

### **Menggunakan Node.js Manual**
```bash
# Install http-server global
npm install -g http-server

# Jalankan server
http-server -p 8080

# Akses di browser: http://localhost:8080/preview.html
```

### **Menggunakan PHP**
```bash
# Jika PHP terinstall
php -S localhost:8080

# Akses di browser: http://localhost:8080/preview.html
```

## 🚀 Metode 3: Menggunakan NPM Script (Jika sudah clone repo)

```bash
# Clone repository
git clone https://github.com/your-username/maull-script.git
cd maull-script

# Jalankan preview (menggunakan Node.js - lebih reliable)
npm run preview

# Atau jika ingin menggunakan Python (setelah diperbaiki)
npm run preview-python

# Akses di browser: http://localhost:8080/preview.html
```

## 🌍 Metode 4: Online Preview

### **GitHub Pages (Jika repo public)**
```
https://your-username.github.io/maull-script/preview.html
```

### **Raw GitHub Content**
```
https://raw.githubusercontent.com/your-username/maull-script/main/preview.html
```

### **Online HTML Viewers**
1. Buka https://htmlpreview.github.io/
2. Paste URL: https://raw.githubusercontent.com/your-username/maull-script/main/preview.html
3. Klik "Preview"

## 📱 Metode 5: Mobile/Tablet

### **Menggunakan Code Editor Apps**
- **Android**: Acode, QuickEdit, DroidEdit
- **iOS**: Textastic, Buffer Editor

### **Steps:**
1. Download file preview.html ke device
2. Buka dengan code editor app
3. Pilih "Preview in Browser" atau "Run"

## 🔧 Troubleshooting

### **Python Socket Error (ModuleNotFoundError: No module named '_socket')**
```bash
# Perbaiki Python installation
sudo apt-get update && sudo apt-get install --reinstall python3 python3-dev

# Untuk CentOS/RHEL
sudo yum reinstall python3 python3-devel

# Atau gunakan Node.js sebagai alternatif
npm run preview
```

### **File Tidak Muncul dengan Benar**
```bash
# Pastikan file complete dan valid
head -20 preview.html
tail -20 preview.html

# Check file size
ls -lh preview.html
```

### **CSS/JS Tidak Load**
- Pastikan koneksi internet aktif (untuk CDN)
- Buka Developer Tools (F12) untuk check errors
- Refresh browser (Ctrl+F5)

### **Port Sudah Digunakan**
```bash
# Cek port yang digunakan
netstat -tulpn | grep :8080

# Gunakan port lain
python3 -m http.server 8081
# Atau untuk Node.js, edit port di package.json
```

## 🎯 Quick Start (Termudah)

### **Method 1: Node.js Server (Paling Reliable)**
```bash
# Langsung jalankan dengan Node.js
npm run preview

# Akses: http://localhost:8080
```

### **Method 2: Copy-Paste Method**
1. Buka file `preview.html` di editor
2. Copy semua content (Ctrl+A, Ctrl+C)
3. Buka text editor (Notepad, VS Code, dll)
4. Paste content (Ctrl+V)
5. Save as `preview.html`
6. Double-click file untuk buka di browser

### **Method 3: One-liner Download & View**
```bash
# Linux/Mac (menggunakan Node.js)
wget -O preview.html https://raw.githubusercontent.com/your-username/maull-script/main/preview.html && npm run preview

# Windows (PowerShell)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/your-username/maull-script/main/preview.html" -OutFile "preview.html"; npm run preview
```

## 📋 Apa yang Akan Anda Lihat

Preview akan menampilkan:
- 🎛️ **Dashboard Interface** - Modern admin panel
- 📊 **System Monitoring** - Real-time stats simulation
- 👥 **User Management** - Account management interface
- 🔧 **System Tools** - Service management tools
- 📈 **Analytics** - Bandwidth dan performance charts
- ⚙️ **Settings** - Configuration panels
- 🎨 **Responsive Design** - Mobile-friendly interface

## 🌟 Features Preview

- **Interactive Elements** - Buttons, tabs, modals
- **Animated Charts** - Real-time data visualization
- **Modern UI** - Clean, professional design
- **Dark/Light Theme** - Theme switching
- **Mobile Responsive** - Works on all devices
- **Loading Animations** - Smooth transitions
- **Status Indicators** - Service status lights
- **Progress Bars** - Installation progress

## 💡 Tips

1. **Best Experience**: Gunakan Chrome/Firefox terbaru
2. **Full Screen**: Press F11 untuk full screen experience
3. **Developer Mode**: Press F12 untuk inspect elements
4. **Mobile View**: Use browser dev tools untuk mobile simulation
5. **Performance**: Disable ad-blockers jika ada masalah loading
6. **Reliability**: Gunakan `npm run preview` (Node.js) untuk server yang lebih stabil

## ⚠️ Known Issues & Solutions

### **Python Socket Module Missing**
- **Problem**: `ModuleNotFoundError: No module named '_socket'`
- **Solution**: Reinstall Python dengan `sudo apt-get install --reinstall python3 python3-dev`
- **Alternative**: Gunakan Node.js server dengan `npm run preview`

### **Permission Denied**
- **Problem**: Cannot bind to port 8080
- **Solution**: Gunakan port lain atau jalankan dengan sudo (tidak recommended)
- **Better**: Gunakan port > 1024 seperti 8081, 8082, dll

---

**Selamat menikmati preview interface Maull-Script V1.2.0!** 🚀

Interface ini memberikan gambaran lengkap tentang tampilan dan fitur-fitur yang akan Anda dapatkan setelah menginstall script di VPS.

**Rekomendasi**: Gunakan `npm run preview` untuk pengalaman terbaik dan menghindari masalah Python socket module.