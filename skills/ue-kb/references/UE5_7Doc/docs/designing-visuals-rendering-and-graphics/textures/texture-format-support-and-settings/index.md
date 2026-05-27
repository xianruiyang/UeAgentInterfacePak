---
title: "支持的纹理格式和设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/texture-format-support-and-settings-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "纹理", "支持的纹理格式和设置"]
---

# 支持的纹理格式和设置

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 纹理 / 支持的纹理格式和设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/texture-format-support-and-settings-in-unreal-engine

在任何数字项目内存占用比例中，最大的一个内存占用来源是所用的纹理大小和数量。幸运的是，虚幻引擎 拥有非常可靠的系统，能够以非破坏性方式减小所有项目纹理的纹理大小。在以下页面中，我们将介绍这些系统，以及如何使用它们来降低项目纹理内存要求。

## 纹理分辨率

虚幻引擎支持1x1到8192x8192的纹理分辨率，只需要对.INI文件进行少许修改。最新的DirectX视频适配器和游戏主机支持1x1到2048x2048的各种纹理分辨率，最高可达8192x8192。特定硬件设备支持的最高纹理分辨率因制造商、型号和可用纹理内存而异。虚幻引擎4中有一些功能和设置，用于管理针对各种区域渲染的纹理分辨率，如场景几何结构或用户界面。

## 引擎纹理分辨率限制

虚幻引擎4默认将最大纹理mip数量限制为14，这样有效地将最大渲染纹理限制为8192（1x1到8192x8192为14个mip）。 这有一种副作用，即导入的8192纹理将仅渲染4096中的mip1。恒定值MAX_TEXTURE_MIP_COUNT在引擎源文件中默认为13，可以修改为值14以支持8192纹理渲染。该恒定值在以下源文件中定义（截至QAMar09，确保在其他QA版本上验证）。

```
	Src\D3D10Drv\Src\D3D10Device.cpp   	Src\Engine\Inc\RHI.h   	Src\Engine\Inc\UnTex.h   	Src\Engine\Src\RHI.cpp   	Src\Engine\Src\TextureCube.cpp
```

从发布UE 4.8开始，您现在可以修改项目以使用高达8192的大小，而不必修改C++代码，只需在项目的 **BaseDeviceProfiles.ini** 文件中添加以下文本并将 **MaxLODsize** 设置为 **8192** 即可

```
    [/Script/Engine.TextureLODSettings]    TextureLODGroup_World=(MinLODSize=1,MaxLODSize=8192,LODBias=0,MinMagFilter=aniso,MipFilter=point)
```

添加了想要增加其大小的分段后，保存文件并重新启动编辑器。编辑器重新启动后，以8192大小导入的任何纹理现在应该在LOD 1显示大小8192，而不是限制在最大值4096以内。在以下示例图像中，我们修改了UE 4.8项目中的BaseDeviceProfiles.ini文件，以允许使用大小高达8192的纹理。在UE4中加载纹理Texture_8k_Test时，我们可以看到导入和显示的纹理大小均为8192。

![TextureLOD_8k.png](../../../../assets/images/94/94772649ffa37e7f70407b91b1f2e3701d6445ed00335b55666ede35939a54f1.png)

点击查看全图

## 压缩的纹理内存要求

DXT使用有损压缩，通过调色板颜色和插值颜色将像素压缩在4x4的块中。这样会产生8:1 DXT1和4:1 DXT5恒定压缩文件大小。由于特定平台和硬件的视频内存和纹理池资源是固定的，因此纹理分辨率和资源使用必须达到平衡。下表列出了各种常见分辨率和完全mip下，DXT1和DXT5的纹理内存要求（1x1到完全原生mip0）。请注意，内存要求几乎是纹理分辨率比例的倍数不变，DXT5纹理对内存的占用几乎是DXT1的两倍。

由于分辨率与压缩的比值是常量，为了计算本文未列出的纹理的内存要求，只需乘以分辨率比例即可。例如，1024x512纹理的内存要求是1024x1024纹理的一半。

下表数据是根据使用箱式过滤器mip生成和DirectX纹理压缩，由ATI的Compressonator创建的纹理编译的。

