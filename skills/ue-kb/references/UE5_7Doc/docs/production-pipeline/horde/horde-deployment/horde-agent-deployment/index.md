---
title: "Horde代理"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-agent-deployment-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde部署", "Horde代理"]
---

# Horde代理

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde部署 / Horde代理

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-agent-deployment-for-unreal-engine

## 安装

### MSI安装程序（Windows）

以这种方式安装代理还会同时安装一个后台应用程序，该应用程序会在Windows 通知区域显示代理状态。你还可以将代理配置为仅在计算机处于空闲状态时运行。

> [!NOTE]
> 以这种方式安装的代理必须手动升级到新版Horde。

### 从服务器下载

Horde服务器可用作Horde代理的下载源。以这种方式分发代理，将允许代理自动升级到服务器上新增的新版本。

要从浏览器安装，转到Horde操作面板，找到 `Server > Agents` 菜单项，然后点击 `Download Agent` 链接。

或者，你可以使用以下命令通过命令行下载代理。此处引用的`AUTH-TOKEN`参数可通过以下方式获得：让管理员用户登录到 `http://[HORDE-SERVER-URL]/account` 页面，然后点击 **获取代理软件下载令牌（Get agent software download token）** 链接。

#### Windows（PowerShell）

```
Invoke-WebRequest -Uri https://[HORDE-SERVER-URL]/api/v1/agentsoftware/default/zip -OutFile C:\Horde\HordeAgent.zip -Headers @{ 'Authorization' = 'Bearer [AUTH-TOKEN]' }Expand-Archive -LiteralPath C:\Horde\HordeAgent.zip -DestinationPath C:\Horde -Force
```

使用未验证身份的服务器时，不需要-Headers参数和值。

#### Mac & Linux

```
curl https://[HORDE-SERVER-URL]/api/v1/agentsoftware/default/zip --output ~/Horde/HordeAgent.zip -H "Authorization: Bearer [AUTH-TOKEN]"unzip -o ~/Horde/HordeAgent.zip -d ~/Horde/
```

使用未验证身份的服务器时，不需要-H参数和值。

## 设置

### 通用

