---
title: "运行Gauntlet测试"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/running-gauntlet-tests-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "Gauntlet自动化框架", "运行Gauntlet测试"]
---

# 运行Gauntlet测试

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / Gauntlet自动化框架 / 运行Gauntlet测试

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/running-gauntlet-tests-in-unreal-engine

## 运行Unreal命令：虚幻引擎（UE）的测试封装包

Gauntlet提供针对虚幻引擎的命令、测试和类，从而处理引擎的各类细节问题。

触发虚幻引擎测试的主要Gauntlet命令是 `RunUnreal` 。该命令利用特定的类来处理虚幻引擎打包的游戏和其他输出。

部分相关的测试已经进行了实施，以推动常见的测试工作流程，包括：

- UE.BootTest

  和

  UE.EditorBootTest

  - 启动项目客户端或编辑器，然后在初始化完成后退出。
- UE.EditorAutomation

  和

  UE.TargetAutomation

  - 在编辑器和客户端上运行引擎自动化测试框架。
- UE.Networking

  - 在目标地图被设为触发

  NetTestGauntletClientController

  或

  NetTestGauntletServerController

  时运行自动化网络测试。
- UE.ErrorTest

  - 在目标地图被设为触发

  ErrorTest

  Gauntlet控制器时为其运行自动化测试。
- UE.PLMTest

  - 在目标平台上运行进程生命周期管理。

### UE.Automation测试

`UE.Automation.cs` 下的测试简化了从构建系统运行[C++](../../create-automation-tests/write-cplusplus-tests/index.md)和[功能](../../create-automation-tests/functional-testing/index.md)测试的方式。

Gauntlet内有一个测试可以在编辑器中运行虚幻引擎功能测试，还有一个打包的游戏（客户端）：`UE.EditorAutomation` 和 `UE.TargetAutomation` 。

#### 编辑器命令行

```
RunUAT.bat RunUnreal -test=UE.EditorAutomation -runtest=Mytest.one -project=<path to uproject> -build=editor
```

#### 客户端命令行

```
RunUAT.bat RunUnreal -test=UE.TargetAutomation -runtest=Mytest.one -project=<path to uproject> -build=<path to packaged game>
```

#### 目标平台命令行

```
RunUAT.bat RunUnreal -test=UE.TargetAutomation -runtest=Mytest.one -project=<path to uproject> -build=<path to packaged game> -platform=<platform> -device=<ip>:<platform>
```

> [!NOTE]
> Gauntlet仅可以部署主机和移动设备构建，前提是你实现了相应的 `ITargetDevice` 、 `IDeviceFactory` 、 `IDefaultDeviceSource` 、 `IAppInstall` 和 `IAppInstance`

#### 失败时恢复测试

UE.Automation测试可以在严重故障（如运行过程中崩溃）后恢复测试。此行为是可选的，因为它会强制测试控制器在测试开始前保存JSON文件。

要启用恢复测试的行为，请添加参数 `-ResumeOnCriticalFailure` 。

测试恢复最多发生三次，之后将判定构建过于不稳定而无法继续测试。

## 用命令行向Gauntlet传递参数

你可以用命令行向Gauntlet传递自定义的参数。Gauntlet会自动将所有参数传递给测试类，而你可以通过特定的属性访问这些参数。

你可以使用如下命令行语法：

```
-test="MyTest(foo,bar='some value')"
```

你可以使用如下语法从测试类访问该参数：

```
bool MyBoolFromArgumentLine = Context.TestParams.ParseParam("foo");string MyValueFromArgumentLine = Context.TestParams.ParseValue("bar", "DefaultValue");
```

你也可以用UAT执行的C#代码来解析全局命令行参数（无论是否有其他代码使用它），使用的语法如下：

```
string MyValueFromArgumentLine = Globals.Params.ParseValue("ArgumentLine", "DefaultValue");
```

## Lyra Gauntlet测试

本节将说明如何运行[Lyra示例游戏](../../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/index.md)中的现有Gauntlet测试。

### 启动测试节点代码

```
using Gauntlet; namespace LyraTest{	/// <summary>	/// 简单的启动测试	/// </summary>	public class BootTest : UnrealTestNode<UnrealTestConfiguration>	{		public BootTest(UnrealTestContext InContext)		: base(InContext)		{} 		/// <summary>		/// 返回BootTest的配置，只需要客户端和合适的		/// 超时		/// 测试期望客户端自动退出		/// </summary>		/// <returns></returns>		public override UnrealTestConfiguration GetConfiguration()		{			UnrealTestConfiguration Config = base.GetConfiguration(); 			// 获取单个客户端			UnrealTestRole ClientRole = Config.RequireRole(UnrealTargetRole.Client);			// 触发特定日志消息时退出			ClientRole.CommandLineParams.Add("testexit", "GauntletHeartbeat: Idle"); 			Config.MaxDuration = 5 * 600; // 超时5分钟 			return Config;		}	}}
```

### 运行启动测试样例

1. 打开命令提示符。
2. 将目录更改为虚幻引擎根目录的

   Engine/Build/BatchFiles

   。
3. 在命令提示符中输入下列命令。

   ```
        RunUAT BuildCookRun -project=Samples/Games/Lyra/Lyra.uproject -platform=Win64 -configuration=Development -build -cook -pak -stage
   ```
4. 该过程完成后，在命令提示符中输入下列命令：

   ```
        RunUAT RunUnreal -project=Samples/Games/Lyra -platform=Win64 -configuration=Development -build=local -test=LyraTest.BootTest
   ```

### 启动测试流程说明

1. BuildCookRun

   将在

   Samples/Games/Lyra/Saved/StagedBuilds

   位置生成Win64版本的Lyra。
2. RunUnreal

   启动Gauntlet，并：

   1. 创建

      LyraTest.BootTest

      节点的实例，提供运行测试的基本规则。
   2. 发现Lyra项目的本地版本。
   3. 验证Win64开发版本是否可用。
   4. 启动Lyra。
   5. 监控运行过程中是否存在问题。
   6. 检测到Lyra退出。
   7. 检查常见问题，如崩溃、断言和致命错误等。
3. 如果

   LyraTest.BootTest

   节点证明测试仍在运行且没有错误，则创建摘要报告。
