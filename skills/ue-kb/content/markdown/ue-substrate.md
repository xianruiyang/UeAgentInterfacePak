# UE Substrate 水面材质制作教程

# UE Substrate 水面材质制作教程

日期：2026-06-11

本文是一份独立教程，面向会搭 UE 材质、Substrate、Custom HLSL、Lumen 验证场景的 TA。读者不需要任何现成资产、项目脚本或历史记录；只需要一个启用 Substrate 与 Lumen 的 UE 工程，就可以按本文从零搭出同类水面。

本文实现的是一种“工程可用的高质量近似水面”：

1. 水面本身是 `Opaque + Substrate`，不走普通透明。
2. 折射使用 fake-normal hack：用真实 Snell 折射方向反解一个法线，让 Lumen reflection ray 近似采样折射方向。
3. 反射和折射分成两个 Substrate carrier：反射用真实法线，折射用 fake normal。
4. 反射/折射比例用 Fresnel 算，不手工硬切。
5. 水体颜色用吸收、散射和 Mean Free Path 近似。
6. 波浪用世界空间多频段波谱：大浪进 WPO，小波和微波主要进解析法线。
7. 不用固定坐标画泡沫，不用半透明蓝片，不用屏幕空间后处理假水面。

## 1. 最终效果目标

这套方案适合做：

1. 中大型湖泊、海面测试场景。
2. 需要水上看水下、水下看水面都有物理方向感的水。
3. 需要真实反射和折射比例随视角变化的水。
4. 需要大尺度起伏、中尺度 chop、近景细碎微波的水。

它不直接解决：

1. 岸边接触泡沫。
2. 船尾迹和动态交互白水。
3. 完整海洋 FFT 频谱。
4. 完整真实水深与折射后命中距离。
5. 硬件 RT 路径的所有平台差异。

这些可以在本文基础上继续扩展，但不要混在第一版里做。

### 1.1 这套方案为什么成立

UE 里直接做“真实透明水”并不简单。普通半透明材质可以把后面的颜色混出来，但它通常无法稳定参与 Lumen 反射、距离场、深度排序和复杂水下光路；SingleLayerWater 有引擎内置水模型，但它的折射、反射和水下行为不一定能按本文需要完全拆开控制。本文选择 `Opaque + Substrate + Lumen fake-normal`，核心原因是：

1. `Opaque` 让水面进入稳定的主渲染路径，避免透明排序、半透明虚影和后处理式假透视。
2. `Substrate Slab` 能把界面反射、粗糙度、F0/F90、介质颜色和 MFP 放到相对清晰的 BSDF 结构里，而不是把所有东西塞进一个 BaseColor/Roughness 混合。
3. Lumen 反射本质上会沿着“视线 + 表面法线”决定的方向去找场景 radiance；如果把折射方向反解成一个假法线，就能让反射采样路径近似取到折射方向上的场景。
4. 真实能量比例仍由 Fresnel 控制，fake normal 只负责“采哪里”，不负责“占多少比例”。
5. 反射和折射需要不同 normal：反射必须看真实水面法线，折射 proxy 必须看 fake normal。把它们绑在一个 normal 上，会出现“折射对了反射错”或相反的问题。

所以本文不是在模拟完整透明光线传播，而是在 UE 当前实时管线里，用可维护的材质结构把水面最关键的三个问题拆开：几何波形、采样方向、能量比例。

## 2. 工程设置

### 2.1 渲染设置

在 Project Settings / Rendering 中确认：

1. Dynamic Global Illumination Method：`Lumen`
2. Reflection Method：`Lumen`
3. Generate Mesh Distance Fields：开启
4. Support Hardware Ray Tracing：可选，不是本教程必要条件
5. Substrate Materials：开启
6. Substrate Material Layer Support：开启
7. Substrate Opaque Material Rough Refraction：开启更方便调试粗糙层，但本教程主折射不依赖它
8. Substrate Advanced Visualization Shaders：建议开启，方便看 Substrate debug

修改 Substrate 相关设置后通常需要重启编辑器。

### 2.2 Post Process Volume

场景里放一个无界 PPV：

1. Infinite Extent：开启
2. Reflections Method：`Lumen`
3. Lumen Reflections Screen Traces：关闭
4. Lumen Reflection Quality：`4`
5. Lumen Scene Detail：`4`
6. Lumen Max Trace Distance：`20000-30000cm`
7. Ray Lighting Mode：`Hit Lighting for Reflections`

为什么关闭 Screen Traces：

1. 本方案把 Lumen 反射路径当作折射采样路径。
2. Screen Traces 会先采屏幕空间已有颜色。
3. 它容易采到前景、水面自身、屏幕边缘或固定屏幕位置伪影。
4. 验证 fake-normal 折射时应强制走 Lumen Scene / Software Ray Tracing。

### 2.3 这些工程设置背后的原因

`Substrate Materials` 必须开启，是因为本文的水面不是传统材质根节点的单一 shading model，而是用多个 Slab 组合出“真实反射 carrier + 折射 proxy carrier”。如果不开 Substrate，你仍然可以做近似水面，但无法按本文方式明确拆分每层 BSDF 的 normal、roughness、F0 和介质参数。

`Generate Mesh Distance Fields` 对 Lumen Software Ray Tracing 很关键。软件追踪主要依赖网格体距离场和全局距离场来找到场景表面；如果水底、柱子或反射目标没有进入 Lumen Scene，fake-normal 折射 proxy 即使方向算对，也可能采不到正确物体，只会得到天空、黑色或低质量 surface cache。

水面自己要从 Lumen tracing 数据里排除，原因也很直接：本文把 Lumen reflection ray 当折射采样 ray 使用。如果水面网格本身进入距离场，折射 proxy 很容易刚出发就命中水面自己，形成黑圈、亮边、固定屏幕位置伪影或局部“只反射不折射”的区域。软件追踪路径下通常用 `Affect Distance Field Lighting=False` 把水面移出这类 tracing 数据。

PPV 里的 Lumen trace distance 和 scene detail 决定了远处水底、斜柱和反射目标是否还在可追踪范围内。距离不够时，远处水面看起来会突然丢失折射目标；这不是 Fresnel 或 IOR 的问题，而是 Lumen Scene 没有足够覆盖。

## 3. 验证场景

先搭一个简单验证场景，不要一开始上复杂海岸线。

必备对象：

