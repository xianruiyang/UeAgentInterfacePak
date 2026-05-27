# Paper2D - 导入设置

---
title: "Paper2D - 导入设置"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/paper2d-import-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "Editor", "Paper2D - 导入设置"]
---

# Paper2D - 导入设置

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / Editor / Paper2D - 导入设置

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/paper2d-import-settings-in-the-unreal-engine-project-settings

## Paper2D - 导入

#### 新资产设置

| **分段** | **说明** |
| --- | --- |
| **创建Sprite时挑选最佳材质（Pick Best Material when Creating Sprites）** | 定义在创建新Sprite时，是否应扫描源纹理，以确定合适的材质。 如果为false，将总是使用默认遮罩材质。 |
| **创建图块贴图时挑选最佳材质（Pick Best Material when Creating Tile Maps）** | 定义在创建新图块贴图（从图块集或通过导入创建）时，是否应扫描源纹理，以确定合适的材质。 如果为false，将总是使用默认遮罩材质。 |
| **分析可以使用不透明（Analysis Can Use Opaque）** | 定义是否可以在"最佳材质"分析过程中应用不透明材质。 |
| **每个虚幻单位的默认像素数（Default Pixels Per Unreal Unit）** | 要用于新建Sprite资产的像素和虚幻单位（cm）之间的默认比例因子（例如，使用0.64时，64像素宽的Sprite将占用100cm）。 |

### 导入设置

| **分段** | **说明** |
| --- | --- |
| **法线贴图纹理后缀（Normal Map Texture Suffixes）** | 在导入Sprite或根据纹理创建Sprite时，查找关联法线贴图时要使用的默认后缀列表。 |
| **基础贴图纹理后缀（Base Map Texture Suffixes）** | 在使用 `NormalMapTextureSuffixes` 查找关联法线贴图之前，要从纹理名称删除的默认后缀（如有）。 |
| **默认Sprite纹理组（Default Sprite Texture Group）** | 导入的Sprite纹理、图块表等的默认纹理组。 通常针对"现代2D（modern 2D）"设置为"UI"选项，针对"复古2D（retro 2D）"设置为"2D像素（2D pixels）"选项。 |
| **覆盖纹理压缩（Override Texture Compression）** | 定义是否应该覆盖导入的Sprite纹理、图块表等上的纹理压缩设置。 |
| **默认Sprite纹理压缩（Default Sprite Texture Compression）** | 构建纹理时要使用的压缩设置。 导入的Sprite纹理、图块表等的默认纹理组。 通常针对"现代2D（modern 2D）"设置为"UI"选项，针对"复古2D（retro 2D）"设置为"2D像素（2D pixels）"选项。 你可以选择以下选项： **默认（Default (DXT1/5, BC1/3 on DX11)）** **法线贴图（Normalmap (DXT5, BC5 on DX11)）** **遮罩（无sRGB）（Masks (no sRGB)）** **灰阶（Grayscale (R8, RGB8 sRGB)）** **置换贴图（8/16位）（Displacementmap (8/16bit)）** **向量置换贴图（VectorDisplacementmap (RGBA8)）** **HDR（RGB，无sRGB）（HDR (RGB, no sRGB)）** **用户界面2D（UserInterface2D (RGBA)）** **Alpha（无sRGB，BC4 on DX11）（Alpha (no sRGB, BC4 on DX11)）** **距离场字体（DistanceFieldFont (R8)）** **HDR压缩（HDRCompressed (RGB, BC6H, DX11)）** **BC7（DX11，可选A）（BC7 (DX11, optional A)）** **半浮点（Half-Float (R16F)）** |

### 材质设置

| **分段** | **说明** |
| --- | --- |
| **无光照默认遮罩材质（Unlit Default Masked Material）** | 新创建的Sprite的无光照默认遮罩材质（"遮罩"是指二元不透明度：物体要么不透明，要么可透视，没有中间状态）。 |
| **无光照默认半透明材质（Unlit Default Translucent Material）** | 新创建的Sprite的无光照默认半透明材质（半透明是指可在0..1区间内连续变化的平滑不透明度，但半透明渲染比不透明或遮罩渲染的成本更高，并且有不同的排序规则）。 |
| **无光照默认不透明Sprite材质（Unlit Default Opaque Sprite Material）** | 新创建的Sprite的无光照默认不透明材质。 |
| **光照默认遮罩材质（Lit Default Masked Material）** | 新创建的Sprite的光照默认遮罩材质（"遮罩"是指二元不透明度：物体要么不透明，要么可透视，没有中间状态）。 |
| **光照默认半透明材质（Lit Default Translucent Material）** | 新创建的Sprite的光照默认半透明材质（半透明是指可在0..1区间内连续变化的平滑不透明度，但半透明渲染比不透明或遮罩渲染的成本更高，并且有不同的排序规则）。 |
| **光照默认不透明材质（Lit Default Opaque Material）** | 新创建的Sprite的光照默认不透明材质。 |

