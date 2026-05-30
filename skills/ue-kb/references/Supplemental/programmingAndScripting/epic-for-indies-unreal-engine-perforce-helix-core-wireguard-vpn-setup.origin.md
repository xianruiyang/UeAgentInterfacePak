# 虚幻引擎 + Perforce (Helix Core) + WireGuard VPN 设置

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/5XXO/epic-for-indies-unreal-engine-perforce-helix-core-wireguard-vpn-setup

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 5297 字符。

## 摘要

使用 Ubuntu/Debian 服务器和 Windows 客户端通过 WireGuard VPN 设置虚幻引擎与 Perforce (Helix Core) 协作的指南。

## 中文整理

### 🎮 Unreal Engine + Perforce (Helix Core) + WireGuard VPN 设置

**使用 Ubuntu/Debian 服务器和 Windows 客户端通过 WireGuard VPN 设置虚幻引擎与 Perforce (Helix Core) 协作的指南。** 使用以下工具为虚幻引擎开发设置安全协作工作流程的完整指南： 1. ✅ Ubuntu/Debian 服务器 (Perforce + WireGuard) 2. ✅ Windows 客户端 (Unreal Engine + P4V) 3. ✅ 通过 WireGuard VPN 实现类似 LAN 的安全连接

### 🔒 安全和许可通知

1. 确保保护您的服务器： - 使用强 SSH 密码或密钥身份验证 - 仅公开必要的端口（例如 VPN 和 Perforce） - 通过防火墙限制对 VPN IP 的访问 2. 定期更新您的系统和软件包以避免漏洞。 3. ✅ Perforce（Helix Core 服务器）请查看 Perforce 许可条款。 🚨 始终遵循保护基础设施的最佳实践，尤其是远程托管时。

### ⚙️ 1. 设置 WireGuard VPN

### 🖥️ 在 Ubuntu/Debian 服务器上

```
sudo apt update
sudo apt install wireguard
wg genkey | tee privatekey | wg pubkey > publickey
```

创建/etc/wireguard/wg0.conf：

```
[Interface]
Address = 10.66.66.1/24
PrivateKey = <server-private-key>
ListenPort = 51820
SaveConfig = true
```

启用IP转发：

```
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

启动VPN：

```
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

### 💻 在 Windows 客户端上

安装 [WireGuard for Windows](https://www.wireguard.com/install/) 并使用：

```
[Interface]
PrivateKey = <client-private-key>
Address = 10.66.66.2/32

[Peer]
PublicKey = <server-public-key>
Endpoint = your.server.ip:51820
AllowedIPs = 10.66.66.0/24
PersistentKeepalive = 25
```

✅ 测试：ping 10.66.66.1

### 📦 2.安装Perforce（Helix Core服务器）

### 在 Ubuntu/Debian 服务器上

```
wget -qO - https://package.perforce.com/perforce.pubkey | sudo apt-key add -
echo "deb http://package.perforce.com/apt/ubuntu jammy release" | sudo tee /etc/apt/sources.list.d/perforce.list
sudo apt update
sudo apt install -y helix-p4d
```

创建所需目录：

```
sudo mkdir -p /opt/perforce/metadata /opt/perforce/depot
sudo useradd -r -s /bin/false perforce || true
sudo chown -R perforce: /opt/perforce
```

初始化数据库：

```
sudo -u perforce /usr/sbin/p4d -r /opt/perforce/metadata -J journal -xi
```

创建系统服务：

```
# /etc/systemd/system/perforce.service

[Unit]
Description=Helix Core Perforce Server
After=network.target

[Service]
User=perforce
ExecStart=/usr/sbin/p4d -r /opt/perforce/metadata -p 1666 -L /opt/perforce/metadata/log -J /opt/perforce/metadata/journal
Restart=always
```

启用并启动：

```
sudo systemctl daemon-reexec
sudo systemctl enable perforce
sudo systemctl start perforce
```

安装 CLI（可选）：

```
wget https://cdist2.perforce.com/perforce/r24.1/bin.linux26x86_64/p4
chmod +x p4
sudo mv p4 /usr/local/bin/
```

### 👤 3. 创建用户、仓库和工作空间

### 在 Ubuntu/Debian 服务器上

```
p4 -p 127.0.0.1:1666 user
p4 passwd
p4 depot UEProject
```

### 在 P4V (Windows) 中

1. 工作空间名称：client1_ue 2. 根目录：D:\UnrealProjects\MyGame 3. View://UEProject/... //client1_ue/...

### 🖥️ P4V：安装和使用 Perforce GUI

### 🧩P4V是什么？

**P4V** 是 Perforce 的官方图形客户端。它允许用户： 1. 创建和管理工作区 2. 查看变更列表和库结构 3. 添加、签出和提交文件 4. 可视化文件历史记录和差异

### 🛠️ 在 Windows 上安装 P4V

1. 从 Perforce 官方网站下载 P4V：👉[https://www.perforce.com/downloads/helix-visual-client-p4v](https://portal.perforce.com/s/downloads?product=Helix%20Visual%20Client%20%28P4V%29) 2. 安装并启动客户端。 3. 首次启动时，提供您的服务器信息： - 服务器 | 10.66.66.1:1666 - 用户名 |您的 Perforce 用户 - 工作区 | （最初留空）

### ⚠️已知问题：大型虚幻项目可能会导致冻结

在大型 Unreal 项目中使用 P4V 中的 **“添加文件向导”** 时： 1. P4V 可能会由于扫描数千个文件而冻结或崩溃（“无响应”） 2. 如果包含 Binaries/、Intermediate/ 或 Saved/ 等临时文件夹，则尤其常见

### ✅ 更安全的替代方案：使用 p4 CLI 进行初始添加

如果 P4V 无响应： 1. 打开终端（PowerShell 或 CMD） 2. 设置环境变量：

```
p4 set P4PORT=10.66.66.1:1666
p4 set P4USER=your_username
p4 set P4CLIENT=your_workspace
```

### 🧩 4.虚幻引擎集成

1. 打开工作空间根目录内的 .uproject 2. 转到文件 → 源代码管理 → 连接到源代码管理 3. 选择 Perforce 并填写： - 工作空间 | 项目client1_ue 1. 接受 → 出现绿色勾 ✅ 2. 添加文件： - ✅ .uproject、Config/、Content/、Source/ - ❌ 跳过：Binaries/、Intermediate/、Saved/ 3. 提交：

```
File → Submit to Source Control
```

### 📄推荐.p4ignore

放置在项目根目录中：

```
Binaries/
DerivedDataCache/
Intermediate/
Saved/
.vs/
.vscode/
*.sdf
*.suo
*.user
*.log
```

然后：

```
p4 add .p4ignore
p4 submit -d "Add ignore file"
```

### ✅ 你准备好了！

您现在拥有： 1. 🔒 VPN 访问 Perforce 2. 🛠️ 源代码控制的虚幻引擎项目 3. 📡 具有低延迟文件访问的远程协作

### 🔁 工作流程提示

- 查看文件 |右键单击→签出-添加文件|右键单击 → 添加到源代码管理 - 提交更改 |文件 → 提交到源代码管理 - 放弃更改 |右键单击→恢复-同步最新更改|文件 → Sync Made with ❤️ by Deblx，用于团队构建游戏。像这样？ ⭐ 星标并关注！
