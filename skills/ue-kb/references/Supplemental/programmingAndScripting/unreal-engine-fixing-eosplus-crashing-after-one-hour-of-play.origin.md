# 修复 EOSPlus 在游戏一小时后崩溃的问题

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/1w1B/unreal-engine-fixing-eosplus-crashing-after-one-hour-of-play

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2354 字符。

## 摘要

如果您的游戏在使用 EOS+ 玩一小时后崩溃，本指南可以帮助您！

## 中文整理

### 概览

如果您的游戏在使用 EOS+ 玩一小时后崩溃，这可能是因为身份验证令牌即将过期且未正确刷新。此修复仅适用于 C++ 项目，因为它需要更改 OnlineSubsystemEOS 插件的源代码。本指南是为虚幻引擎 5.4 编写的，但它可能适用于其他版本的引擎。

### 概括

我们需要在授权令牌过期（60 分钟）之前重新登录 EOS。还需要删除OnlineSubsystemEOS插件中的一个检查，这样即使玩家已经登录，登录仍然可以执行。

### 步步

### 1.登录玩家

登录EOS的代码可以在[EpicGames/EOS-Getting-Started](https://github.com/EpicGames/EOS-Getting-Started/blob/efc3b297971fcb003f6c2ee1d895a45e62b32e6e/OnlineSubsystemEOS/Source/EOS_OSS_Tutorial/EOSPlayerController.cpp#L69) Github中找到存储库。

### 2. X分钟后执行自动登录

登录完成后，会收到回调。在 OnLoginCompleteDelegate 回调中，可以设置一个计时器，在 X 分钟后自动重新登录。就我而言，我选择了 50 分钟。

```cpp
const FTimerDelegate LoginDelegate = FTimerDelegate::CreateUObject(this, &ThisClass::Login);

GetWorld()->GetTimerManager().SetTimer(LoginTimerHandle, LoginDelegate, 50.f * 60.f, true);
```

### 3.去掉EOS登录检查

要删除该检查，我们需要修改 OnlineSubsystemEOS 插件。如果您无法修改引擎代码，请将插件（在引擎安装中可用）复制到项目的 /Plugins 文件夹中。在那里它可以像任何其他项目插件一样进行修改和编译。在 OnlineSubsystemEOS 插件中，修改 UserManagerEOS::Login 方法，并删除（或注释掉）第 401 行开始的以下代码：

```cpp
// if (GetLoginStatus(LocalUserNum) == ELoginStatus::LoggedIn)
// {
//   UE_LOG_ONLINE(Warning, TEXT("User (%d) already logged in."), LocalUserNum);
//   TriggerOnLoginCompleteDelegates(LocalUserNum, false, *FUniqueNetIdEOS::EmptyId(), FString(TEXT("Already logged in")));
//   return true;
// }
```

此代码检查用户是否已登录，如果是，则停止登录过程。去掉后就可以正常登录了。

### 这就是全部

我希望你学到了新东西！ *由 Lorwen 制作* 🧡
