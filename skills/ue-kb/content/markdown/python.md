# Python

---
title: "Python"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/python-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "插件设置", "Python"]
---

# Python

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 插件设置 / Python

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/python-settings-in-the-unreal-engine-project-settings

## Python

### Python

| **设置** | **说明** |
| --- | --- |
| **启动脚本（Startup Scripts）** | 要在启动时运行的Python脚本的数组。这些脚本会在引擎初始化之后的第一个更新函数之前运行。 |
| **其他路径（Additional Paths）** | 要添加到Python系统路径的其他路径的数组。 |
| **隔离解译器环境（Isolate Interpreter Environment）** | 定义嵌入式解译器是否应该在隔离模式下运行。 在隔离情况下，解译器将忽略标准 `PYTHON*` 环境变量（ `PYTHONPATH` 、 `PYTHONHOME` 等）、脚本的目录和用户的site-packages目录。 启用该设置后，引擎不会由于软件不兼容而崩溃。 如果你严格控制Python环境，并且确信所有内容都兼容，可以考虑禁用此选项。 无论解译器是否在隔离模式下运行， `UE_PYTHONPATH` 环境变量都会添加到 `sys.path` 。 |
| **高级（Advanced）** |  |
| **开发人员模式（所有用户）（Developer Mode (all users)）** | 定义是否应该为项目的所有用户在Python解译器上启用开发人员模式。 若在项目设置中设置开发人员模式，则将仅为此特定项目启用开发人员模式和Python开发。若在编辑器偏好设置中启用开发人员模式，则将为使用编辑器打开的所有项目中的Python开发启用开发人员模式。 若启用开发人员模式，则会产生与生成Python存根文件相关的额外开销，因为每次重启编辑器时都会生成此文件。如果你并不总是使用Python开发，请按项目启用此设置。 此设置还会启用额外警告（例如，对于废弃的代码）和存根代码生成，以用于外部IDE。 |

### Python远程执行

| **设置** | **说明** |
| --- | --- |
| **启用远程执行（Enable Remote Execution）** | 定义是否应该启用远程Python执行。 |
| **高级（Advanced）** |  |
| **组播组端点（Multicast Group Endpoint）** | 组播组端点（格式为UDP组播套接字应该加入的 `IP_ADDRESS:PORT_NUMBER` ）。 |
| **组播绑定地址（Multicast Bind Address）** | UDP组播套接字应该绑定到的适配器地址，或使用 `0.0.0.0` 以绑定到所有适配器。 |
| **发送缓冲区大小（Send Buffer Size）** | 远程端点连接的发送缓冲区的大小。 |
| **接收缓冲区大小（Receive Buffer Size）** | 远程端点连接的接收缓冲区的大小。 |
| **组播生存时间（Multicast Time-To-Live）** | UDP组播套接字应该使用的TTL（使用 `0` 时仅限于本地主机，使用 `1` 时仅限于本地子网）。 |

