# 通过Stats端口在专用服务器上接收Exec命令

# 通过Stats端口在专用服务器上接收Exec命令

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/3KEe/unreal-engine-receiving-exec-commands-on-a-dedicated-server-through-the-stats-port

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2798 字符。

## 摘要

文章由 Alex K 撰写。专用服务器的一个主要优点是它无头运行，没有任何游戏窗口。然而，能够在专用服务器上运行命令会很有帮助，尤其是在测试时……

## 中文整理

### 概览

*文章由 [Alex K.](https://dev.epicgames.com/community/profile/ZvMA/akoumandarakis) 撰写* 专用服务器的一个主要优点是它无头运行，没有任何游戏窗口。但是，能够在专用服务器上运行命令会很有帮助，尤其是在测试时。虽然您可以使用来自连接的客户端的服务器 RPC 来调用服务器上的行为，但在某些情况下可能无法或不需要拥有连接的客户端。幸运的是，您可以使用服务器的统计端口通过网络接收 exec 命令，本文将介绍如何设置此功能。首先，您需要确保设置了WITH_PERFCOUNTERS宏，并且您可以使用“-statsPort =”在命令行上指定统计端口的端口号。接下来，您需要将委托绑定到 FPerfCounters::OnPerfCounterExecCommand 来处理特定于游戏的命令。这可以在 GameInstance 中完成，例如：

```cpp
IPerfCountersModule& PerfCountersModule = FModuleManager::LoadModuleChecked<IPerfCountersModule>("PerfCounters");
 
IPerfCounters* PerfCounters = PerfCountersModule.CreatePerformanceCounters();
if (PerfCounters != nullptr)
{
    PerfCounters->OnPerfCounterExecCommand() = FPerfCounterExecCommandCallback::CreateUObject(this, &ThisClass::PerfExecCmd);
}
```

对于委托的示例：

```cpp
bool UYourGameInstance::PerfExecCmd(const FString& ExecCmd, FOutputDevice& Ar)
{
	FWorldContext* MyWorldContext = GetWorldContext();
	if (MyWorldContext)
	{
		UWorld* World = MyWorldContext->World();
		if (World)
		{
			if (GEngine->Exec(World, *ExecCmd, Ar))
			{
```

附加 exec 命令处理程序后，您可能需要调用 FHttpServerModule::Get().StartAllListeners();开始监听统计端口。您应该在服务器日志中看到一行内容，内容类似于“Created new HTTPListener on :”。一旦服务器侦听此端口并且有一个 exec 命令委托绑定到性能计数器，您就可以使用curl 等工具向服务器发送命令，格式如下：http://<address>:<statsport>/exec?c=<command>;例如：curl http://127.0.0.1:24002/exec?c=debug%20crash 最后，虽然启用此功能对于允许与专用服务器实例进行通信非常有用，但还必须考虑此功能的安全影响。您需要确保不是任何人都可以发送要在您的服务器上执行的命令，并且您可以使用多种方法来确保服务器的安全，例如简单地在发布版本中禁用该功能或​​使用防火墙来过滤传入的命令。

