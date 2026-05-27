# LWC - “真正高”精度旋转（续 2）

# LWC - “真正高”精度旋转（续 2）

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/3JZ6/unreal-engine-lwc-really-high-precision-rotations
- 原始文件：unreal-engine-lwc-really-high-precision-rotations.origin.md
- 分段：第 2/2 段

如果您不想将此特定设置应用于所有项目，或者希望团队的每个成员都拥有它，则可以在项目级别执行此操作。但这个 ini 文件与您在 [Project]\Config 文件夹中找到的典型文件不同。解决方案是直接在项目的根目录复制平台配置文件夹层次结构，并将 DataDrivenPlatformInfo.ini 文件复制到那里。它将覆盖引擎的默认设置。确保您： - 对要覆盖设置的每个平台执行此操作 对要覆盖设置的每个平台执行此操作 - 将此文件夹置于版本控制下以与您的团队共享 将此文件夹置于版本控制下以与您的团队共享 - 添加您想要的适当的 bSupportsSceneDataCompressedTransforms=false 行 添加您想要的适当的 bSupportsSceneDataCompressedTransforms=false 行 请务必注意，此文件完全替换引擎提供的文件。当迁移到较新的引擎版本或从源代码构建时，您必须根据我们将发布的最新版本检查此文件。它可能已经改变了！使用编辑器时，项目级别的此设置很有用，但在打包应用程序时不会考虑它。结果，由于着色器不匹配，您会看到一大堆跳舞的三角形。确保在引擎级别启用此设置的计算机上构建、烹饪和打包！

### 结论

双精度/大世界坐标的使用改变了 UE5 的游戏规则。从工程角度来看，这是一个非常重要且复杂的变化。为了充分利用它，您必须了解这些实现细节，以确保正确覆盖您的用例。 - 物理 - 渲染 - 模拟

## 相关链接

- [IEEE-754 Floating Point](https://www.h-schmidt.net/FloatConverter/IEEE754.html)
- [Introduction](https://dev.epicgames.com/community/learning/tutorials/3JZ6/unreal-engine-lwc-really-high-precision-rotations#introduction)
- [Technical rationale](https://dev.epicgames.com/community/learning/tutorials/3JZ6/unreal-engine-lwc-really-high-precision-rotations#technicalrationale)
- [Illustration](https://dev.epicgames.com/community/learning/tutorials/3JZ6/unreal-engine-lwc-really-high-precision-rotations#illustration)
- [Disabling the Transformation Compressions](https://dev.epicgames.com/community/learning/tutorials/3JZ6/unreal-engine-lwc-really-high-precision-rotations#disablingthetransformationcompressions)
- [At the Engine level](https://dev.epicgames.com/community/learning/tutorials/3JZ6/unreal-engine-lwc-really-high-precision-rotations#attheenginelevel)
- [At the project level](https://dev.epicgames.com/community/learning/tutorials/3JZ6/unreal-engine-lwc-really-high-precision-rotations#attheprojectlevel)
- [Conclusion](https://dev.epicgames.com/community/learning/tutorials/3JZ6/unreal-engine-lwc-really-high-precision-rotations#conclusion)

