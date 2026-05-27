---
title: "Horde自签名证书教程"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/horde-self-signed-certs-tutorial-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "建立你的开发流程", "Horde", "Horde教程", "Horde自签名证书教程"]
---

# Horde自签名证书教程

> 路径：虚幻引擎5.7文档 / 建立你的开发流程 / Horde / Horde教程 / Horde自签名证书教程

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/horde-self-signed-certs-tutorial-for-unreal-engine

## 简介

在生产环境中部署Horde时，建议使用经过验证的签名证书。

对于测试场景，安装自签名证书会很有用。

> [!WARNING]
> 使用自签名证书会绕过基本的安全措施。请勿在生产环境中使用此技术。

## 服务器

1. 在管理员PowerShell提示下，通过运行以下命令将证书添加到本地计算机的"个人"存储中：

   ```
        New-SelfSignedCertificate -CertStoreLocation 'Cert:\LocalMachine\My' -DnsName 'my-domain.com'
   ```
2. 从Windows"运行"菜单运行 `certmgr.msc` ，打开证书管理器MMC管理单元。你会在 `Personal\Certificates` 分段中看到在上面创建的证书。

   选择证书并按Ctrl+C。找到"Trusted Root Authorities\Certificates"分段，然后按Ctrl+V创建副本。
3. 打开[server.json](../../horde-configuration/horde-orientation/index.md)文件，取消注释 `HttpsPort` 行：

   ```
        "HttpsPort": 13341,
   ```

   ...以及文件底部的证书分段 - 将主题名称更新为在上面创建的证书上的DNS名称。

   ```
    "Kestrel": {     "Certificates":     {         "Default":         {             "Subject": "my-domain.com",             "Store": "My",             "Location": "LocalMachine"         }     } }
   ```
4. 重新启动服务器。你应能从同一台机器上的浏览器在端口13341通过HTTPS进行连接。

## 客户端

1. 通过HTTPS URL浏览到上面指定的服务器。在有关服务器具有无效证书的警告对话框中，选择将其导出到文件。

   要想在 **Google Chrome** 中访问，请点击地址栏中的"不安全（Not Secure）"按钮，选择"证书无效（Certificate is not valid）"，切换到证书浏览中的"细节（Details）"选项卡，然后选择"导出（Export）"。选择"Base-64编码ASCII（Base-64 Encoded ASCII）"作为文件类型，然后保存文件。

   也可以直接从证书管理器MMC管理单元导出证书。
2. 在Windows资源管理器中找到导出的证书文件，右键单击，然后选择"安装证书（Install Certificate）"。出现提示时，选择将证书导入"受信任的根证书（Trusted Root Certificates）"存储区。
