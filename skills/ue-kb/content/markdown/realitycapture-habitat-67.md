# 在 RealityCapture 中处理 Habitat 67 样本

# 在 RealityCapture 中处理 Habitat 67 样本

### 导入激光扫描

现在我们可以导入我们将要处理的所有数据。让我们从激光扫描开始。 RealityCapture 支持有序 ptx、e57 和 zfs/zfprj 激光扫描文件格式。导入将激光扫描转换为带有 lsp 文件扩展名的内部格式。将激光扫描转换为 lsp 文件后，您可以像处理图像一样处理 lsp 文件。无需再次导入和转换激光扫描。如果您想更改导入设置，则只需重新导入激光扫描。在样本数据中，我们提供了原始的 e57 激光扫描以及已经转换的 lsp 激光扫描。如果您拥有 ENT 许可证，您可以使用原始 e57 激光扫描并生成您自己的 lsp 激光扫描。如果您使用 PPI 许可证，请使用随样本数据提供的预许可 .lsp 激光扫描。要导入激光扫描，请在文件资源管理器中选择所有激光扫描并将其拖放到 UI 中。或者，您可以使用导入**激光扫描**选项从**工作流程选项卡**导入它们。使用文件资源管理器导航到包含 e57 激光扫描的文件夹，选择所有文件夹并单击 **打开**。

![教程图片](assets/unreal-engine-realityscan-processing-of-the-habitat-67-sample-in-realitycapture/image-10.jpg)

将出现 **激光扫描导入** 对话框，其中包含我们需要更改的几个选项。在此导入对话框中，我们需要调整一些设置以更好地适应提供的激光扫描。扫描已在第 3 方软件中准确注册，我们不希望 RealityCapture 更改激光扫描之间的相对位置，因此我们将 **注册 **从 **未注册** 更改为 **精确。** 扫描是在局部坐标系中捕获的，我们希望保留此局部坐标系。我们希望所有图像都“移动”到局部坐标系中的激光扫描。因此，我们将 **Georeferenced** 选项更改为 **Yes**。 **坐标系**将设置为 **本地：1 - 欧几里德。** 如果您想要将激光扫描“移动”到地理参考图像或使用地面控制点对激光扫描进行地理参考，请将 **地理参考** 设置设置为 **否**。所有其他选项均在内置 RealityCapture 帮助中详细描述。要了解有关在 RealityCapture 中处理激光扫描的更多信息，请按键盘上的 **F1** 打开 **帮助** 并搜索 **“从激光扫描创建 3D 模型”**。调整后的导入对话框应如下所示。按 **确定** 继续导入。

### 导入图像

与激光扫描相同，可以将图像和包含图像的整个文件夹拖放到用户界面，或使用应用程序功能区的 **WORKFLOW** 选项卡中提供的 **添加图像选项 **。导入图像后，您可能会收到有关**不完整的相机传感器信息**的通知。不用担心，您可以按**更新**下载我们最新的传感器信息数据库。即使传感器信息不存在于我们的数据库中，RealityCapture 也可以实现成功的对齐。为了更好地了解项目结构，我们可以将 **2Ds** 视图更改为 **1Ds。 **单击按钮并从下拉列表中选择**1Ds**。如果所有图像和激光扫描均已正确导入，则该项目应包含 530 个输入。

### 结盟

现在，将所有数据导入到项目中，我们可以继续进行对齐。默认 RealityCapture 对齐设置最适合高达 24 兆像素的图像。用于扫描 Habitat 67 的图像有 45 兆像素，扫描条件并不理想。因此，我们将调整设置以帮助对齐。转到 **对齐** 选项卡，然后单击 ** 对齐设置** 按钮。 **对齐设置**面板将在屏幕左下角打开。在“对齐设置”中，我们将“每个 mpx 的最大特征”从“10 000”更改为“40 000”，将“每个图像的最大特征”从“40 000”更改为“80 000”，并将“图像重叠”从“中”设置为“低”。在“高级”设置中，我们将“预选器特征”从 1**0 000** 更改为 4**0 000**，并将扭曲模型更改为 **Brown 4 with tangential2**。较高的失真模型可以更准确地模拟失真，但计算时间可能会更长。此外，增加**最大功能数量**将对 RAM 提出更高的要求。近似内存消耗（以字节为单位）的公式为：images * max_features_per_image * 200。调整后的**对齐设置**应如下所示。您可以从 **Alignment** 选项卡启动对齐或使用键盘快捷键 **F6**。整个过程是自动的，不需要任何交互。几分钟后，根据计算机的硬件规格，对齐结果将显示在 3D 视口中。检测到的和匹配的特征表示为点云，小金字塔形状表示相机位置。

### 设置重建区域

现在是时候建立重建区域了。重建区域可以限制网格重建的感兴趣区域。默认情况下，RealityCapture 将根据对齐自动设置重建区域。要调整重建区域，单击它，将出现重建区域小部件。我们可以用它来调整区域。您可以使用中央小部件平移和旋转它，或使用圆圈移动该区域的各个侧面。我们建议使用正交视图调整区域。可以从 **SCENE 3D VIEW** 选项卡更改视图，也可以使用数字键盘上的数字键在视图之间切换。 - 0 - 透视图 - 1 - 正交视图 - 2 - 顶部正交视图 - 3 - 底部正交视图 - 4 - 左侧正交视图 - 5 - 右侧正交视图 - 6 - 正面正交视图 - 7 - 背面正交视图

### 网格重建

设置区域后我们就可以开始网格的重建。转到 **MESH MODE**L 选项卡并在 **NormalDetail** 中开始重建。快捷键是**F7**。正常的细节重建将使用源图像的缩小版本。默认情况下，正常细节重建的图像缩小比例设置为 2，这将使原始图像的每一侧减半，因此 RC 会将图像缩小到原始比例的 25%。高细节重建将使用全分辨率的原始图像，网格将具有更多细节，但代价是更长的计算时间。网格计算后，您可能会收到以下消息。该消息指出该模型是...

### 简化

### 纹理化

### 进一步简化和纹理重投影

### 出口

## 相关链接

- [Hillside landing page](https://unrealengine.com/en-US/hillside)
- [Hillside on the Google Cloud Pixel Streaming Platform](https://experience.hillside.gorillastreaming.com)
- [Download RealityCapture](https://capturingreality.com/DownloadNow)
- [Habitat67SampleTutorial.zip](https://capturingreality.com/download/files/Habitat67SampleTutorial)
- [Processing of the Habitat 67 Scan Data with the 3D Divider Script](https://dev.epicgames.com/community/learning/tutorials/Yabm/unreal-engine-capturing-reality-processing-of-the-habitat-67-scan-data-with-the-3d-divider-script)
- [Habitat 67: Unpacked](https://dev.epicgames.com/community/learning/courses/6p3/unreal-engine-habitat67-unpacked/5PEK/unreal-engine-capturing-reality-habitat-67-unpacked-overview)

