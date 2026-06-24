# Niagara 与特效

## 覆盖范围

- Niagara System、Emitter、Script、Stage、Module、Parameter Map。
- Spawn、Update、Event Handler、Renderer、Data Interface。
- Sprite、Mesh、Ribbon、Light Renderer 的适用场景。
- Module input、dynamic input、linked input、enum 候选和编译/Stack 诊断。

## 阅读时机

- 需要制作、优化或排查 Niagara 特效。
- 需要判断模块应放在 System、Emitter、Particle Spawn、Particle Update 还是 Event Script。
- 出现 Ribbon 不产粒子、Sprite 拉伸方向错误、属性隐藏分支、Stack issue 或 compile log 差异。

## 通用原则

1. 先定义效果语义，再选择 emitter、module、renderer。不要从模块名反推效果。
2. Renderer 是数据模型选择，不只是外观开关。Sprite 表示独立粒子，Mesh 表示实例化几何，Ribbon 表示跨粒子连续轨迹，Light 表示粒子驱动光源。
3. Niagara 的核心是数据流。重点追踪属性在哪个阶段被写入、被覆盖、被 Renderer 读取。
4. 模块必须放在正确阶段。Emitter、Particle、Event、Simulation Stage 的执行时机不同，放错阶段会导致参数看似存在但不生效。
5. Event 触发生成粒子时，接收 emitter 仍会先执行普通 `Particle Spawn`，再执行 `Event Script`。Event 只传递事件数据，不替代基础粒子初始化。
6. 事件驱动的 Ribbon/Trail 中，`InitializeRibbon` 或基础粒子初始化应放在接收 emitter 的 `Particle Spawn`；`Receive...Event` 应放在 `Event Script`。否则可能出现有事件生成计数，但没有有效 Ribbon 粒子或轨迹。
7. Ribbon 必须有清晰的轨迹分组、连接顺序、采样密度和生命周期控制，否则容易错误连线、断裂或形成异常长线。
8. Sprite/Ribbon/Mesh 的拉伸、宽度、朝向必须按各自 Renderer 构造出的局部轴判断；具体规则见“坐标系与 Renderer 对齐”。
9. 位置、速度、轴向、旋转、尺寸等空间参数必须明确坐标系。Local、World、Emitter、Particle、Mesh、Screen facing 不可混用。
10. Module input 受 mode、enum、分支控制。修改参数前先确认当前分支激活，写后要确认结果确实生效。
11. 材质是 VFX 外观的一部分。Blend Mode、Opacity、Particle Color、UV 方向和 Emissive 连接会直接决定效果是否正确。
12. 复杂效果应按视觉职责分层，例如主体、轨迹、碎片、辉光、烟雾、环境反馈。每层职责越单一，越容易调试。
13. 验证不能只看截图。应结合编译结果、Stack issue、关键参数、粒子运行状态和视觉结果判断。
14. 操作成功不等于语义成功。必须确认参数生效、编译正常、Stack 正常、运行状态合理、视觉符合目标。

## 坐标系与 Renderer 对齐

### Sprite Renderer

#### Space Contract

- `subject`: Niagara Sprite Renderer 的单粒子渲染四边形。
- `dimension`: 三维世界中构造的二维 billboard 局部平面。
- `Fwrite`: `Particles.Velocity`、`Particles.SpriteAlignment`、`Particles.SpriteFacing`、`Particles.SpriteRotation`、`Particles.SpriteSize`。
- `Fread/Fverify`: Sprite vertex shader 生成的 `TangentRight` / `TangentUp`。
- `conversion_chain`: particle/sim 向量 -> renderer 转成世界向量 -> shader 构造 `TangentRight/TangentUp` -> `SpriteSize.X/Y` 沿局部轴展开顶点。

核心不变量：

```text
SpriteSize.X -> TangentRight / 局部 X
SpriteSize.Y -> TangentUp    / 局部 Y
```

| Alignment | 局部坐标系影响 |
| --- | --- |
| `Unaligned` | 不使用速度或 `SpriteAlignment`。Sprite 局部平面由 `FacingMode` 决定，`SpriteRotation` 只在平面内旋转 `Right/Up`。常见结果是相机相关 billboard。 |
| `Velocity Aligned` | 用 `Particles.Velocity` 定义 Sprite 局部 `Up/Y` 方向，`Right/X` 是与速度和 facing 共同构造出的垂直方向。`SpriteRotation` 被忽略。沿速度拉长应改 `SpriteSize.Y`，线宽改 `SpriteSize.X`。 |
| `Custom Alignment` | 用 `Particles.SpriteAlignment` 定义 Sprite 局部 `Up/Y` 方向；没有该 binding 时退回 `Unaligned`。`SpriteRotation` 仍可在最终平面内旋转。适合用自定义方向而不是速度方向控制朝向。 |

`Automatic` 只是在有无 `SpriteAlignment` binding 时自动选择 `CustomAlignment` 或 `Unaligned`，不是独立对齐语义。Alignment 主要决定 Sprite 局部 `Y/Up`，不是世界 XYZ，也不是材质 UV。

### Ribbon Renderer

