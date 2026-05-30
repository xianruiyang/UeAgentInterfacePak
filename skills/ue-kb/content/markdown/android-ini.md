# Android：从命令行编辑 INI 参数

# Android：从命令行编辑 INI 参数

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/EooW/unreal-engine-android-editing-ini-parameters-from-the-command-line

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1370 字符。

## 摘要

文章由 Ryan B 撰写。目前 INI 参数只能从 DefaultEngine.ini 中读取。在用于分发版本的 UEDeployAndroid.cs 中，这些值是从 ini 读取并写入之前的 gradle.properties 中。

## 中文整理

### 概览

*文章由 [Ryan B.](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写* 目前 INI 参数只能从 DefaultEngine.ini 中读取。在用于分发版本的 UEDeployAndroid.cs 中，在调用 Gradle 打包 AAB 或 APK 之前，从 ini 读取这些值并将其写入 gradle.properties 中。这是读取这些内容的代码：

```cpp
string KeyAlias, KeyStore, KeyStorePassword, KeyPassword;
Ini.GetString("/Script/AndroidRuntimeSettings.AndroidRuntimeSettings", "KeyStore", out KeyStore);
Ini.GetString("/Script/AndroidRuntimeSettings.AndroidRuntimeSettings", "KeyAlias", out KeyAlias);
Ini.GetString("/Script/AndroidRuntimeSettings.AndroidRuntimeSettings", "KeyStorePassword", out KeyStorePassword);
Ini.GetString("/Script/AndroidRuntimeSettings.AndroidRuntimeSettings", "KeyPassword", out KeyPassword);
```

您可以使用以下命令从命令行获取这些内容：

```cpp
class UEDeployAndroid : UEBuildDeploy, IAndroidDeploy
 {
     [CommandLine("-keystorepassword")]
     private string ArgKeyStorePassword = null;
     ....
 }
```

如果提供了参数，则覆盖 ini：

```cpp
if (ArgKeyStorePassword != null)
     {
         KeyStorePassword = ArgKeyStorePassword;
     }
```