| 分辨率 | 来自1x1的总Mip | DXT1 | DXT5 |
| --- | --- | --- | --- |
| **16x16** | 5个mip | 312字节 | 496字节 |
| **32x32** | 6个mip | 824字节 | 1.48kb（1,520字节） |
| **64x64** | 7个mip | 2.80kb（2,872字节） | 5.48kb（5,616字节） |
| **128x128** | 8个mip | 10.8kb（11,064字节） | 21.4kb（22,000字节） |
| **256x256** | 9个mip | 42.8kb（43,832字节） | 85.4kb（87,536字节） |
| **512x512** | 10个mip | 170kb（174,904字节） | 341kb（349,680字节） |
| **1024x1024** | 11个mip | 682kb（699,192字节） | 1.33MB（1,398,256字节） |
| **2048x2048** | 12个mip | 2.66MB（2,796,344字节） | 5.33MB（5,592,560字节） |
| **4096x4096** | 13个mip | 10.6MB（11,184,952字节） | 21.3MB（22,369,776字节） |
| **8192x8192** | 14个mip | 42.6MB（44,739,384字节） | 85.3MB（89,478,640字节） |

## 引擎配置TextureGroup属性

特定游戏的TextureGroup支持的最低和最高LOD（mip）在多个引擎配置文件中定义。 源配置设置文件组位于`[虚幻引擎4安装位置]\Engine\Config\BaseDeviceProfiles.ini` 文件的[/Scripts/Engine.TextureLODSettings]分段中。

为开发游戏，`[your_game]\Config\DefaultDeviceProfiles.ini` 文件还在 `Engine\Config\` 文件夹中包含一组镜像基础文件，这应当是通常根据游戏特定设置进行修改的副本。

需要注意的是，虚幻编辑器和游戏中拥有一组独立的TextureGroup条目。这两组分别位于配置文件的[SystemSettingsEditor]和[SystemSettings]分段中。

`DefaultDeviceProfiles.ini` 文件中的TextureLODGroup设置条目类与此类似。请注意，较早QA版本可能不包含各个设置的MinMagFilter和MipFilter属性。

```
    [/Script/Engine.TextureLODSettings]    ; 请注意，该分段中的任何项目会影响所有平台！！！    @TextureLODGroups=Group    TextureLODGroups=(Group=TEXTUREGROUP_World,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_WorldNormalMap,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_WorldSpecular,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Character,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_CharacterNormalMap,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_CharacterSpecular,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Weapon,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_WeaponNormalMap,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_WeaponSpecular,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Vehicle,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_VehicleNormalMap,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_VehicleSpecular,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Cinematic,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Effects,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=linear,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_EffectsNotFiltered,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Skybox,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_UI,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Lightmap,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Shadowmap,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,NumStreamedMips=3,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_RenderTarget,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_MobileFlattened,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Terrain_Heightmap,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Terrain_Weightmap,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Bokeh,MinLODSize=1,MaxLODSize=256,LODBias=0,MinMagFilter=linear,MipFilter=linear,MipGenSettings=TMGS_SimpleAverage)    +TextureLODGroups=(Group=TEXTUREGROUP_Pixels2D,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=point,MipFilter=point,MipGenSettings=TMGS_SimpleAverage)