1. 一个大水面网格，中心在世界原点，水面高度为 `Z=0`。
2. 一个水底平面，放在 `Z=-300cm` 到 `Z=-800cm`。
3. 一个斜插水面的柱子，确保上半截在水上，下半截在水下。
4. 一个浅色或中性色反射目标，比如白色墙、灰色板、金属球。
5. Directional Light + Sky Atmosphere + Sky Light。
6. 无界 PPV。

关键设置：

1. 水面网格关闭 `Affect Distance Field Lighting`。
2. 水底、柱子、反射目标开启距离场或至少进入 Lumen Scene。
3. 水面材质不要写透明 alpha。
4. 水面材质不要使用 Planar Reflection 作为第一版验证。

水面网格建议：

1. 小场景验证：`200m x 200m`，网格间距 `50-100cm`。
2. 大浪 WPO：需要足够顶点密度，否则只有法线动、轮廓不动。
3. 大地图：先用静态大网格验证材质，再考虑 clipmap / tile / Niagara mesh / runtime mesh 方案。

### 3.1 为什么先搭这个验证场景

水材质不能只靠一张好看的海面截图验收。反射、折射、Fresnel、水色和波浪很容易互相掩盖：颜色太深会让折射看不见，反射太强会让假折射看起来像天空盒，波浪太密又会把 Fresnel debug 搅成噪声。

斜柱是最重要的验证物，因为它同时跨过空气和水。折射方向正确时，水上段和水下段的视觉位置应该出现可解释的偏移；如果只看到一层半透明虚影，说明你做的是 alpha 混合，不是折射采样；如果偏移固定在屏幕边缘或随镜头中心移动，说明你做的是屏幕空间伪影，不是稳定的 Lumen Scene 采样。

水底平面用于验证水体光学和远处 trace 覆盖。没有水底时，很多 ray miss 会被误判成“水很深”或“全反射”；有水底后，你才能分辨到底是光路长度、Lumen trace distance、MFP，还是 Fresnel 权重出了问题。

## 4. 材质总结构

新建材质，例如：

```text
M_TA_Substrate_FakeNormalWater
```

材质设置：

| 设置 | 值 |
| --- | --- |
| Material Domain | Surface |
| Blend Mode | Opaque |
| Two Sided | True |
| Tangent Space Normal | False |
| Max World Position Offset Displacement | 360cm 起步 |

`Tangent Space Normal=False` 非常重要。本文所有关键 normal 都是世界空间 normal。如果开着 Tangent Space Normal，UE 会把世界空间 fake normal 当 tangent normal 解释，折射方向会错。

Substrate 结构：

```text
Material Root.FrontMaterial
  Substrate Add / Mix
    Reflection Slab
      Normal = RealReflectionNormalWS
      Weight = FresnelReflectance
    Refraction Proxy Slab
      Normal = FakeRefractionNormalWS
      Weight = FresnelTransmittance
```

这不是两个平面。它是一个材质内部的两个 Substrate carrier：

1. Reflection Slab 负责真实反射。
2. Refraction Proxy Slab 用 fake normal 把 Lumen reflection ray 扭到折射方向。

### 4.1 为什么用 Opaque + 两个 Slab

水面看起来透明，并不意味着材质一定要用 `Translucent`。实时渲染里，透明路径往往意味着更复杂的排序、更弱的延迟渲染集成、更难稳定进入 Lumen 和后处理链路。本文需要的是“水面像一个物理界面一样决定反射/折射能量”，而不是把后面的画面按 alpha 混上来，所以第一原则是保持 `Opaque`。

两个 Slab 的目的不是做两层水，而是把职责拆开：

1. Reflection Slab 是真实界面。它的 normal 应该是水面的真实可见法线，F0 应该来自空气/水 IOR，roughness 应该控制真实反射清晰度。
2. Refraction Proxy Slab 是采样载体。它借用 Lumen reflection ray 的机制去采“折射方向上的场景”，所以它的 normal 是 fake normal，F0 可以设高，最终强度由外部 `1 - FresnelReflectance` 控制。

如果只用一个 Slab，你必须在同一个 normal 里同时满足反射方向和折射采样方向。这在几何上是矛盾的：同一个法线不能同时让反射 ray 指向真实反射方向，又让 proxy ray 指向 Snell 折射方向。

## 5. 参数表

先建这些 Scalar / Vector 参数。数值是一个可直接起步的海面预设。

### 5.1 光学参数

| 参数 | 类型 | 默认值 |
| --- | --- | ---: |
| `AirIOR` | Scalar | `1.0` |
| `WaterIOR` | Scalar | `1.333` |
| `P5ReflectionRoughness` | Scalar | `0.0` |
| `P5RefractionRoughness` | Scalar | `0.0` |
| `P5OpticalDepthCm` | Scalar | `1300` |
| `P5OpticalDensityScale` | Scalar | `12` |
| `P5ScatteringAlbedoScale` | Scalar | `0.055` |
| `P5MFPScale` | Scalar | `0.72` |
| `P5PhaseGArtOffset` | Scalar | `0.0` |
| `P5Chlorophyll` | Scalar | `0.038` |
| `P5NAP` | Scalar | `0.014` |
| `P5CDOM` | Scalar | `0.004` |
| `P5PureWaterAbsorptionRGB` | Vector | `(0.030, 0.011, 0.0042)` |
| `P5PureWaterScatteringRGB` | Vector | `(0.00036, 0.00105, 0.00192)` |

### 5.2 波浪参数

| 参数 | 类型 | 默认值 |
| --- | --- | ---: |
| `P6WaveHeightCm` | Scalar | `78` |
| `P6PrimaryWaveLengthCm` | Scalar | `900` |
| `P6GerstnerSteepness` | Scalar | `0.72` |
| `P6WindDirectionAngle` | Scalar | `0.72` |
| `P6DirectionSpread` | Scalar | `1.35` |
| `P6WaveTimeScale` | Scalar | `0.68` |
| `P6GeometryWaveAmpScale` | Scalar | `1.0` |
| `P6FresnelWaveNormalInfluence` | Scalar | `0.36` |
| `P7SwellWeight` | Scalar | `1.45` |
| `P7ChopWeight` | Scalar | `1.15` |
| `P7RippleWeight` | Scalar | `0.62` |
| `P7MicroRippleWeight` | Scalar | `0.86` |
| `P7MicroCrestSharpness` | Scalar | `4.6` |
| `P7DirectionJitter` | Scalar | `0.92` |
| `P7SpectrumSeed` | Scalar | `41.7` |

