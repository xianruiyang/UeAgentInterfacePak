# UE 到 Nuke ACES 视口颜色匹配

# UE 到 Nuke ACES 视口颜色匹配

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/dLpw/unreal-engine-ue-to-nuke-aces-viewport-color-matching

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 1740 字符。

## 摘要

遵循此工作流程将帮助您将 Nuke 查看器之间的颜色与您在 UE 查看器中看到的颜色（应用了色调曲线）进行匹配。

## 中文整理

### 概览

要理解本教程，您需要具备 OpenColorIO、影片渲染队列 (MRQ)、ACES 和 Nuke 的 UE 颜色管理方面的坚实基础。

有关详细信息，请参阅本教程底部的资源。

以下工作流程将帮助您将 Nuke 查看器中的颜色与您在 UE 查看器中看到的颜色相匹配 - 即使在 UE 中应用了色调曲线。

使用影片渲染队列渲染虚幻图像时，您需要渲染 EXR（16 位）序列，添加“颜色输出”设置，并选中“禁用色调曲线”标志。

无需启用或设置 OCIOConfiguration。

每当渲染 EXR 时，最好使用设置为“无限延伸（未绑定）”的关卡中的后期处理体积将“蓝色校正”、“扩展色域”和“色调曲线量”设置为 0.0。

顺便说一句，将“色调曲线数量”设置为 0.0 会禁用色调曲线 - 因此，如果您通过后期处理体积进行操作，则不一定需要在 MRQ 中使用颜色输出来禁用它。

将图像渲染到磁盘。

在 Nuke 中，您需要将以下 config.ocio 文件加载到“编辑”->“项目详细信息”->“颜色管理”->“默认 OCIO 配置”下的默认 OCIO 配置中： {Engine}/Plugins/Compositing/OpenColorIO/Content/OCIO/simple.config.ocio 重新启动 Nuke 以访问新的 OCIO 选项。

在 Nuke 查看器中，为查看器进程选择“UE (sRGB)”来查看图像：此工作流程应为您提供 Nuke 和 UE 查看器之间 cg 元素的匹配颜色： - 使用 OpenColorIO 进行颜色管理 - 电影渲染队列 - Academy 颜色编码系统 (ACES) - OpenColorIO-Configs | GitHub - OCIO 颜色管理 | Nuke - opencolorio - 线性内容创建技术指南

![显示 MRQ 预设中的颜色输出](assets/unreal-engine-ue-to-nuke-aces-viewport-color-matching-dlpw/image-01.jpg)


![MRQ 颜色输出中的 OCIO 配置](assets/unreal-engine-ue-to-nuke-aces-viewport-color-matching-dlpw/image-02.jpg)


![后期处理体积杂项设置](assets/unreal-engine-ue-to-nuke-aces-viewport-color-matching-dlpw/image-03.jpg)


![显示 Nuke 的viewerProcess 设置为“UE (sRGB)”](assets/unreal-engine-ue-to-nuke-aces-viewport-color-matching-dlpw/image-04.jpg)


![Nuke 和 UE 并排显示匹配的 Macbeth 图表](assets/unreal-engine-ue-to-nuke-aces-viewport-color-matching-dlpw/image-05.jpg)


## 相关链接

- [Color Management with OpenColorIO](https://docs.unrealengine.com/5.0/en-US/WorkingWithMedia/ManagingColor/OpenColorIO)
- [Movie Render Queue](https://docs.unrealengine.com/5.0/en-US)
- [Academy Color Encoding System (ACES)](https://oscars.org/science-technology/sci-tech-projects/aces)
- [OpenColorIO-Configs | GitHub](https://github.com/colour-science/OpenColorIO-Configs)
- [OCIO Color Management | Nuke](https://learn.foundry.com/nuke/content/comp_environment/configuring_nuke/using_ocio_config_files.html)
- [文档与教程](https://dev.epicgames.com/community/learning/tutorials/dLpw/unreal-engine-ue-to-nuke-aces-viewport-color-matching#%E6%96%87%E6%A1%A3%E4%B8%8E%E6%95%99%E7%A8%8B)
- [实用链接](https://dev.epicgames.com/community/learning/tutorials/dLpw/unreal-engine-ue-to-nuke-aces-viewport-color-matching#%E5%AE%9E%E7%94%A8%E9%93%BE%E6%8E%A5)


