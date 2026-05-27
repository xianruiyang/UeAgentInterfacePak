---
title: "Python插件依赖项管理"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/python-plugin-dependency-management-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "编辑器的脚本与自动化", "使用Python脚本化运行虚幻编辑器", "Python插件依赖项管理"]
---

# Python插件依赖项管理

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / 编辑器的脚本与自动化 / 使用Python脚本化运行虚幻编辑器 / Python插件依赖项管理

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/python-plugin-dependency-management-for-unreal-engine

许多使用虚幻引擎（UE） **Python脚本插件** 的插件都依赖Python代码包，例如 **Python软件包索引** （[PyPI](https://pypi.org/)）提供的那些插件。[虚幻编辑器中的Python环境和路径](https://dev.epicgames.com/documentation/404)讨论了使Python脚本和库可用于虚幻编辑器Python环境的方法。除了这些方法之外，虚幻编辑器还支持通过另外两种方法打包插件及其Python依赖项，以便可供嵌入式虚幻编辑器Python环境访问。

## /Content/Python的特殊子目录

对于每个启用的插件，虚幻编辑器会自动将插件依赖项的以下路径添加到Python `sys.path` 列表中。仅当这些路径存在时才添加。

- `<PluginDir>/Content/Python/Lib/site-packages`
- `<PluginDir>/Content/Python/<CurrentPlatform>/Lib/site-packages`

要将纯Python库与插件打包，请将库复制或安装到 `<PluginDir>/Content/Python/Lib/site-packages` 。

如果该库还包含已编译的二进制文件（例如，具有Python绑定的C/C++库），那么你应将库复制或安装到每个受支持的平台（Linux、Mac和/或Win64）的 `<Plugin>/Content/Python/<CurrentPlatform>/Lib/site-packages` 中。

## 插件pip install依赖项

虚幻编辑器支持在启动时使用 **pip** 下载并安装已启用插件的所有Python依赖项，或通过特殊的虚幻编译工具（UBT）模式下载并安装。要使用此功能，你必须将 `PythonRequirements` 添加到每个需要安装依赖项的 `.uplugin` 描述符文件中。

> [!NOTE]
> 你只能使用pip安装二进制包（wheel）。

### pip安装程序设置

pip安装程序的项目特定设置可以在 **项目设置（Project Settings）** 的 **插件（Plugins） - Python** 分段下找到。

![虚幻编辑器中pip安装程序的项目设置](../../../../../assets/images/66/66966619ace1656c9a685c8bc7206395b4261a0ac49698ae2efcc04e97a4a069.jpg)

| **参数** | **说明** |
| --- | --- |
| **启动时运行Pip Install(Run Pip Install on Startup)** | 使pip安装程序在编辑器启动时运行。 |
| **高级 - pip严格哈希校验（Advanced - Pip Strict Hash Checking）** | 确保只安装了有效的软件包，所有支持Epic的插件都使用pip严格哈希校验。如果你提供不受信任的重载索引Url（供应链攻击），此项尤为重要。严格哈希校验要求所有软件包都版本固定并列出哈希值。如果你在创建具有Python依赖项的自有插件，你最好在开发过程中禁用此选项，以便简化操作。 禁用此选项后，除非已安装所有软件包，否则具有python依赖项的插件可能无法正确运行。 |
| **高级 - 仅离线（Advanced - Offline Only）** | 仅离线模式将运行pip install工具,以检查所有依赖项是否可用，但如果依赖项尚未安装，则会失败并显示日志消息。 |
| **高级 - 重载索引URL（Advanced - Override Index URL）** | 强制仅使用指定的索引URL。这对于限制性防火墙场景特别有用，因为所有必要的软件包和版本都可以缓存在本地devpi或类似的软件包索引缓存服务器中。 此设置还会重载插件描述符中指定的任何ExtraIndexUrls（请参阅下面的Pip Install插件描述符配置），因此必须缓存来自所有索引的所有包。 |

### 启动时禁用Pip Install

如果确定已经安装python依赖项，或者某些commandlet或编辑器实例不需要这些依赖项，则可以通过两种方式禁用在编辑器启动时运行pip install。第一种是如上所述，取消选中 **启动时运行Pip Install（Run Pip Install on Startup）** 设置以禁用安装程序。第二种是使用命令行标记 `-DisablePipInstall` 禁用pip install。

### 使用虚幻编译工具（UBT）运行Pip Install

对于插件开发者和高级用户来说，使用虚幻编译工具（UBT）测试pip安装程序会很有用。`-Mode=PipInstall` UBT标记通过命令行运行pip安装程序。以下示例展示了 `EngineTest` 项目的pip install，假定用户从UE根目录运行。

Command Line

```
	Engine\Build\BatchFiles\RunUBT.bat EngineTestEditor Win64 Development -Project=..\..\EngineTest\EngineTest.uproject -Mode=PipInstall 
```

### 离线安装

Pip install工具需要联网才能从Python软件包索引下载Python包。如果由于限制性防火墙规则或类似原因而无法在线安装，你可以在另一台联网的计算机上下载所有必要的依赖项，然后将下载的包复制到目标机器的pip install site-packages目录中。

1. 在联网的机器上，运行相同的编辑器项目或pip install UBT模式，并允许下载包依赖项。
2. 压缩 `site-packages` 文件夹（请参阅下文的"软件包安装在哪里"小节）。
3. 将此zip文件复制到目标机器，解压到适当的项目 `site-packages` 目录中（请参阅下文的"软件包安装在哪里"小节）。

### 软件包安装在哪里

所有Python依赖项都安装在：

- **Windows** ： `<ProjectDir>/Intermediate/PipInstall/Lib/site-packages`
- **Linux/MacOS** ： `<ProjectDir>/Intermediate/PipInstall/lib/python3.11/site-packages`

## Pip Install插件描述符配置

插件描述符文件中的 `PythonRequirements` 包含对象的JSON数组，每个平台有一个对象。每个JSON对象指定：

- 一个 `Platform` （全部、Linux、Mac或Win64）。
- 一个pip `requirements.txt` 行格式的 `Requirements` 行数组。

每个对象还可以选择包含一个 `ExtraIndexUrls` 数组，其中包含其他包索引的附加url列表（始终包含PyPI）。

> [!NOTE]
> 虽然UE支持大多数常见的pip要求的行说明符，但它会忽略命令标记（例如， `--force index-url` ）。

下面是引擎 `PythonFoundationPackages.uplugin` 文件中带注解的摘录，展示了如何使用 `PythonRequirements` 字段来安装 `numpy 1.24.4` 、 `scipy 1.11.0` 和 `torch 2.1.0` 。每个平台都设置了 `torch` 要求，以便Windows/Linux平台安装支持CUDA的软件包版本。

> [!NOTE]
> 如果启用了严格哈希校验，则每个需求行必须包含所有受支持wheel的哈希值。

PythonFoundationPackages.uplugin

```
	{ 		"FriendlyName": "Python Foundation Packages", 		... 		"PythonRequirements": 		[ 			{  				// 将为每个平台安装"全部"下面列出的要求 				"Platform": "All", // "All", "Linux", "Mac", or "Win64" 				"Requirements": 				[ 					"numpy==1.24.4 --hash=sha256:9667575fb6d13c95f1b36aca12c5ee3356bf001b714fc354eb5465ce1609e62f --hash=sha256:7ffe43c74893dbf38c2b0a1f5428760a1a9c98285553c89e12d70a96a7f3a4d6 --hash=sha256:7215847ce88a85ce39baf9e89070cb860c98fdddacbaa6c0da3ffb31b3350bd5 --hash=sha256:ed094d4f0c177b1b8e7aa9cba7d6ceed51c0e569a5318ac0ca9a090680a6a1b1 --hash=sha256:befe2bf740fd8373cf56149a5c23a0f601e82869598d41f8e188a0e9869926f8 --hash=sha256:b4bea75e47d9586d31e892a7401f76e909712a0fd510f58f5337bea9572c571e --hash=sha256:f136bab9c2cfd8da131132c2cf6cc27331dd6fae65f95f69dcd4ae3c3639c810 --hash=sha256:c0bfb52d2169d58c1cdb8cc1f16989101639b34c7d3ce60ed70b19c63eba0b64 --hash=sha256:d11efb4dbecbdf22508d55e48d9c8384db795e1b7b51ea735289ff96613ff74d --hash=sha256:2541312fbf09977f3b3ad449c4e5f4bb55d0dbf79226d7724211acc905049400 --hash=sha256:e2926dac25b313635e4d6cf4dc4e51c8c0ebfed60b801c799ffc4c32bf3d1254 --hash=sha256:b7b1fc9864d7d39e28f41d089bfd6353cb5f27ecd9905348c24187a768c79694",  					"scipy==1.11.0 --hash=sha256:ee410e6de8f88fd5cf6eadd73c135020bfbbbdfcd0f6162c36a7638a1ea8cc65 --hash=sha256:6550466fbeec7453d7465e74d4f4b19f905642c89a7525571ee91dd7adabb5a3 --hash=sha256:028eccd22e654b3ea01ee63705681ee79933652b2d8f873e7949898dda6d11b6 --hash=sha256:f3cd9e7b3c2c1ec26364856f9fbe78695fe631150f94cd1c22228456404cf1ec --hash=sha256:36750b7733d960d7994888f0d148d31ea3017ac15eef664194b4ef68d36a4a97 --hash=sha256:2c6ff6ef9cc27f9b3db93a6f8b38f97387e6e0591600369a297a50a8e96e835d --hash=sha256:933baf588daa8dc9a92c20a0be32f56d43faf3d1a60ab11b3f08c356430f6e56 --hash=sha256:acf8ed278cc03f5aff035e69cb511741e0418681d25fbbb86ca65429c4f4d9cd --hash=sha256:530f9ad26440e85766509dbf78edcfe13ffd0ab7fec2560ee5c36ff74d6269ff --hash=sha256:f313b39a7e94f296025e3cffc2c567618174c0b1dde173960cf23808f9fae4be --hash=sha256:cf00bd2b1b0211888d4dc75656c0412213a8b25e80d73898083f402b50f47e41 --hash=sha256:91af76a68eeae0064887a48e25c4e616fa519fa0d38602eda7e0f97d65d57937 --hash=sha256:ad669df80528aeca5f557712102538f4f37e503f0c5b9541655016dd0932ca79 --hash=sha256:1b7c3dca977f30a739e0409fb001056484661cb2541a01aba0bb0029f7b68db8 --hash=sha256:6e619aba2df228a9b34718efb023966da781e89dd3d21637b27f2e54db0410d7 --hash=sha256:bc9a714581f561af0848e6b69947fda0614915f072dfd14142ed1bfe1b806710" 				]  			}, 			{ 				"Platform": "Linux", 				// 基于CUDA的torch需要额外的索引来搜索wheel				"ExtraIndexUrls": 				["https://download.pytorch.org/whl/"], 				"Requirements": 				[ 					"torch==2.1.0+cu118 --hash=sha256:bcb17e2de6ca634d326203694d0bfb552587335e536c1917be3f28c5664b5506 --hash=sha256:8ecf52ba49cfd3b7303d4e57e7b5c2106b77dbc9bdeaf880870162138bc70e18 --hash=sha256:a81b554184492005543ddc32e96469f9369d778dedd195d73bda9bed407d6589" 				] 			}, 			{ 				"Platform": "Mac", 				"ExtraIndexUrls": 				["https://download.pytorch.org/whl/"], 				"Requirements": 				[ 					"torch==2.1.0 --hash=sha256:3cd1dedff13884d890f18eea620184fb4cd8fd3c68ce3300498f427ae93aa962 --hash=sha256:601b0a2a9d9233fb4b81f7d47dca9680d4f3a78ca3f781078b6ad1ced8a90523 --hash=sha256:05661c32ec14bc3a157193d0f19a7b19d8e61eb787b33353cad30202c295e83b --hash=sha256:101c139152959cb20ab370fc192672c50093747906ee4ceace44d8dd703f29af --hash=sha256:421739685eba5e0beba42cb649740b15d44b0d565c04e6ed667b41148734a75b --hash=sha256:a6b7438a90a870e4cdeb15301519ae6c043c883fcd224d303c5b118082814767 --hash=sha256:c8bf7eaf9514465e5d9101e05195183470a6215bb50295c61b52302a04edb690 --hash=sha256:6ad491e70dbe4288d17fdbfc7fbfa766d66cbe219bc4871c7a8096f4a37c98df" 				] 			} 		] 	}  
```

## Pip严格哈希校验

**严格哈希校验** 可确保下载的包与预期内容完全匹配，并且在新项目和插件中默认启用。严格哈希校验要求你在 `Requirements` 下面的 `.uplugin file` 中列出所有包的确切版本和哈希信息。请参阅上一节中 `Requirements` 版块中列出的带有哈希值的.uplugin文件的示例。

### 如何禁用严格哈希校验

如果你在创建具有Python依赖项的自有插件，你最好在开发过程中禁用严格哈希校验，以便简化操作。要禁用严格哈希校验，请执行以下步骤：

1. 打开项目设置（Project Settings）> 插件（Plugins）> Python。
2. 展开Python Pip Install的

   高级（Advanced）

   设置。
3. 取消选中

   Pip严格哈希校验（Pip Strict Hash Check）

![在Python插件设置中取消选中Pip严格哈希校验](../../../../../assets/images/66/6686ba4cb54ce9f17cc412934b1e722c6af3b423d5cd735ee39e9308eeda0213.png)
