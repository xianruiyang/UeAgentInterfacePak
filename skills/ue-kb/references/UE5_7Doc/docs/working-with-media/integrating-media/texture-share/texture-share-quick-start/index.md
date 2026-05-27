---
title: "纹理共享快速入门"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/texture-share-quick-start-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "使用媒体", "媒体集成", "纹理共享", "纹理共享快速入门"]
---

# 纹理共享快速入门

> 路径：虚幻引擎5.7文档 / 使用媒体 / 媒体集成 / 纹理共享 / 纹理共享快速入门

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/texture-share-quick-start-for-unreal-engine

阅读完本指南，你将熟悉以下操作：

- 从源构建纹理共享SDK。
- 将C++ SDK与DirectX11和DirectX12应用程序集成。
- 使用虚幻引擎插件和蓝图。
- 将项目在虚幻中的已渲染视口发送到外部应用程序。
- 在虚幻会话期间，向/从外部应用程序发送/接收纹理。

## 步骤1 - 开始使用SDK

为了使用纹理共享SDK，你必须从源下载和构建引擎。欲了解如何查找引擎源代码，请参阅[下载虚幻引擎源代码](https://dev.epicgames.com/documentation/404)。

> [!NOTE]
> 在Visual Studio中构建引擎，默认情况下不会构建TextureShareSDK项目。

按以下步骤构建纹理共享SDK：

1. 在Visual Studio中打开 `Ue4.sln` 文件。
2. 在 **解决方案浏览器（Solution Explorer）** 面板中，导航至 **程序（Programs）> TextureShare**。右键点击 **TextureShareSDK** 项目并构建它。
3. 项目完成构建时，会在文件夹 **Engine\Binaries\Win64\TextureShareSDK** 中生成 `.lib` 和 `.dll` 文件。

### C++ SDK集成

纹理共享API提供对纹理共享过程的粒度控制。

要使用纹理共享，你必须在交换各方之间建立会话，然后才能执行任何读写操作。流程的每个步骤都提供了对各种同步状态的控制，你可以为项目定制这些同步状态。

使用纹理共享API的C++应用程序符合以下结构：

1. 客户端应用程序通过指定纹理共享对象的名称来创建该对象。
2. 纹理被注册到可以容纳多个纹理的纹理共享对象，并且纹理会话会启动。
3. 可以在各个帧上写入数据并发送到其他应用程序，或在各个帧上读取数据。执行读写操作之前必须锁定数据缓冲区，完成后再解锁。
4. 对每帧执行步骤3，直至会话结束。

以下章节显示纹理共享API在DirectX12示例项目 `TextureShareD3D12Client.vcxproj` 中的使用方式，该项目位于 **Engine/Source/Programs/TextureShare/Samples/ThirdParty/TextureShare_ClientD3D12** 中。

> [!NOTE]
> 此例使用DirectX12，但流程与DirectX11相同。只需稍作修改，**ThirdParty** 中的DirectX11示例项目也可套用此流程。

#### Include文件

- 包括标头文件 `TextureShareD3D12Client.h` 和 `TextureShareDLL.h`。
- 使用[pragma注释](https://docs.microsoft.com/en-us/cpp/preprocessor/comment-c-cpp?view=msvc-160)连接静态库文件。如果在Visual Studio中使用 **发布（Release）** 配置进行构建，则使用 `TextureShareSDK.lib`，如果使用 **调试（Debug）** 配置进行构建，则使用 `TextureShareSDK-Win64-Debug.lib`。

  ```
            #include "TextureShareD3D12Client.h"          #include "TextureShareDLL.h"          #ifdef _DEBUG          #pragma comment( lib, "TextureShareSDK-Win64-Debug.lib" )          #else          #pragma comment( lib, "TextureShareSDK.lib" )          #endif		
  ```

#### 初始化

以下步骤介绍了C++中要初始化的内容以及启动纹理共享会话的方式。

1. 使用DirectX API加载渲染管线和资产：

   1. 创建[DirectX设备](https://docs.microsoft.com/en-us/windows/win32/api/d3d12/nf-d3d12-d3d12createdevice)。
   2. 创建[GraphicsCommandList](https://docs.microsoft.com/en-us/windows/win32/api/d3d12/nn-d3d12-id3d12graphicscommandlist)。

   相关示例详见 `D3D12HelloTexture::LoadPipeline()` 和 `D3D12HelloTexture::LoadAssets()`。
2. 创建纹理共享项：

   1. 设置共享名称。最大长度为128个字符。
   2. 使用 `ETextureShareProcess::Client` 将应用程序设为客户端。
   3. 为纹理共享会话定义同步策略。详见同步策略。本例中，所有同步策略都设为 **无（None）**，因此同步事件都将是非阻塞性的。
   4. 指定要使用的图形API。目前仅支持DirectX11和DirectX12。

      ```
           FTextureShareSyncPolicy DefaultSyncPolicy;     DefaultSyncPolicy.ConnectionSync = ETextureShareSyncConnect::None;     DefaultSyncPolicy.FrameSync = ETextureShareSyncFrame::None;     DefaultSyncPolicy.TextureSync = ETextureShareSyncSurface::None;     FTextureShareInterface::CreateTextureShare(ShareName.c_str(), ETextureShareProcess::Client, DefaultSyncPolicy, ETextureShareDevice::D3D12);		
      ```
3. 将纹理注册到纹理共享项：

   1. 设置会话的共享名称。
   2. 设置纹理名称。
   3. 设置纹理分辨率。

   10.定义纹理格式和值。

   11.设置纹理是可读取还是可写入。

   ```
            ETextureShareFormat ShareFormat = ETextureShareFormat::Undefined;         uint32 ShareFormatValue = 0;         // 使用客户端纹理格式：         if (InFormat != DXGI_FORMAT_UNKNOWN)         {             ShareFormat = ETextureShareFormat::Format_DXGI;             ShareFormatValue = InFormat;         }         FTextureShareInterface::RegisterTexture(ShareName.c_str(), TextureName.c_str(), Width, Height, ShareFormat, ShareFormatValue, TextureOp); 
   ```
4. 定义纹理共享会话的作用域的开头：

   ```
            FTextureShareInterface::BeginSession(ShareName.c_str());		
   ```

#### 渲染线程

以下步骤介绍如何在渲染线程中访问共享内存。这些步骤显示如何使用读写操作。

1. 定义纹理共享会话中帧作用域的开头：

   ```
            FTextureShareInterface::BeginFrame_RenderThread(ShareName.c_str());		
   ```
2. 读取渲染线程中的纹理：

   1. 在纹理上加个锁。
   2. 访问纹理内存。
   3. 释放纹理上的锁。

      ```
           if (FTextureShareInterface::IsValid(ShareName.c_str()))     {         ID3D12Resource* SharedResource;         if (FTextureShareInterface::LockTextureD3D12_RenderThread(pD3D12Device, ShareName.c_str(), TextureName.c_str(), SharedResource))         {             if (!FTextureShareD3D12Helper::IsTexturesEqual(SharedResource, *InOutSRVTexture))             {                 // 共享纹理大小在服务器端发生更改。移除临时纹理，重新创建新的tempTexture                 ReleaseTextureAndSRV(InOutSRVTexture);             }             if (!*InOutSRVTexture)             {                 // 创建临时texture&srv                 FTextureShareD3D12Helper::CreateSRVTexture(pD3D12Device, pD3D12HeapSRV, SharedResource, InOutSRVTexture, SRVIndex);             }             // 从共享复制到临时：             if (*InOutSRVTexture)             {                 FTextureShareD3D12Helper::CopyResource(pCmdList, SharedResource, *InOutSRVTexture);             }             // 解锁共享资源             FTextureShareInterface::UnlockTexture_RenderThread(ShareName.c_str(), TextureName.c_str());         }         else         {             // 释放未使用的纹理（断开连接用途）             ReleaseTextureAndSRV(InOutSRVTexture);         }     }		
      ```
3. 写入到渲染线程中的纹理：

   1. 检查会话是否有效。
   2. 在纹理上加个锁。
   3. 访问内存。
   4. 释放纹理上的锁。

      ```
           if (FTextureShareInterface::IsValid(ShareName.c_str()))     {         ID3D12Resource* SharedResource;         if (FTextureShareInterface::LockTextureD3D12_RenderThread(pD3D12Device, ShareName.c_str(), TextureName.c_str(), SharedResource))         {                 FTextureShareD3D12Helper::CopyResource(pCmdList, InTexture, SharedResource);                 FTextureShareInterface::UnlockTexture_RenderThread(ShareName.c_str(), TextureName.c_str());         }     }		
      ```
4. 获取帧数据以访问辅助缓冲区中的信息，如投影和摄像机矩阵：

   ```
            FTextureShareSDKAdditionalData* OutFrameData;         FTextureShareInterface::GetRemoteAdditionalData(ShareName.c_str(), *OutFrameData);		
   ```
5. 定义纹理共享会话中帧作用域的结尾：

   ```
            FTextureShareInterface::EndFrame_RenderThread(ShareName.c_str());		
   ```
6. 呈示要显示的帧。

#### 清理

以下步骤介绍如何在应用程序退出时终止纹理共享会话。

1. 定义纹理共享会话的作用域的结尾：

   ```
            FTextureShareInterface::EndSession(ShareName.c_str());		
   ```
2. 删除纹理共享项并释放内存：

   ```
            FTextureShareInterface::ReleaseTextureShare(ShareName.c_str());		
   ```

## 步骤2 - 开始在虚幻中使用

按以下步骤使用纹理共享插件，以及在虚幻引擎中访问纹理共享蓝图。

1. 在编辑器的主菜单中，选择 **编辑（Edit） > 插件（Plugins）** 以打开 **插件编辑器（Plugins Editor）**。
2. 在插件编辑器中，在 **杂项（Misc）** 部分中找到 **纹理共享（Texture Share）** 插件。
3. 选中 **已启用（Enabled）** 复选框，并重启编辑器。
4. 在 **内容浏览器** 中，展开面板右下侧的 **视图选项（View Options）** 下拉菜单。选中 **显示引擎内容（Show Engine Content）** 和 **显示插件内容（Show Plugin Content）**。
5. 点击 **内容浏览器** 顶部的文件夹图标，以选择一个内容路径。在列表中找到 **TextureShare内容** 并选中它。
6. 在 **蓝图（Blueprints）** 文件夹中，有两个蓝图对象可以直接添加到你的场景中：

   - **BP_TextureShare_Scene**：此蓝图共享整个虚幻场景的已渲染帧。
   - **BP_TextureShare_Postprocess**：此蓝图发送和接收特定的 **纹理（Texture）** 对象。
7. **材质（Materials）** 文件夹中的纹理和材质可与 **BP_TextureShare_Postprocess** 蓝图配合使用。

   - **RTT_TextureShare_Backbuffer**：一种 **纹理渲染目标2D** 资产。
   - **M_TextureShare_RTTBackbuffer**：一种材质，对 **RTT_TextureShare_Backbuffer** 纹理进行采样并将其用作 **自发光颜色**。

此快速入门中的其余步骤介绍如何使用各个蓝图并将它们连接到其他DirectX应用程序。

## 步骤3 - 将虚幻场景作为纹理发送到DirectX应用程序

按以下步骤将虚幻场景流送到外部DirectX应用程序。

1. 导航至文件夹 **Engine/Source/Programs/TextureShare/Samples/ThirdParty/TextureShare_ClientD3D11**，并在Visual Studio中打开示例项目 `TextureShareD3D11Client.vcxproj`。
2. 在Visual Studio中将 **解决方案配置（Solution Configuration）** 设置为 **发布（Release）****。**
3. 在Visual Studio中构建项目。
4. 导航至文件夹 **Engine\Source\Programs\TextureShare\Samples\ThirdParty\TextureShare_ClientD3D11\Binaries\TextureShareD3D11Client-Win64-Release** 并启动 `TextureShareD3D11Client.exe` 应用程序。
5. 在虚幻引擎中打开你的虚幻项目，将蓝图 **BP_TextureShare_Scene** 对象添加到你的场景。
6. 选择 **BP_TextureShare_Scene** 对象以打开其 **细节（Details）** 面板。
7. 确保 **共享名称（Share Name）** 参数设置为与示例项目中的 **ShareName** 变量相同的名称，即 **vp_1**。
8. 按虚幻中的 **播放（Play）**。虚幻场景中已渲染的帧作为纹理流送到客户端应用程序并应用于旋转立方体。

## 步骤4 - 将纹理发送到外部DirectX应用程序

上一个步骤介绍如何在单独的流程中将虚幻场景作为纹理进行共享。也可将项目中的任何纹理对象发送到外部应用程序。

按以下步骤将你的虚幻项目中的任何纹理对象分享到DirectX示例应用程序。

1. 导航至文件夹 **Engine\Source\Programs\TextureShare\Samples\ThirdParty\TextureShare_ClientD3D12**，并在Visual Studio中打开示例项目 `TextureShareD3D12Client.vcxproj`。
2. 将 **解决方案配置（Solution Configuration）** 设置为 **发布（Release）**。
3. 构建项目。
4. 导航至文件夹 **Engine\Source\Programs\TextureShare\Samples\ThirdParty\TextureShare_ClientD3D12\Binaries\TextureShareD3D12Client-Win64-Release** 并启动项目构建的可执行文件，即 `TextureShareD3D12Client.exe`。
5. 在虚幻引擎中打开你的虚幻项目，将蓝图 **BP_TextureShare_Postprocess** 对象添加到你的场景。
6. 选择添加到场景中的 **BP_TextureShare_Postprocess** 对象，打开其 **细节（Details）** 面板。
7. 展开 **后期处理（Postprocess）** 分段。
8. 展开 **后期处理（Postprocess）** 部分下的 **发送（Send）** 部分。有两个发送数组元素。Id必须对应示例项目中 `D3D12HelloTexture.cpp` 文件中定义的纹理名称：

   ```
            // 定义共享和纹理名称         std::wstring ShareName1 = L"vp_1";         std::wstring ReceiveTextureNames[] = { L"SceneDepth" , L"BackBuffer" };		
   ```

   1. 将第一个 **发送（Send）** 元素的 **Id** 设置为 **SceneDepth**。
   2. 将第二个 **发送（Send）** 元素的 **Id** 设置为 **BackBuffer**。
9. 在 **虚幻编辑器** 中按 **播放（Play）**。

10.使用纹理对象更新两个 **发送（Send）** 元素的 **纹理（Texture）** 参数。引擎将纹理流送到客户端应用程序并将它们应用于已渲染的三角形。

## 步骤5 - 从DirectX应用程序接收纹理并在虚幻中显示它们

上一个步骤介绍如何将纹理发送到外部DirectX应用程序。本节介绍如何从另一个应用程序接收纹理。

按以下步骤从DirectX示例应用程序接收纹理。

1. 导航至文件夹 **Engine\Source\Programs\TextureShare\Samples\ThirdParty\TextureShare_ClientD3D12**，并在Visual Studio中打开示例项目 `TextureShareD3D12Client.vcxproj`。
2. 将 **解决方案配置（Solution Configuration）** 设置为 **发布（Release）**。
3. 构建项目。
4. 导航至文件夹 **Engine\Source\Programs\TextureShare\Samples\ThirdParty\TextureShare_ClientD3D12\Binaries\TextureShareD3D12Client-Win64-Release** 并启动项目构建的可执行文件，即 `TextureShareD3D12Client.exe`。
5. 在虚幻引擎中打开你的虚幻项目，将蓝图 **BP_TextureShare_Postprocess** 对象添加到你的场景。
6. 选择添加到场景中的 **BP_TextureShare_Postprocess** 对象，打开其 **细节（Details）** 面板。
7. 在 **默认（Default）** 下的 **细节（Details）** 面板中，展开 **后期处理（Postprocess）** 部分。
8. 展开 **后期处理（Postprocess）** 部分下的 **接收（Receive）** 部分。有一个 **接收（Receive）** 数组元素。此元素的 **Id** 必须对应示例项目中 `D3D12HelloTexture.cpp` 文件中定义的纹理名称：

   ```
        // 定义共享和纹理名称     std::wstring ShareName1 = L"vp_1";     std::wstring SendBackbufferTextureName = L"InBackbuffer";
   ```
9. 将 **接收（Receive）** 元素的 **RTT** 参数设置为 **TextureShare** 插件中提供的 **RTT_TextureShare_Backbuffer**。

现在已设置你的虚幻项目使用TextureShare从另一个应用程序接收纹理。

下例中启动了虚幻引擎会话。虚幻正在将一个纹理发送到 **TextureShareD3D12Client** 应用程序，并从该应用程序接收后置缓冲。场景中墙上的照片使用的是采样自 **RTT_TextureShare_Backbuffer** 纹理的材质，以实时显示接收的内容。
