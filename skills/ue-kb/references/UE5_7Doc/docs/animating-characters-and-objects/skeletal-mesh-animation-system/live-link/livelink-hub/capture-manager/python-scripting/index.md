---
title: "Python脚本编写"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/python-scripting"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "Live Link", "LiveLink Hub", "捕获管理器", "Python脚本编写"]
---

# Python脚本编写

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / Live Link / LiveLink Hub / 捕获管理器 / Python脚本编写

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/python-scripting

**捕获管理器**的下载和镜头试拍摄取工作可作为表演捕获工作流程的一部分由Python API自动完成。 捕获管理器插件自带许多示例脚本，你可以将其用作参考，根据具体需求进行修改。 你需要使用**LiveLinkHub**可执行文件来执行Python脚本。

> [!WARNING]
> 对于命令中出现的路径，请使用正斜杠`/`（而不是`\`），以避免字符解析问题。

## 下载镜头试拍

插件中提供了一个从**Live Link Face**设备下载数据的示例脚本。 你可以将该脚本用作参考，根据具体要求进行修改。 脚本的位置如下：

`\Engine\Plugins\VirtualProduction\CaptureManager\CaptureManagerApp\Content\Python\examples\live_link_face_download_only.py`

可以使用以下命令从Windows终端（如PowerShell）运行该脚本，并根据你的环境更新`ip-address`参数：

Command Line

```
LiveLinkHub.exe -ExecutePythonScript="<path-to-ue-installation>/Engine/Plugins/VirtualProduction/CaptureManager/CaptureManagerApp/Content/Python/examples/live_link_face_download_only.py --ip-address <ip-address>"
```

## 摄取镜头试拍

我们提供了几个示例脚本，分别用于演示如何从[单目视频](../capture-manager-devices/mono-video-device/index.md)、[Live Link Face](../capture-manager-devices/live-link-face-device/index.md)和[镜头试拍档案](../capture-manager-devices/take-archive-device/index.md)设备摄取数据。 你可以将这些脚本用作参考，根据具体要求进行修改。 这些脚本的文件夹位置如下：

`\Engine\Plugins\VirtualProduction\CaptureManager\CaptureManagerApp\Content\Python\examples\`

你可以将以下命令作为模板，从Windows终端（如PowerShell）运行这些脚本。 你需要根据你的环境更新`path-to-takes`参数：

Command Line

```
LiveLinkHub.exe -ExecutePythonScript="<path-to-ue-installation>/Engine/Plugins/VirtualProduction/CaptureManager/CaptureManagerApp/Content/Python/examples/take_archive_ingest.py --archive-path <path-to-takes>"
```