### 5.3 颜色和调试参数

可选参数：

| 参数 | 类型 | 默认值 |
| --- | --- | --- |
| `WaterScatterTint` | Vector | `(0.55, 0.85, 1.0)` |
| `DeepWaterTint` | Vector | `(0.02, 0.18, 0.30)` |
| `DebugMode` | Scalar | `0` |

第一版先不要做太多 debug 分支。把核心折射、反射、WPO 和法线验证清楚后再扩展。

### 5.4 参数为什么这样分组

参数分组的目的不是美观，而是为了防止调试时把不同物理层混在一起。`AirIOR/WaterIOR/Fresnel` 只决定界面能量比例；`P5*` 光学参数决定光在水里走过一段距离后被吸收、散射多少；`P6/P7*` 波浪参数决定几何和法线方向；`DebugMode` 只负责观察，不应该参与最终物理逻辑。

这样分组后，排错会非常直接：

1. 折射方向不对，先看 `Optical Core`、IOR 和 normal 空间。
2. 反射比例不对，先看 Fresnel debug。
3. 水色太糊或太深，先看 P5 光学参数。
4. 波纹跟网格缩放走，先看世界空间波浪坐标。
5. 远处闪烁，先看 micro fade 和 Lumen trace 覆盖。

## 6. 坐标系约定

整个材质严格使用世界空间：

```text
P_ws = 当前水面像素世界位置
C_ws = CameraPositionWS
N_real_ws = 真实水面法线，世界空间
I_ws = normalize(P_ws - C_ws)
V_ws = -I_ws
```

注意：

1. `I_ws` 是从相机射向水面的入射方向。
2. UE 的 `CameraVector` 很容易被误用。不同节点语义下它常表示 surface-to-camera。若使用它，必须先确认方向；通常入射方向要取反。
3. 波浪坐标用 `AbsoluteWorldPosition.xy`，建议选择 Excluding Material Offsets 版本作为波场采样坐标，避免 WPO 反馈。
4. 光学计算的 `SurfaceWorldPosWS` 应尽量使用包含 WPO 后的水面位置。如果材质图里难以获取，可以用 `BaseWorldPosWS + WPO` 自己拼出来。

坐标系必须在教程开头明确，因为 fake-normal 折射最容易死在这里。Snell 折射、反射半角、Fresnel 的 `cosI`、Lumen normal 输入都默认这些向量处在同一个空间。如果把世界空间 normal、切线空间 normal、view space 深度或 viewport UV 混在一起，画面可能仍然“有变化”，但变化没有物理意义，常见表现就是折射只在水下异常模糊、某些屏幕固定位置出现弧形边界、或相机靠近水面时方向突然翻转。

## 7. 世界空间波浪

### 7.1 波谱表

使用 12 组主波：

| id | lengthMul | ampMul | dirOffset | band | speedMul | steepMul | ampCap |
| --- | ---: | ---: | ---: | --- | ---: | ---: | ---: |
| 0 | 3.20 | 0.55 | 0.05 | swell | 0.72 | 0.70 | 0.030 |
| 1 | 2.25 | 0.38 | -0.42 | swell | 0.84 | 0.75 | 0.030 |
| 2 | 1.65 | 0.28 | 0.63 | swell | 0.93 | 0.78 | 0.032 |
| 3 | 1.00 | 0.62 | 0.00 | chop | 1.00 | 0.84 | 0.035 |
| 4 | 0.72 | 0.40 | 0.95 | chop | 1.12 | 0.80 | 0.034 |
| 5 | 0.54 | 0.32 | -1.10 | chop | 1.25 | 0.76 | 0.032 |
| 6 | 0.42 | 0.24 | 0.38 | chop | 1.38 | 0.70 | 0.030 |
| 7 | 0.33 | 0.18 | -0.62 | chop | 1.52 | 0.62 | 0.028 |
| 8 | 0.22 | 0.080 | 1.55 | ripple | 1.80 | 0.34 | 0.018 |
| 9 | 0.16 | 0.060 | -1.72 | ripple | 2.05 | 0.30 | 0.016 |
| 10 | 0.12 | 0.044 | 0.21 | ripple | 2.32 | 0.26 | 0.014 |
| 11 | 0.09 | 0.032 | -0.31 | ripple | 2.68 | 0.22 | 0.012 |

再加 6 组只进法线的微波：

| id | lengthMul | ampMul | dirOffset | speedMul | steepMul | ampCap |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 12 | 0.070 | 0.020 | 1.18 | 3.05 | 0.24 | 0.026 |
| 13 | 0.055 | 0.017 | -1.36 | 3.40 | 0.21 | 0.024 |
| 14 | 0.043 | 0.014 | 0.44 | 3.78 | 0.18 | 0.022 |
| 15 | 0.034 | 0.011 | -0.78 | 4.18 | 0.16 | 0.020 |
| 16 | 0.027 | 0.008 | 1.86 | 4.64 | 0.13 | 0.018 |
| 17 | 0.021 | 0.006 | -2.04 | 5.10 | 0.11 | 0.016 |

如果主波长是 `900cm`，微波大约是 `19-63cm`，它们应该只影响法线和高光，不应进入 WPO。

### 7.2 WPO Custom 节点

创建 Custom 节点：

```text
Name: MF_Water_WorldWaveWPO
Output Type: CMOT Float3
Inputs:
  BaseWorldPosWS float3
  TimeSeconds float
  P6WaveHeightCm float
  P6PrimaryWaveLengthCm float
  P6GerstnerSteepness float
  P6WindDirectionAngle float
  P6DirectionSpread float
  P6WaveTimeScale float
  P6GeometryWaveAmpScale float
  P7SwellWeight float
  P7ChopWeight float
  P7RippleWeight float
  P7DirectionJitter float
  P7SpectrumSeed float
```

WPO 只输出 Z：

