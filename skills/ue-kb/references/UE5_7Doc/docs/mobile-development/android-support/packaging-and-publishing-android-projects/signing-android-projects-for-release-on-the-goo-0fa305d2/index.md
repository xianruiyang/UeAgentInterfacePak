---
title: "项目发布签名"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/signing-android-projects-for-release-on-the-google-play-store-with-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "Android支持", "打包和发布", "项目发布签名"]
---

# 项目发布签名

> 路径：虚幻引擎5.7文档 / 移动端开发 / Android支持 / 打包和发布 / 项目发布签名

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/signing-android-projects-for-release-on-the-google-play-store-with-unreal-engine

选择操作系统：

Windows

macOS

Linux

在本文中，我们将介绍为了让 UE4 移动端项目上架 Google Play 商店，你需要做好哪些准备。

请注意：此文档只集中讨论与 UE4 项目上架 Google Play 商店有关的内容。 如需了解 Google Play 商店的整体信息，请查阅官方 [Google Developer Console 帮助](https://support.google.com/googleplay/android-developer#topic=3450986)。

## 生成密钥

在提交甚至上传项目到 Google Play 商店之前，需要生成一个密钥库。 密钥库是一个单独的密钥，可确保您的项目只链接到您的 Google Play 账户。 以下部分将讲述如何生成密钥，以及如何进行放置，以便项目打包时使用。

1. 打开命令行窗口，找到 Android Studio 安装 `keytool.exe` 文件的目录。如果你使用的是默认安装路径，这个目录应该是 `\jre\bin`。
2. 打开命令行弹出窗口后，输入下列命令行参数并按下 Enter 键。

   ```
            keytool -genkey -v -keystore ExampleKey.keystore -alias MyKey -keyalg RSA -keysize 2048 -validity 10000
   ```

   > [!NOTE]
   > 可复制以上文本，右键粘贴到命令行参数窗口中，无需手动输入
3. 为密钥库输入密码。请牢记密码，因为之后需要多次输入密码。在此例中，我们使用 **123password** 作为密钥库密码。
4. 之后需要在命令行窗口中输入姓和名。在此例中输入名称 **TestGuy**，再按下 Enter 键。
5. 然后输入组织单位名。在此例中输入名称 **MyCompany**，再按下 Enter 键。
6. 输入组织名称。在此例中输入 **MyGame**，再按下 Enter 键。
7. 之后输入您所在的城市名或地名。在此例中输入 **MyCity**，然后按下 Enter 键继续。
8. 随后输入城市所在的州或省名。在此例中输入 **NC**，再按下 Enter 键继续。
9. 输入城市或州所在的城市代码。在此例中输入 **00**，再按下 Enter 键继续。
10. 将出现询问，确定输入的全部信息正确无误。在命令行窗口中输入 **Yes** 或 **Y**，再按下 Enter 键继续。
11. 我们只需要在此密钥库中保存一个密钥，因此需要执行的下一步操作就是在要求输入密码时按下 Enter 键。
12. 如全部设置正确，命令行窗口的最后一行将显示 **[Storing ExampleKey.keystore]**。

密钥被创建后将被放置在 `\jre\bin` 目录中。该目录包含 `keytool.exe`。

## 放置密钥

密钥生成后，需要将其放置在 UE4 项目的以下路径中。

```
	（游戏文件夹）\Build\Android
```

## 应用密钥

将密钥放置到 **（游戏文件夹）\Build\Android** 文件夹中后，需要执行下列操作将其应用到 UE4 项目。

1. 前往 UE4 中的 **Edit > ProjectSettings > Platforms > Android**。
2. 在 **APK Packing** 部分下，将 **Store Version** 设为数字 1（如这是首次上传项目到商店）。

   > [!NOTE]
   > 每次重新打包游戏再次上传到商店时，均需要增加 Store Version 的数字。如未执行此操作，新的 APK 文件将无法上传覆盖旧文件。
3. 随后将以上用于生成密钥库的密钥库信息填入 **Distribution Signing** 中的以下栏位。

   | 属性名 | 描述 | 范例中使用的名称 |
   | --- | --- | --- |
   | Key Store | 为 .Keystore file 文件赋予的命名 | ExampleKey.keystore |
   | Key Alias | .Keystore file 文件的命名。- ExampleKey.keystore | MyKey |
   | Key Store Password | 用于保护密钥的密码 | 123password |
4. 所有信息填入后，前往项目的 Packaging 部分，将 Project 部分下的 Full Rebuild 和 For Distribution 启用。

## 部署至 Google Play 商店

现在即可将项目上传至 Google Play 商店。 如需了解如何将项目上传至 Google Play 商店，请查阅官方 [Google Developer Console](https://support.google.com/googleplay/android-developer#topic=3450986) 帮助页面。
