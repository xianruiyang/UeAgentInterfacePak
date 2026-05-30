# 适用于 Meta Quest VR 的虚幻引擎 5.2.1

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/1GxB/unreal-engine-5-2-1-for-meta-quest-vr

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 9167 字符。

## 摘要

XR Meta Quest 设置指南涵盖一切

## 中文整理

### 概览

我经常看到有人询问为 Quest VR 配置 Unreal 的过程。因此，我向您介绍在原始 Windows 安装上设置虚幻引擎 5.2.1 (Oculus VR) 的指南。 **所需下载** 下载：“Visual Studio 2022 Community Edition”：[https://visualstudio.microsoft.com/vs/community/](https://visualstudio.microsoft.com/vs/community/) 下载：“jdk-13.0.2”： [https://www.oracle.com/java/technologies/javase/jdk13-archive-downloads.html](https://www.oracle.com/java/technologies/javase/jdk13-archive-downloads.html)下载：“Android Studio Flamingo | 2022.2.1 补丁 1 2023 年 5 月 1 日”： [https://developer.android.com/studio/archive](https://developer.android.com/studio/archive) 下载：“GitHub Desktop”：[https://desktop.github.com/](https://desktop.github.com/) 下载：“Git”：[https://git-scm.com/download/win](https://git-scm.com/download/win) 下载：“Oculus Desktop App”： [https://www.meta.com/quest/setup/](https://www.meta.com/quest/setup/) 下载：“Meta Quest Developer Hub for Windows”：[https://developer.oculus.com/downloads/package/oculus-developer-hub-win](https://developer.oculus.com/downloads/package/oculus-developer-hub-win) 下载：“Meta XR Simulator 57”： [https://developer.oculus.com/downloads/package/meta-xr-simulator/](https://developer.oculus.com/downloads/package/meta-xr-simulator/) *我建议将所有这些安装到“C:驱动器”，因为其中一些工具太疯狂了。* **安装“Visual Studio 2022 Community Edition”。** 1. 安装程序将显示“工作负载”选项卡 2. 选择/勾选“游戏/游戏开发” C++” 3. 选择后，查看“详细信息”，勾选 Android 旁边的框 4. 安装 5. 完成后重新启动计算机 **JDK 13.0.2.** 1. 解压缩到“C:/Program Files” **Android Studio Flamingo。** 1. 运行安装程序 2. 打开“Android Studio”并安装所需的内容 3. 重新启动“Android Studio”，您会看到一个名为“更多操作”的蓝色小菜单 4. 选择“SDK Manager” 5. 忽略左侧的菜单 6. 在该窗口的右下角，您会看到一个名为“隐藏过时的包”的复选框，勾选该框 7. 在“SDK 平台”选项卡下勾选：Android 12L (Sv2)、Android 12.0 (S)、Android 11.0 (R) 和 Android 10.0 (Q)；这样您就可以在每个设备上执行 Android 的所有操作，而不仅仅是 Meta 8。 Tools”选项卡展开“Android SDK Build-Tools 34” 9. 勾选以下框：34.0.0、32.0.0、31.0.0、30.0.3 10. 向下滚动并展开“NDK（并排）” 11. 勾选旁边的框：25.1.8937393 12. 向下滚动并展开“Android SDK Command-line Tools” 13.勾选版本 8.0 的框...