```hlsl
float2 wp = BaseWorldPosWS.xy;
float t = TimeSeconds * max(P6WaveTimeScale, 0.0);
float TAU = 6.28318530718;
float baseL = max(P6PrimaryWaveLengthCm, 120.0);
float baseA = max(P6WaveHeightCm, 0.0) * max(P6GeometryWaveAmpScale, 0.0);
float steep = saturate(P6GerstnerSteepness);
float wind = P6WindDirectionAngle;
float spread = max(P6DirectionSpread, 0.0);
float swellW = max(P7SwellWeight, 0.0);
float chopW = max(P7ChopWeight, 0.0);
float rippleW = max(P7RippleWeight, 0.0);
float jitter = max(P7DirectionJitter, 0.0);
float seed = P7SpectrumSeed;
float waveCount = 12.0;
float z = 0.0;

// 手搓时按 7.1 的 12 行波表重复展开。
// 对每一组波 i：
// hash = frac(sin((seed + i + 1) * 12.9898) * 43758.5453)
// L = baseL * lengthMul
// A = min(baseA * ampMul * bandWeight, L * ampCap)
// angle = wind + spread * dirOffset + (hash * 2 - 1) * jitter
// D = normalize(float2(cos(angle), sin(angle)))
// k = TAU / max(L, 1)
// phase = k * dot(D, wp) + sqrt(980 * k) * t * speedMul + TAU * frac(hash + phaseShift)
// z += A * sin(phase)

return float3(0.0, 0.0, z);
```

这里没有水平 Gerstner 位移。原因是大型水面常会用 tile / clipmap / HISM。独立 tile 如果做水平位移，边界容易裂。如果你有完整 stitched mesh，可以再加入水平位移。

### 7.3 Analytic Normal Custom 节点

创建 Custom 节点：

```text
Name: MF_Water_WorldWaveNormal
Output Type: CMOT Float3
Inputs:
  BaseWorldPosWS float3
  CameraPositionWS float3
  TimeSeconds float
  P6WaveHeightCm float
  P6PrimaryWaveLengthCm float
  P6GerstnerSteepness float
  P6WindDirectionAngle float
  P6DirectionSpread float
  P6WaveTimeScale float
  P6GeometryWaveAmpScale float
  P7SwellWeight float
  P7ChopWeight float
  P7RippleWeight float
  P7MicroRippleWeight float
  P7MicroCrestSharpness float
  P7DirectionJitter float
  P7SpectrumSeed float
```

主体思路：

```hlsl
float3 dPdx = float3(1, 0, 0);
float3 dPdy = float3(0, 1, 0);

// 对 12 组主波：
// dPdx.x/y/z 和 dPdy.x/y/z 累加 Gerstner 解析导数。
//
// dPdx.x += -q * A * D.x * D.x * k * sin(phase)
// dPdx.y += -q * A * D.y * D.x * k * sin(phase)
// dPdx.z +=  A * D.x * k * cos(phase)
// dPdy.x += -q * A * D.x * D.y * k * sin(phase)
// dPdy.y += -q * A * D.y * D.y * k * sin(phase)
// dPdy.z +=  A * D.y * k * cos(phase)

// 对 6 组 micro 波，只加 z 斜率，不加水平位移导数：
float viewDistCm = length(BaseWorldPosWS - CameraPositionWS);
float microFade = 1.0 - smoothstep(2600.0, 9000.0, viewDistCm);
float microW = max(P7MicroRippleWeight, 0.0) * microFade;
float sharp = max(P7MicroCrestSharpness, 1.0);

// 每组 micro:
// crestU = saturate(0.5 + 0.5 * sin(phase))
// crestSlope = 0.5 * sharp * pow(max(crestU, 0.0001), sharp - 1) * cos(phase)
// dPdx.z += A * D.x * k * crestSlope
// dPdy.z += A * D.y * k * crestSlope

float3 n = normalize(cross(dPdx, dPdy));
n *= lerp(-1.0, 1.0, step(0.0, n.z));
return n;
```

重点：

1. normal 和 WPO 必须使用同一套主波参数。
2. micro 只影响 normal，不影响 WPO。
3. micro 用 `pow()` 让波脊变尖，否则容易像油膜或均匀噪声。
4. micro 必须距离淡出，否则远处会出现摩尔纹。

### 7.4 波浪为什么拆成 WPO、解析法线和微法线

水面波浪有三个不同尺度，不能全部用同一种方式处理。

大浪需要进入 WPO，因为它影响水面轮廓、遮挡、反射方向和物体穿水面的视觉关系。如果大浪只在 normal 里，远看会像一张平板上贴了波纹。

中尺度 chop 和 ripple 既影响轮廓，也影响高光，但它们进入 WPO 的比例要谨慎。顶点密度不足时，高频 WPO 会 alias；tile 或 HISM 水面如果有水平位移，边界会裂。

微波主要用于近景高光和细碎纹理，应该只进解析法线或法线贴图，不应该进 WPO。原因是 20-60cm 的几何位移需要极高网格密度才能稳定，否则只会制造闪烁、tile 缝和 shader complexity 空洞。把 micro 限制在 normal-only 层，可以保留尖锐高光，同时不破坏几何连续性。

世界空间采样是另一个硬要求。用 UV 或 object space 做波浪，水面 mesh 一缩放，波长也会缩放，于是水会像油膜一样贴在模型上；用世界坐标后，不同水面块、不同 actor scale 下的波长才保持一致。

## 8. Fresnel 过滤法线

真实视觉上，小波会影响高光方向，但不应该完全控制水/空气界面的能量比例。否则水下、水面贴近角会出现错误黑圈或大片全反射。

创建 Custom 节点：

```text
Name: MF_Water_FresnelFilteredNormal
Output Type: CMOT Float3
Inputs:
  MacroNormalWS float3
  AnalyticWaveNormalWS float3
  P6FresnelWaveNormalInfluence float
```

代码：

```hlsl
float3 macroN = normalize(MacroNormalWS);
macroN *= lerp(-1.0, 1.0, step(0.0, macroN.z));

float3 waveN = normalize(AnalyticWaveNormalWS);
waveN *= lerp(-1.0, 1.0, step(0.0, waveN.z));

float influence = saturate(P6FresnelWaveNormalInfluence);
return normalize(lerp(macroN, waveN, influence));
```

推荐：

```text
P6FresnelWaveNormalInfluence = 0.25-0.45
```

当前海面预设使用 `0.36`。

### 8.1 为什么 Fresnel 不能直接使用完整高频法线

Fresnel 描述的是界面上入射角变化导致的反射/透射能量比例。真实水面当然有微表面，但如果把所有微波高频法线都直接喂给 Fresnel，每个像素的入射角会被小波剧烈放大，结果是局部像素被错误推到临界角或掠射角，画面出现黑圈、硬边、大片全反射和闪烁。