代理设置通过[`Agent.json`](../horde-settings/index.md#%E4%BB%A3%E7%90%86%E8%AE%BE%E7%BD%AE)文件配置。在 Windows上，该文件存储在`C:\ProgramData\Epic\Horde\Agent\Agent.json` 中。在其他平台上，它默认存储在应用程序目录下的 `Data` 文件夹中。该文件中的设置会覆盖随代理可执行文件一同分发的 `appsettings.json` 文件。

所有与Horde相关的设置都存储在 `horde` 顶层键之下，而中间件和标准.NET设置则存储在其他根键之下。

### 服务器配置文件

代理的[`Agent.json`](../horde-settings/index.md#%E4%BB%A3%E7%90%86%E8%AE%BE%E7%BD%AE)文件可通过 `ServerProfiles` 属性包含连接多个Horde服务器的设置。当在多个环境（例如开发环境和生产环境）中运行Horde时，设置多个配置文件很有用，并且每个[服务器配置文件](../horde-settings/index.md#%E6%9C%8D%E5%8A%A1%E5%99%A8%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)都包含一个名称、服务器URL和身份验证令牌。

服务器配置文件通过名称引用。默认配置文件通过 `Server` 属性配置或者在启动代理时通过 `-Server=..` 命令行参数配置。

在编写代理部署脚本时，你可以修改服务器托管的构建，以默认包含所需的配置；也可以在下载配置文件后使用代理的 `SetServer` 命令修改配置文件。该命令可按以下方式调用：

```
dotnet HordeAgent.dll SetServer -Name=.. -Url=.. -Token=...
```

添加 `-Default` 参数会将该服务器配置为默认使用的服务器。使用 `-Help` 参数运行，可获取所有可用选项的完整列表。

### 注册

使用管理员用户身份登录后，找到 `http://[HORDE-SERVER-URL]/account` 页面，页面上会有一个 **获取代理注册令牌（Get agent registration token）** 的链接。该令牌可以嵌入到默认代理配置文件中，或者传递给 `SetServer` 命令（见上文）

代理第一次连接到服务器时，会为自身生成一个唯一的连接令牌。

在Windows上，连接令牌存储在以下位置：

```
C:\Users[用户]\AppData\Local\Epic Games\Horde\Agent\servers.json
```

（如果在普通用户账户下运行）

```
C:\Windows\system32\config\systemprofile\AppData\Local\Epic Games\Horde\Agent\servers.json
```

（如果作为服务运行）

在Mac/Linux中，连接令牌存储在以下位置：

```
~/.local/share/Horde.Agent/servers.json
```

### 作为服务运行

#### Windows

运行MSI安装程序时，Horde代理默认会被配置为作为后台服务运行。当直接从服务器下载代理并手动配置代理时，可以运行以下命令以注册服务：

```
dotnet HordeAgent.dll service install [-UserName=..] [-Password=..]
```

其中， `-UserName` 和 `-Password` 用于指定运行服务所使用账户的凭证。

可以使用以下命令卸载服务：

```
dotnet HordeAgent.dll service uninstall
```

#### Mac

创建一个 `/Library/LaunchAgents/epic.hordeagent.plist` 文件，描述daemon配置（根据实际情况替换 `{{ HORDE_SERVICE_ACCOUNT }}` 变量）。

```
<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict>    <key>RunAtLoad</key>    <true/>     <key>ProgramArguments</key>    <array>        <string>/usr/local/bin/dotnet</string>        <string>HordeAgent.dll</string>        <string>service</string>        <string>run</string>        <string>-server=Prod</string>        <string>-workingdir=/Users/{{ HORDE_SERVICE_ACCOUNT }}/Build</string>    </array>     <key>EnvironmentVariables</key>    <dict>        <key>PATH</key>        <string>/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin</string>    </dict>     <key>GroupName</key>    <string>admin</string>     <key>WorkingDirectory</key>    <string>/Users/{{ HORDE_SERVICE_ACCOUNT }}/Horde</string>     <key>UserName</key>    <string>{{ HORDE_SERVICE_ACCOUNT }}</string>     <key>KeepAlive</key>    <true/>     <key>Label</key>    <string>epic.hordeagent</string>     <key>StandardErrorPath</key>    <string>/Users/{{ HORDE_SERVICE_ACCOUNT }}/Library/Logs/hordeagent_error.log</string>     <key>ExitTimeOut</key>    <integer>10</integer></dict></plist>
```

调整 `/etc/newsyslog.conf` 日志文件输出大小限制（可选）：

```
append '/Library/Logs/hordeagent_error.log 700 2 1000 * J'
```

设置你想要在plist之外定义的Horde代理环境变量（可选）：

```
launchctl setenv Horde:WorkingDirectory {horde_working_directory}
```

启动daemon：

```
launchctl load -w /Library/LaunchAgents/epic.hordeagent.plist
```

#### Linux

创建一个用户来运行代理服务。在Linux系统上，虚幻引擎编辑器不能以root用户身份运行，因此Horde代理服务需要以非root用户身份运行。代理的工作目录需要由该用户递归所有。该用户必须具有 `sudo` 权限，才能重启/关闭/自动缩放Horde代理。

在 `/etc/systemd/system/horde-agent.service` 中创建一个服务描述符文件（根据实际情况替换 `{{ HORDE_PATH }}` 、 `{{ HORDE_WORKING_DIRECTORY }}` 和 `{{ HORDE_SERVICE_ACCOUNT }}` 变量）：

```
[Unit]Description=Horde Agent [Service]ExecStart=dotnet {{ HORDE_PATH }} -WorkingDir={{ HORDE_WORKING_DIRECTORY }}WorkingDirectory={{ HORDE_WORKING_DIRECTORY }} Restart=alwaysRestartSec=5SyslogIdentifier=horde-agent StandardOutput=append:{{ HORDE_WORKING_DIRECTORY }}/log.txtStandardError=append:{{ HORDE_WORKING_DIRECTORY }}/err-log.txt User={{ HORDE_SERVICE_ACCOUNT }} [Install]WantedBy=multi-user.target
```

启动daemon：

```
systemctl daemon-reload
```

### 工作目录

代理使用的数据（Perforce工作空间、缓存、暂存空间）的默认存储位置如下：在Windows系统上为 `C:\ProgramData\HordeAgent` ，在Mac和Linux系统上为应用程序目录。

可以使用代理的[`Agent.json`](../horde-settings/index.md#%E4%BB%A3%E7%90%86%E8%AE%BE%E7%BD%AE)文件中的 `WorkingDir` 属性重载此路径。

为防止代理受到失控的作业用影响，致使数据填满磁盘，最好让代理将数据存储在系统磁盘之外的驱动器上。在Windows上，也建议将 `%TEMP%` 和 `%TMP%` 环境变量设置为该驱动器。

### 安装网络共享

可以通过代理的[`Agent.json`](../horde-settings/index.md#%E4%BB%A3%E7%90%86%E8%AE%BE%E7%BD%AE)文件中的 `Shares` 属性，将代理配置为在启动并开始执行工作之前挂载某些网络共享。

### GPU访问

在Horde中运行的某些作业（特别是测试类作业）需要访问GPU。但将代理作为Windows服务运行会阻止对GPU的访问。要解决该问题，代理必须作为普通Windows用户在交互式会话中运行。具体方法有多种，例如在台式机上从PowerShell脚本运行代理，或者使用[NSSM](https://nssm.cc/)等外部工具。务必要确保代理进程在意外退出的情况下能够重新启动。

由于大多数代理不需要GPU访问权限，因此建议专门为需要该支持的交互式代理创建一个单独的池。

### Linux和Wine

Wine是一个兼容层，它让Windows应用程序能够在类Unix系统上运行，从而使Linux系统上的代理可以在Wine下执行远程计算任务。在Linux上而非Windows上运行工作负载具有诸多优势，例如操作系统启动时间更快、磁盘I/O性能更优，且无需支付许可证开销。

要启用Wine，必须在[wineExecutablePath](../horde-settings/index.md#%E4%BB%A3%E7%90%86%E8%AE%BE%E7%BD%AE)配置选项中设置 `wine64` 的路径，具体如代理设置文档中所述。你可以使用Bash中的包装脚本修改发送到Wine的参数，在本例中为配置必要的文件路径。运行构建时，必须将UnrealBuildTool的 `-UBAHordeAllowWine` 标记设置为true，其默认值也是true。满足这些先决条件后，代理在执行计算任务时会尝试使用Wine，并在保持与Windows应用程序（如 `cl.exe` 和 `link.exe` ）兼容的同时，充分利用在Linux上运行的优势。

```
#!/bin/bash# Wine的包装脚本，提供了一个切入点，可对要运行的Windows应用程序传入的命令行参数进行修改# 目前，该脚本主要由运行UnrealBuildAccelerator（UBA）的远程执行任务调用export WINEDEBUG=-allexport WINEARCH=win64export WINEPREFIX=/opt/horde/wine-data# 将UE_HORDE_SHARED_DIR覆盖设置为指向将在Wine内存在的C:\。# 这又会被挂载在上文指定的WINEPREFIX下export UE_HORDE_SHARED_DIR="C:\\Uba" if [ -n "$${UE_HORDE_TERMINATION_SIGNAL_FILE}" ]; then  # 将Linux路径重写为Wine中Z:\下映射到/的Windows路径（将斜杠替换为反斜杠）  export UE_HORDE_TERMINATION_SIGNAL_FILE="Z:$${UE_HORDE_TERMINATION_SIGNAL_FILE//\//\\}"fi /usr/local/bin/wine64 "$@"
```
