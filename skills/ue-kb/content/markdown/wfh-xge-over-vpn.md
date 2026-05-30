# 实验 WFH：XGE Over VPN 自动配置

# 实验 WFH：XGE Over VPN 自动配置

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/7yL6/unreal-engine-experimental-wfh-automatic-configuration-of-xge-over-vpn

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2754 字符。

## 摘要

文章由 Branden T 撰写。UE4 使用 Incredibuild 来缩短引擎和着色器编译时间。使用远程桌面连接到办公室中的 PC 使开发人员能够利用现有的 XGE 场。不…

## 中文整理

### 概览

*文章由 [Branden T.](https://dev.epicgames.com/community/profile/Kzq2/Branden.Turner) 撰写* UE4 使用 Incredibuild 来缩短引擎和着色器编译时间。使用远程桌面连接到办公室中的 PC 使开发人员能够利用现有的 XGE 场。不幸的是，远程桌面不太适合运行交互式编辑器会话，需要调试编辑器的用户通常会在本地 PC 上进行编译。通过 VPN 从本地 PC 使用 XGE 对互联网连接的负担很大，并且可能会导致编译时间更差。为了帮助解决这种情况，我们添加了一种机制，如果用户通过 VPN 连接到协调器，该机制会在 UnrealBuildTool 中禁用 XGE 执行器。通过检查路由到协调器的适配器的 IP 地址是否不允许来做出此确定。可以通过在 Engine/Programs/UnrealBuildTool/NotForLicensees/BuildConfiguration.xml 文件中创建或编辑以下内容来配置此行为：

```cpp
<?xml version="1.0" encoding="utf-8"?> 
<Configuration xmlns="https://www.unrealengine.com/BuildConfiguration">; 
  <XGE> 
     <bAllowOverVpn>false</bAllowOverVpn> 
     <VpnSubnets> 
           <Item>10.1.2.3/24</Item> <--Set your studio ranges here 
           <Item>10.4.5.6/24</Item> 
      </VpnSubnets> 
   </XGE>
 </Configuration>
```

新代码位于： **Perforce** //UE4/Main/Engine/Source/Programs/UnrealBuildTool/Executors/XGE.cs //UE4/Main/Engine/Source/Programs/UnrealBuildTool/System/Subnet.cs //UE4/Main/Engine/Source/Programs/UnrealBuildTool/System/PlatformExports.cs //UE4/Main/Engine/Source/Programs/UnrealBuildTool/UnrealBuildTool.csproj **GitHub** - [https://github.com/EpicGames/UnrealEngine/tree/master/Engine/Source/Programs/UnrealBuildTool/Executors/XGE.cs](https://github.com/EpicGames/UnrealEngine/tree/master/Engine/Source/Programs/UnrealBuildTool/Executors/XGE.cs) - [https://github.com/EpicGames/UnrealEngine/tree/master/Engine/Source/Programs/UnrealBuildTool/System/Subnet.cs](https://github.com/EpicGames/UnrealEngine/tree/master/Engine/Source/Programs/UnrealBuildTool/System/Subnet.cs) - [https://github.com/EpicGames/UnrealEngine/tree/master/Engine/Source/Programs/UnrealBuildTool/System/PlatformExports.cs](https://github.com/EpicGames/UnrealEngine/tree/master/Engine/Source/Programs/UnrealBuildTool/System/PlatformExports.cs) - [https://github.com/EpicGames/UnrealEngine/tree/master/Engine/Source/Programs/UnrealBuildTool/UnrealBuildTool.csproj](https://github.com/EpicGames/UnrealEngine/tree/master/Engine/Source/Programs/UnrealBuildTool/UnrealBuildTool.csproj)