所以这里用“过滤后的界面法线”算 Fresnel，用完整 analytic normal 主要负责高光和视觉波纹。这是一个工程取舍：能量比例更稳定，近景高光仍然细腻。`P6FresnelWaveNormalInfluence` 就是控制这件事的旋钮，越高越接近真实微表面变化，但越容易在水下和掠射角出问题。

## 9. Optical Core：fake normal 与 Fresnel

这是整套方案的核心。创建一个 Custom 节点：

```text
Name: MF_Water_OpticalCore
Output Type: CMOT Float4
Inputs:
  SurfaceWorldPosWS float3
  CameraPositionWS float3
  RealInterfaceNormalWS float3
  AirIOR float
  WaterIOR float
  TwoSidedSign float
```

输出约定：

```text
xyz = FakeRefractionNormalWS
w   = FresnelReflectance
```

代码：

```hlsl
float airIOR = max(AirIOR, 0.001);
float waterIOR = max(WaterIOR, 0.001);

float3 I_ws = SurfaceWorldPosWS - CameraPositionWS;
I_ws *= rsqrt(max(dot(I_ws, I_ws), 1e-8));
float3 V_ws = -I_ws;

float3 topN_ws = RealInterfaceNormalWS;
topN_ws *= rsqrt(max(dot(topN_ws, topN_ws), 1e-8));
topN_ws *= lerp(-1.0, 1.0, step(0.0, topN_ws.z));

float frontFace = step(0.0, TwoSidedSign);
float faceSign = lerp(-1.0, 1.0, frontFace);
float3 N_incident_ws = normalize(topN_ws * faceSign);

// 只做数值朝向保护，不改变介质选择。
float incidentFlip = step(0.0, dot(I_ws, N_incident_ws));
N_incident_ws = lerp(N_incident_ws, -N_incident_ws, incidentFlip);

// 正面：空气到水。背面：水到空气。
float etaI = lerp(waterIOR, airIOR, frontFace);
float etaT = lerp(airIOR, waterIOR, frontFace);

float cosI = saturate(-dot(I_ws, N_incident_ws));
float eta = etaI / max(etaT, 0.001);
float sinT2 = eta * eta * max(0.0, 1.0 - cosI * cosI);
float cosT = sqrt(saturate(1.0 - sinT2));

float3 T_ws = eta * I_ws + (eta * cosI - cosT) * N_incident_ws;
T_ws *= rsqrt(max(dot(T_ws, T_ws), 1e-8));

// 反解 fake normal，使 Lumen reflection ray 近似走向 T_ws。
float3 fakeRaw_ws = I_ws - T_ws;
float fakeLen2 = dot(fakeRaw_ws, fakeRaw_ws);

// 入射接近法线时，I 和 T 非常接近，fakeRaw 会趋近 0，需要稳定退化方向。
float3 stablePerp_ws = N_incident_ws - I_ws * dot(N_incident_ws, I_ws);
float stableLen2 = dot(stablePerp_ws, stablePerp_ws);
float3 helper_ws = lerp(float3(0,0,1), float3(1,0,0), step(0.92, abs(I_ws.z)));
float3 helperPerp_ws = helper_ws - I_ws * dot(helper_ws, I_ws);
helperPerp_ws *= rsqrt(max(dot(helperPerp_ws, helperPerp_ws), 1e-8));
stablePerp_ws *= rsqrt(max(stableLen2, 1e-8));
stablePerp_ws = normalize(lerp(helperPerp_ws, stablePerp_ws, step(1e-7, stableLen2)));

float3 fakeMain_ws = fakeRaw_ws * rsqrt(max(fakeLen2, 1e-8));
float bendT = saturate((fakeLen2 - 1e-8) / max(4e-6 - 1e-8, 1e-8));
bendT = bendT * bendT * (3.0 - 2.0 * bendT);

float3 fake_ws = normalize(lerp(stablePerp_ws, fakeMain_ws, bendT));
fake_ws *= lerp(-1.0, 1.0, step(0.0, dot(fake_ws, V_ws)));

// Unpolarized dielectric Fresnel。
float rsDen = max((etaI * cosI) + (etaT * cosT), 1e-6);
float rpDen = max((etaI * cosT) + (etaT * cosI), 1e-6);
float rs = ((etaI * cosI) - (etaT * cosT)) / rsDen;
float rp = ((etaI * cosT) - (etaT * cosI)) / rpDen;
float reflectance = saturate(0.5 * (rs * rs + rp * rp));

return float4(normalize(fake_ws), reflectance);
```

注意：

1. 不要用 `CameraPositionWS.z` 判断水上水下。
2. 不要用固定水面高度判断水上水下。
3. 使用 `TwoSidedSign` 决定当前像素是正面还是背面。
4. 反射率 `w` 只表示能量比例，不表示 fake normal 强度。

### 9.1 fake normal 具体在骗什么

Lumen reflection ray 的方向由视线方向和材质 normal 决定。传统反射公式可以写成：

```text
R = I - 2 * dot(I, N) * N
```

这里 `I` 是从相机射向水面的方向，`R` 是反射 ray 方向。本文想要的不是让 `R` 变成真实反射方向，而是让 `R` 近似等于 Snell 算出来的折射方向 `T`。把 `R=T` 代回去：

```text
T = I - 2 * dot(I, N_fake) * N_fake
I - T = 2 * dot(I, N_fake) * N_fake
```

因此 `N_fake` 与 `I - T` 同向。这就是代码里 `fakeRaw_ws = I_ws - T_ws` 的来源。这个 fake normal 不是水面的真实法线，它只是一个让 Lumen 反射采样方向“反射到折射方向”的数学载体。

当视线接近法线方向时，空气入水的折射方向 `T` 会非常接近 `I`，`I - T` 长度接近 0。这时直接 normalize 会导致随机方向、黑圈或抖动，所以必须使用稳定的垂直 fallback。这个 fallback 的作用不是增强折射，而是在“几乎不需要弯折”的情况下给 Lumen 一个稳定 normal，避免数值噪声被放大。

Fresnel 使用完整 dielectric 公式，而不是简单 Schlick，是因为水下 `WaterIOR -> AirIOR` 会出现临界角和全反射。Schlick 适合很多空气侧近似，但它不会自然表达水下 Snell window 的硬物理边界。