- `subject`: Ribbon 每段几何和沿粒子顺序生成的中心线。
- `dimension`: 三维曲线加截面。
- `Fwrite`: `Particles.Position`、`Particles.RibbonLinkOrder`、`Particles.RibbonFacing`、`Particles.RibbonWidth`、`Particles.RibbonTwist`、renderer `FacingMode`。
- `Fread/Fverify`: vertex shader 生成的 `ribbon_tangent`、截面 side/normal 和 material tangent basis。
- `conversion_chain`: 粒子位置/顺序 -> `ribbon_tangent` -> `FacingMode/RibbonFacing` -> 截面 side/normal -> `RibbonWidth` 展开截面。

核心不变量：

```text
ribbon_tangent = 沿粒子连接顺序的轨迹方向
RibbonWidth    = 沿截面宽度展开，不改变轨迹长度
RibbonTwist    = 绕 ribbon_tangent 旋转截面，不改变中心线
```

| FacingMode | 局部坐标系影响 |
| --- | --- |
| `Screen` | 用相机方向作为 facing/normal 参考；宽度方向由 camera facing 与 `ribbon_tangent` 叉乘推出。结果随视角变化。 |
| `Custom` | `Particles.RibbonFacing` 表示 facing/normal 参考；宽度方向由 `RibbonFacing` 与 `ribbon_tangent` 叉乘推出。适合固定条带平面朝向。 |
| `CustomSideVector` | `Particles.RibbonFacing` 表示 side/width 参考，normal/facing 再由 side 与 `ribbon_tangent` 推出。`RibbonTwist` 不支持此模式。 |

`ShapeMode` 决定截面形状，`FacingMode` 决定截面相对中心线如何定向；二者不要混用。

### Mesh Renderer

- `subject`: 每个 Mesh particle 的 Static Mesh 实例。
- `dimension`: 三维实例 transform。
- `Fwrite`: `Particles.Position`、`Particles.Scale`、`Particles.MeshOrientation`、`Particles.Velocity`、renderer `FacingMode`、`MeshRotation/Scale/Offset`、`LockedAxis/LockedAxisSpace`。
- `Fread/Fverify`: shader/GPU Scene 生成的 instance local-to-world basis。
- `conversion_chain`: particle transform + renderer mesh transform -> optional facing matrix -> instance `local X/Y/Z` -> mesh vertices。

核心不变量：

```text
base_rotation = NiagaraQuatMul(normalize(Particles.MeshOrientation), renderer MeshRotation)

非 LockedAxis 的 facing matrix:
X = FacingDir
Y = normalize(cross(RefVector, X))
Z = cross(X, Y)

启用 LockedAxis 的 facing matrix:
Z = LockedAxis（按 LockedAxisSpace 转到实际计算空间）
Y = normalize(cross(Z, FacingDir))
X = cross(Y, Z)
```

`FacingDir` 由 `FacingMode` 选择；`RefVector` 在 `CameraPlane` 中是 camera up，其它非锁轴模式优先 world Z，接近平行时回退 world X。最终实例旋转为 `base_rotation` 叠加非 `Default` facing matrix；Local Space emitter 还会再进入 emitter/primitive 的 local-to-world。

| 设置 | 局部坐标系影响 |
| --- | --- |
| `Default` | 不构造 facing matrix；mesh local `X/Y/Z` 保持 static mesh 原始局部轴经 `Particles.MeshOrientation` 和 renderer `MeshRotation` 后的结果。 |
| `Velocity` | `FacingDir=Particles.Velocity`；非锁轴时 `X=FacingDir`，`Y/Z` 由 `RefVector` 正交化生成。速度为 0 时 `FacingDir` 回退到 world Z 转 simulation space。 |
| `CameraPosition` | `FacingDir=normalize(CameraOrigin - ParticleWorldPosition)`；非锁轴时 `X` 指向相机位置，`Y/Z` 由 world Z 参考向量正交化生成。 |
| `CameraPlane` | `FacingDir=-CameraForward`；非锁轴时 `X` 指向相机视平面法线方向，`Y/Z` 用 camera up 作为 roll 参考，不按粒子到相机点逐个收敛。 |
| `LockedAxis` | 不是独立 `FacingMode`；在非 `Default` facing matrix 中 `Z=LockedAxis`，`Y=normalize(cross(Z,FacingDir))`，`X=cross(Y,Z)`，因此 `X` 是 facing direction 投影到垂直 `Z` 平面后的最近方向。`LockedAxisSpace` 决定该轴按 `Simulation/World/Local` 哪个空间解释；`FacingDir` 与 `Z` 近乎平行时 shader 会换用 fallback direction。 |

`FacingMode` 影响的是 Mesh 实例 transform，不是材质 UV；`MeshOrientation` 仍参与最终旋转。当前 shader 中 `LockedAxis` 位于 facing matrix 路径，`Default` 下不要把它当成独立朝向规则。

## 后续填充位置

- Niagara 执行阶段和数据流。
- Ribbon 正确用法和事件接收器模式。
- Renderer 选择表。
- Module input 类型与编辑规则。
- 编译、Stack、preview、runtime probe 的验证顺序。