```

## PC AppCompat桶

AppCompat用于根据目标和启动时收集的经验证据来覆盖各种SystemSettings。启用应用兼容性（仅限PC）时，系统衡量机器能力，然后使用五个"桶"中的其中一个桶的预设值来覆盖Engine.ini值。请参阅`Engine\Config\`文件夹中的BaseCompat.ini以了解相关用法示例。

AppCompat应该仅在首次运行游戏（而不是编辑器）时检查一次。它通过在[game]Engine.ini中检查是否存在[AppCompat]分段来进行检测，这个分段包含机器先前计算的分数。如果AppCompat已经应用过一次，则不会再次更改以允许用户每次在不进行覆盖的情况下进行自定义更改。

AppCompat专门针对编辑器禁用，这样机器规格不会影响开发期间在各种机器上查看资源的方式。因此，SystemSettings和SystemSettingsEditor才需要区分开来。

您可以有效地禁用AppCompat，方法是为游戏提供空的DefaultCompat.ini，使其从Engine.ini中的[SystemSettings]初始化所有桶。在此情况下，系统完全按照引入AppCompat之前的状态运行。

## TEXTUREGROUP属性

每个TextureGroup条目为游戏渲染中使用的特定纹理集定义纹理属性。通过将纹理分组为常用集，可以更好地控制各种游戏纹理资源的纹理内存池使用。

| 属性 | 说明 |
| --- | --- |
| **MinLODSize** | 将渲染的最小mip大小，以像素为单位指定，范围1到8192中的2的幂值，必须小于MaxLODSize。 |
| **MaxLODSize** | 将渲染的最大mip大小，以像素为单位指定，范围1到8192中的2的幂值，必须大于MinLODSize。 |
| **LODBias** | 一个负值或正值，用于在加载以便渲染前确定要偏移的mip级别数量，限制在MinLODSize和MaxLODSize范围内。 |
| **MinMagFilter** | 指定GPU缩小或放大纹理时的纹理过滤器类型。请参阅下面的图表。 |
| **MipFilter** | 指定从远处或切线角查看纹理时，GPU是否应当混合两个mip。请参阅下面的图表。 |
| **NumStreamedMips** | 允许流送输入或输出的mip数量。如果纹理有10个mip，NumStreamedMips是2，则只允许流送输入或输出2个最高的mip。因此，纹理在任何给定时间，内存中都有8-10个mip。将NumStreamedMips设置为0意味着不流送任何mip，使用该LOD组的纹理始终完全加载。将NumStreamedMips设置为-1意味着允许流送输入或输出所有mip（但仍有一些其他限制）。NumStreamedMips是一个可选设置，默认值是-1。 |

### 过滤

| MinMagFilter | MipFilter | 过滤类型 |
| --- | --- | --- |
| **点** |  | 点 |
| **线性** | 点 | 双线性 |
| **线性** |  | 三线性 |
| **各向异性** | 点 | 各向异性点 |
| **各向异性** |  | 各向异性线性 |

## TextureGroup、LODGroup和LODBias

配置ini文件中指定的TextureGroup和LODBias设置以及纹理属性中指定的LODGroup和LODBias设置确定了用于单个纹理的最终纹理mip集。

[your_game]Engine.ini中的示例TextureGroup条目可能类似于：

```
    Group=TEXTUREGROUP_World,MinLODSize=1,MaxLODSize=4096,LODBias=0,MinMagFilter=aniso,MipFilter=point,MipGenSettings=TMGS_SimpleAverage
```

分配给TEXTUREGROUP_World LODGroup的任何纹理都将使用这些设置来确定用于渲染的mip范围。 纹理属性中的其他LODBias设置都是在配置ini文件TextureGroup中指定的LODBias上累加的。

LODBias对选择哪个mip进行渲染进行 *偏差* 或偏移调整。LODBias先于LODGroup Min/Max范围计算。纹理属性中的LODBias添加到TextureGroup中的LODBias，以确定使用的最终LODBias值。 LODBias 0是主要（原生）纹理分辨率。LODBias 1是纹理的下一个mip，LODBias 2的下两个mip，以此类推。例如，LODBias为1的1024x1024纹理将选择512x512 mip进行渲染。

针对每个纹理，在纹理属性中指定的LODBias可以是正数或负数，因此可以向上或向下调整TextureGroup默认LODBias的mip值。 例如：

- TextureGroup LODBias为0，纹理属性LODBias为0将产生最终LODBias 0。
- TextureGroup LODBias为0，纹理属性LODBias为1将产生最终LODBias 1。
- TextureGroup LODBias为1，纹理属性LODBias为1将产生最终LODBias 2。
- TextureGroup LODBias为1，纹理属性LODBias为-1将产生最终LODBias 0。

在计算最终LODBias后，将检查纹理mip以确认它是否在TextureGroup的最小/最大LODSize范围内，并且在需要时进行调整。这允许对配置ini文件进行简单更改，以有效地将特定TextureGroup限制在设定的最小/最大LOD范围内。

例如，如果按照如上所示在TEXTUREGROUP_World LODGroup中进行设置，LODBias为1的1024x1024纹理将使用512x512 mip，然后它将被检查以确认是否在TextureGroup的最小和最大LODSize范围内，在本例中为256和1024。由于每个游戏都有自己独特的TextureGroup设置，美术和关卡设计师应知道每个组的MinLODSize和MaxLODSize。如果将2048纹理分配给MaxLODSize为1024的TextureGroup，则发布这样的游戏时，会增大可分发数据包大小，同时也对渲染无益。

## 纹理属性

关于各种纹理属性的含义说明，请参阅纹理属性页面。