## 10. 反射可见面法线

反射 slab 不应使用 fake normal。创建 Custom 节点：

```text
Name: MF_Water_ReflectionVisibleNormal
Output Type: CMOT Float3
Inputs:
  StableTopNormalWS float3
  SurfaceWorldPosWS float3
  CameraPositionWS float3
  TwoSidedSign float
```

代码：

```hlsl
float3 n = StableTopNormalWS * rsqrt(max(dot(StableTopNormalWS, StableTopNormalWS), 1e-8));
float face = lerp(-1.0, 1.0, step(0.0, TwoSidedSign));
n *= face;

float3 V = CameraPositionWS - SurfaceWorldPosWS;
V *= rsqrt(max(dot(V, V), 1e-8));

n = lerp(-n, n, step(0.0, dot(n, V)));
return n;
```

用途：

1. Reflection Slab 的 Normal 接这里。
2. Refraction Proxy Slab 的 Normal 接 optical core 的 fake normal。
3. 二者不能共用。

### 10.1 为什么反射法线必须单独处理

fake normal 是为了让折射 proxy 的采样方向变成 `T_ws`，它不是可见水面的真实微表面方向。如果 Reflection Slab 也使用 fake normal，反射就会被强行弯向折射方向，表现为天空、墙面或建筑反射变糊、变形，甚至反射和折射互相串色。

真实反射应该始终遵守“可见面法线”。双面材质里，水上看顶面和水下看底面时，法线朝向要对着当前视线，否则背面会把反射 ray 发到错误半球。`MF_Water_ReflectionVisibleNormal` 做的就是这件事：先根据 `TwoSidedSign` 得到当前面，再确保 normal 面向相机。

## 11. 水体光学近似

本教程第一版用 Beer-Lambert + 简化 IOP 参数做水色。

### 11.1 吸收与散射

创建 Custom 节点：

```text
Name: MF_Water_MediumAlbedo
Output Type: CMOT Float3
Inputs:
  PureWaterAbsorptionRGB float3
  PureWaterScatteringRGB float3
  Chlorophyll float
  NAP float
  CDOM float
  ScatteringAlbedoScale float
```

代码：

```hlsl
float3 PureAbs = max(PureWaterAbsorptionRGB, 0.0);
float3 PureSca = max(PureWaterScatteringRGB, 0.0);
float Chl = max(Chlorophyll, 0.0);
float Nap = max(NAP, 0.0);
float Cdom = max(CDOM, 0.0);

float3 Absorption =
    PureAbs +
    Chl  * float3(0.030, 0.004, 0.026) +
    Nap  * float3(0.012, 0.010, 0.007) +
    Cdom * float3(0.006, 0.014, 0.046);

float3 Scattering =
    PureSca +
    Chl  * float3(0.00022, 0.00072, 0.00038) +
    Nap  * float3(0.00130, 0.00108, 0.00082) +
    Cdom * float3(0.00001, 0.000018, 0.000022);

float3 Extinction = max(Absorption + Scattering, float3(1e-6, 1e-6, 1e-6));
float3 Albedo = Scattering / Extinction;
return saturate(max(ScatteringAlbedoScale, 0.0) * Albedo);
```

这个输出可以接到 Substrate Slab 的 Diffuse Albedo 或用于 Medium 近似。不要把它当普通 BaseColor 直接涂满水面。

再创建一个 PhaseG 节点，用同一组水质参数给 Substrate 的相位各向异性提供近似：

```text
Name: MF_Water_PhaseG
Output Type: CMOT Float1
Inputs:
  Chlorophyll float
  NAP float
  CDOM float
  PhaseGArtOffset float
```

代码：

```hlsl
float Chl = max(Chlorophyll, 0.0);
float Nap = max(NAP, 0.0);
float Cdom = max(CDOM, 0.0);
float PhaseG = 0.11 + Chl * 0.08 + Nap * 0.18 - Cdom * 0.03 + PhaseGArtOffset;
return clamp(PhaseG, -0.85, 0.85);
```

为什么需要 PhaseG：

1. 散射 albedo 只说明有多少能量被散射，不说明散射朝哪个方向偏。
2. 水体中的悬浮颗粒通常有一定前向散射倾向；PhaseG 可以给 Substrate medium 一个更合理的方向性。
3. `P5PhaseGArtOffset` 是美术微调项，默认保持 `0`，不要用它替代真实水色调节。

### 11.2 光路长度

简化做法：

```text
Top view path length = OpticalDepthCm / max(abs(dot(ViewDir, WaterNormal)), 0.08)
Underwater view path length = distance(CameraPositionWS, SurfaceWorldPosWS)
```

更好做法：

1. 如果能稳定得到水底深度，用真实水面点到水底命中点距离。
2. 如果做屏幕空间水深，不要使用非线性的 viewport Z 直接比较。
3. 不要在第一版里为“看起来有深度”乱加半透明雾。

### 11.3 Mean Free Path

如果使用 Substrate `Transmittance-To-MeanFreePath` 节点：

```text
TransmittanceColor = exp(-Extinction * PathLengthMeters * OpticalDensityScale)
Thickness = PathLengthCm * 0.01
```

然后让节点输出 MFP 给 Slab Medium。

如果手写近似：

```text
MFP = max(PathLengthMeters / max(-log(TransmittanceColor), 1e-4), smallValue)
MFP *= P5MFPScale
```

### 11.4 为什么 P5 光路长度是过渡方案

水色本质上取决于光在水里走了多远。真实情况下，水上看水底时应该沿折射后的 `T_ws` 找到水底命中点，再计算水面到命中点的水中距离；水下看水面时，则要根据相机到界面、反射/折射方向和上方命中内容分别计算路径。

本文第一版没有把这个问题完全做成真实 ray query，而是给出稳定的过渡方案：水上用视线和参考水底估算厚度，水下用相机到水面的距离估算。这样做的原因是屏幕空间 raymarch 很容易 miss，Lumen hit distance 在材质里也不稳定可用，而错误的“假水深”会比简单估算更糟。

重要的是不要用 viewport Z 当水深。viewport Z 是投影后的非线性深度，不等于世界空间距离；拿它直接比较会导致远处和近处水色变化不一致，也会让镜头角度改变时水深突然跳变。

## 12. Substrate 节点连接

### 12.1 Reflection Slab

创建 `Substrate Slab BSDF`：

| 输入 | 连接 |
| --- | --- |
| Normal | `MF_Water_ReflectionVisibleNormal` |
| F0 | `((WaterIOR - 1) / (WaterIOR + 1))^2`，约 `0.02037` |
| F90 | `1.0` |
| Roughness | `P5ReflectionRoughness` |
| Diffuse Albedo | 接近 `0` 或极弱水色 |

再用 `Substrate Weight`：

```text
Weight = FresnelReflectance
```

### 12.2 Refraction Proxy Slab

创建第二个 `Substrate Slab BSDF`：

| 输入 | 连接 |
| --- | --- |
| Normal | `FakeRefractionNormalWS` |
| F0 | `1.0` 或足够高的白色反射响应 |
| F90 | `1.0` |
| Roughness | `P5RefractionRoughness` |
| Diffuse Albedo | 水体散射 albedo 或弱 tint |
| SSS MFP / Mean Free Path | P5 水体 MFP |
| SSS MFP Scale | `P5MFPScale` |
| SSS Phase Anisotropy | `MF_Water_PhaseG` |

再用 `Substrate Weight`：

```text
Weight = 1 - FresnelReflectance
```

为什么 proxy slab 的 F0 可以很高：

1. 这层不是物理反射表面。
2. 它是为了让 Lumen reflection ray 返回折射方向上的场景 radiance。
3. 真实能量比例由外部 Weight 控制。

### 12.3 合成

用 `Substrate Add` 或合适的 Substrate mixing 节点合成两个 weighted slab，接到 Material Root 的 `Front Material`。

根节点还要接：

```text
World Position Offset = MF_Water_WorldWaveWPO
```

Normal 不接传统材质根 normal；Substrate Slab 各自接 normal。

### 12.4 这套 Substrate 连接的取舍

这套连接不是“严格物理透明材质”，而是实时管线里的分层近似。Reflection Slab 是物理意义较强的层：F0 来自 IOR，normal 来自真实水面，weight 来自 Fresnel。Refraction Proxy Slab 则是工程载体：它用高 F0 触发 Lumen reflection radiance 返回，但最终能量被 `1 - FresnelReflectance` 限制。

如果把 proxy slab 的 F0 也设成水的真实 F0，它可能无法提供足够稳定的折射方向采样，因为 Lumen 会把它当成一个很弱的反射界面。本文把“采样强度”和“物理能量比例”拆开：proxy 强负责采样，Fresnel weight 负责最终物理比例。这一点必须写清楚，否则很容易误以为高 F0 是把水做成镜子。

## 13. 材质图搭建顺序

推荐顺序：

1. 先做一个完全平面的 opaque Substrate 水面，只连 Reflection Slab。
2. 加 PPV，关闭 Screen Traces，确认反射来自 Lumen Scene。
3. 加 Optical Core，但先把 `RealInterfaceNormalWS` 固定为 `(0,0,1)`。
4. 让 Refraction Proxy Slab 接 fake normal，观察斜柱水上/水下是否出现折射偏移。
5. 加 Fresnel 权重，调试红绿 debug：
   - 红 = reflectance
   - 绿 = transmittance
6. 加 P5 水体颜色和 MFP。
7. 加 WPO 主波。
8. 加 analytic normal。
9. 加 micro normal-only 波。
10. 最后再调色、环境、曝光。

不要从第一步就把 WPO、微波、水色、Fresnel、折射、反射、泡沫全部接上。水材质一旦混在一起，错误会很难定位。

### 13.1 为什么必须按这个顺序搭

这个顺序的核心是每一步只引入一个新变量。先做 Reflection Slab，是为了确认 Substrate、Lumen 和 PPV 工作正常；再加固定法线折射，是为了排除波浪 normal 干扰；再加 Fresnel，是为了确认反射/折射比例连续；最后才加 P5 水色、WPO 和微波。

如果一开始就把全部效果接上，任何一个错误都会被其他层掩盖。例如折射方向错了，深水 tint 可能让它看不出来；Fresnel 错了，强反射目标可能让它像“正常镜面”；micro normal 太强，可能把一个正确的 Fresnel 算法变成满屏噪声。所以水材质的搭建顺序本身就是调试策略。

## 14. 验证方式

### 14.1 折射验证

场景里放一根斜柱穿过水面：

1. 从水上看水下段。
2. 从水下看水上段。
3. 调 `WaterIOR`：
   - `1.333` 应有可见偏折。
   - 临时设为 `1.0` 应接近无偏折。
4. 确认没有半透明虚影。
5. 确认折射不是屏幕空间边缘拖影。

### 14.2 Fresnel 验证

临时输出 debug 色：

```text
DebugColor = lerp(green, red, FresnelReflectance)
```

预期：

1. 正视角大部分偏绿。
2. 掠射角逐渐偏红。
3. 水下向上接近临界角会出现明显红区，这是物理上的 Snell window / TIR 边界，不一定是错误。
4. 如果边界固定在屏幕位置，才是错误。

### 14.3 反射验证

在水面旁边放白墙、黑墙、金属球：

1. 看是否能在水面中反射真实物体。
2. 移动物体，反射应变化。
3. 关闭物体距离场或 Lumen 可见性，反射应变差或消失。
4. 打开 Screen Traces 后如果出现屏幕固定伪影，说明不能依赖它。

### 14.4 波浪验证

1. 拉大水面网格，波长不应跟着网格 UV 变化。
2. 改 actor scale，波浪世界尺度应基本不变。
3. 近景能看到尖锐小波。
4. 远景不应出现密集摩尔纹。
5. WPO 边缘不应出现明显裂缝。

### 14.5 为什么这些验证能定位根因

`WaterIOR=1.0` 是最简单的折射对照组。空气和水折射率相同时，Snell 折射方向应接近原方向；如果此时仍然出现大幅偏折、重影或模糊圆，问题就不在 IOR，而在 fake normal、Lumen 采样或其他旧逻辑残留。

Fresnel 红绿 debug 用来分离“比例问题”和“采样问题”。如果 debug 显示正视角是绿色、掠射角是红色，说明能量比例基本正确；如果正常画面仍然黑或糊，就要查 Lumen Scene、proxy slab、MFP 或 roughness。如果 debug 本身出现屏幕固定圆弧，则是坐标、法线或侧判断错误。

斜柱验证折射方向，白墙/金属球验证反射方向，水底平面验证水色和 trace coverage。三个对象缺一不可，否则容易把“没命中”“全反射”“水色太深”和“折射方向错”混成同一个问题。

## 15. 调参指南

### 15.1 大浪

优先调：

1. `P6WaveHeightCm`
2. `P6PrimaryWaveLengthCm`
3. `P6GerstnerSteepness`
4. `P7SwellWeight`
5. `P7ChopWeight`

如果增大 `P6WaveHeightCm`，同步检查：

1. 水面网格顶点密度。
2. WPO bounds。
3. 视锥裁剪。
4. tile 边界。

### 15.2 尖锐小波

优先调：

1. `P7MicroRippleWeight`
2. `P7MicroCrestSharpness`
3. micro fade 起止距离。

症状与处理：

| 症状 | 处理 |
| --- | --- |
| 小波不明显 | 增加 `P7MicroRippleWeight` |
| 小波太噪 | 降低 `P7MicroRippleWeight` |
| 小波太圆 | 增加 `P7MicroCrestSharpness` |
| 远景摩尔纹 | 提前淡出或降低 micro 权重 |
| tile 缝扩大 | 确认 micro 没有进入 WPO |

### 15.3 水色

优先调：

1. 环境光和天空。
2. 水底颜色。
3. 曝光。
4. `P5OpticalDensityScale`
5. `P5MFPScale`
6. `P5CDOM`
7. `P5Chlorophyll`

不要直接把水面 base color 压深。这样会破坏折射和水下可见性。

## 16. 常见错误

### 16.1 水面像透明蓝片

原因：

1. 使用了半透明材质。
2. 使用 alpha 直接混合水下画面。
3. 折射不是通过 fake normal / Lumen Scene 采样。

修法：

1. Blend Mode 保持 Opaque。
2. 使用 Substrate Slab。
3. Refraction Proxy Slab 接 fake normal。

### 16.2 折射完全错误

原因：

1. `Tangent Space Normal=True`。
2. `CameraVector` 方向用反。
3. fake normal 没有处理近法线入射退化。
4. 水面自身进入距离场，自命中。

修法：

1. 关掉 Tangent Space Normal。
2. 明确定义 `I_ws = normalize(P_ws - C_ws)`。
3. 使用 stable perpendicular fallback。
4. 水面关闭 `Affect Distance Field Lighting`。

### 16.3 有黑圈或硬边

原因：

1. 用分支硬切 TIR。
2. 用相机 Z 判断水上水下。
3. 用固定水面高度判断介质侧。
4. 小波直接参与 Fresnel 能量计算过强。

修法：

1. 使用连续 Fresnel。
2. 用 `TwoSidedSign` 做介质侧。
3. Fresnel 用宏观过滤法线。
4. 降低 `P6FresnelWaveNormalInfluence`。

### 16.4 反射对了，折射错；或折射对了，反射错

原因：

1. 反射和折射共用一个 normal。
2. 试图用 `bTangentSpaceNormal` 的开关同时满足两条路径。

修法：

1. 反射 Slab 使用真实可见面法线。
2. 折射 Proxy Slab 使用 fake normal。
3. `bTangentSpaceNormal=False`。

### 16.5 波浪像油膜

原因：

1. 波浪用 UV 或 object space。
2. 小波只是普通正弦密纹。
3. 缺少方向扰动和多频段。

修法：

1. 波浪用世界空间。
2. 使用 swell / chop / ripple / micro 分层。
3. micro 用 crest sharpness。
4. 加 hash phase 和 direction jitter。

## 17. 性能与质量边界

这套材质成本不低：

1. Substrate 多 Slab。
2. Lumen reflection tracing。
3. 多组波浪 Custom HLSL。
4. WPO。
5. 双面材质。

优化方向：

1. 远景降低 micro normal。
2. 根据平台减少波组数量。
3. 把微波换成高质量 normal texture。
4. 大海面用 mesh/clipmap LOD，不要全场高密度网格。
5. 反射质量用 PPV 分级，不要所有平台都开最高。

## 18. 最小验收清单

完成后逐项检查：

1. 材质编译无 error / warning。
2. Blend Mode 是 Opaque。
3. Substrate graph 接到 Front Material。
4. Two Sided 开启。
5. Tangent Space Normal 关闭。
6. WPO 有大浪，但 micro 没进 WPO。
7. 反射 Slab normal 和折射 Proxy Slab normal 分开。
8. WaterIOR 为 `1.333`。
9. Fresnel debug 正视角偏透射，掠射角偏反射。
10. 水面不进入距离场。
11. 水底和柱子进入 Lumen Scene。
12. Lumen Reflections Screen Traces 关闭。
13. 斜柱水上/水下有可解释折射偏移。
14. 近景有尖锐小波。
15. 远景没有严重摩尔纹。
16. 不存在固定屏幕位置黑圈。
17. 不存在透明虚影式假折射。

## 19. 后续扩展

建议后续按这个顺序扩展：

1. 重做水面网格载体：
   - stitched clipmap
   - Niagara mesh generation
   - runtime virtual mesh
   - WaterBody 集成
2. 加真实浪峰泡沫：
   - slope / curvature / crest phase
   - scene contact depth
   - flow advection
3. 加交互：
   - render target wake
   - Niagara spray
   - object velocity foam
4. 加水下后处理：
   - underwater fog
   - Snell window debug
   - volumetric color
5. 做平台质量分级：
   - high：多波 + Substrate + Lumen
   - medium：少波 + Lumen
   - low：normal texture + SSR / reflection capture fallback

## 20. 参考资料

本文不依赖这些资料才能执行，但建议理解背景：

1. Epic 官方 Substrate Materials Overview：`https://dev.epicgames.com/documentation/unreal-engine/overview-of-substrate-materials-in-unreal-engine`
2. Epic 官方 Lumen Technical Details：`https://dev.epicgames.com/documentation/unreal-engine/lumen-technical-details-in-unreal-engine`
3. GPU Gems / Gerstner Waves 相关资料。
4. 海洋 IOP：pure water absorption / scattering、Chlorophyll、NAP、CDOM。

关键实现原则比具体节点更重要：

1. 坐标系统一。
2. 反射和折射 normal 职责分离。
3. Fresnel 连续，不硬切。
4. 大浪进几何，小波进法线。
5. 水面自己不要污染 Lumen tracing 数据。
