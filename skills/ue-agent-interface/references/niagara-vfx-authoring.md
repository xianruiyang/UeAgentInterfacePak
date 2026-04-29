# Niagara 视觉特效制作原则

本文件用于制作或修复 Niagara 视觉效果时加载。它补充 `SKILL.md` 的 Niagara 专项规则，不替代插件命令文档和 folder JSON schema。

## 1. 视觉语义优先

不要从“加哪些模块”开始。先拆解效果的可观察语义：

- 主形体：第一眼识别的轮廓。
- 辅助辉光：增强能量感，但不能压过主体。
- 细节粒子：火花、碎片、烟、尘、液滴等。
- 源点提示：效果从哪里来。
- 命中/结束反馈：效果在哪里结束，是否碰撞、爆裂、散落或消散。
- 环境残留：烟、余光、尘雾、焦痕、漂浮粒子等。

每个 emitter 都必须有清晰职责。说不清职责的 emitter 通常应删除或合并。

## 2. 分层要有差异

分层不是越多越好。一个层必须贡献不同语义、材质、运动、生命周期或空间范围。

常见层：

- 主体层：决定形体。
- 光晕层：决定能量扩散。
- 细节层：提供尺度和噪声。
- 运动层：表现方向、速度和受力。
- 残留层：表现消散和环境反馈。

如果多个 emitter 只是同类圆点、同类速度、同类材质的叠加，优先收敛结构。

## 3. 材质、贴图和 Renderer 是核心

Niagara 生成数据，最终视觉由 Renderer、材质、贴图、透明度和混合模式共同决定。

- 主形体复杂时，优先考虑贴图、SubUV、Flipbook、Mesh 或 Ribbon，不要用大量圆形 Sprite 拼。
- 默认 Sprite 材质只适合调试，不适合最终效果。
- 发光效果要控制 alpha、bloom 贡献和尺寸，避免变成大光团。
- 不同语义应使用合适材质逻辑；烟、能量、液体、尘土、火花不应无差别共用。
- 粒子颜色只是一部分，opacity、emissive、depth fade、soft particle 同样决定可见性。

Renderer 选择原则：

| Renderer | 适合内容 |
| --- | --- |
| Sprite | 面片、烟、火花、软粒子、贴图闪现 |
| Mesh | 实体碎片、弹体、姿态明确的体积对象 |
| Ribbon | 连续路径、拖尾、Beam、轨迹、事件驱动线段 |
| Light | 局部照明增强；数量和半径必须克制 |

## 4. 主形体稳定，细节克制

主体要轮廓清晰、位置稳定、尺寸和方向符合预期，并且不被辉光、烟雾或碎片遮住。

细节粒子应数量少、生命周期短或透明度低、尺度小于主体，并且运动方向服务于主体。第一眼只能看到一团光、一堆点或一片烟时，说明层级失控。

## 5. 锚点必须统一

很多错位问题不是数量问题，而是锚点问题。需要统一检查：

- 生成位置。
- 速度源点。
- Sprite 贴图 pivot。
- Mesh 原点。
- Ribbon 起点/终点。
- 碰撞或事件 payload 位置。
- 后续爆裂、火花、烟尘的 spawn 位置。

大 Sprite、Ribbon、Mesh 尤其要检查 pivot。粒子位置不一定等于视觉端点或命中点。

## 6. 运动逻辑必须匹配语义

每层都要回答：从哪里生成、受到什么力、为什么结束。

常见错误：

- 速度为 `(0,0,0)`，粒子存在但不运动。
- 速度源点放错，导致应该径向爆裂的粒子变成垂直喷射。
- 重力方向或大小不符合语义。
- Drag 太小导致飞太远，或太大导致粘住。
- 所有层用同样速度，效果像单一喷泉。
- 用静态位置假装碰撞结果。

运动参数必须服务视觉逻辑，不只是让粒子动起来。

## 7. 生命周期决定质感

- 冲击、火花、爆裂：短生命周期。
- 主体能量：略长但要清晰淡出。
- 烟、尘、余光：更长但 alpha 低。
- 细节噪声：随机生命周期，避免机械同步。
- 循环效果：Emitter loop、SpawnRate 和生命周期要匹配，避免断帧或堆积。

效果脏、糊、拖沓时，先查生命周期、alpha 和数量。

## 8. Mode / Branch / Binding 必须共同验证

写入值不代表运行时使用它。常见分支规则：

- `Uniform` 使用 `Uniform Sprite Size`。
- `Non-Uniform` 使用 `Sprite Size`。
- `Random Uniform` 使用 Uniform Min / Max。
- `Random Non-Uniform` 使用 Vector2 Min / Max。
- Shape 类型决定 Sphere Radius、Box Size、Ring Radius、Cone Angle 等哪个字段生效。
- Color Direct Set、Random Range、Curve、Dynamic Input 读取字段不同。

验收必须同时确认：

- 控制 mode 正确。
- 目标参数在活跃分支。
- Renderer binding 读取该属性。
- readback 的 enum display name 与 UI 语义一致。

遇到 `module_input_hidden_or_inactive_branch`，先写控制项，重新 apply/export，再写分支值，不要直接忽略。

## 9. 事件链不要靠猜

碰撞、命中、拖尾、子粒子生成等逻辑，应通过事件 payload 或明确数据接口传递位置、速度、法线和时间。

正确数据流：

```text
源粒子
  -> 产生事件
  -> 写入 payload
  -> 接收端读取 payload
  -> 在真实位置生成后续效果
```

错误做法：

- 碰撞后效果用固定位置生成。
- Event Handler 重新初始化粒子并覆盖 payload 位置。
- Kill 源粒子时清掉后续需要的数据。
- 只看粒子数量，不确认事件位置。

事件类效果必须从 0 连续推进到目标时间，再读取同一暂停状态的 probe / screenshot。

## 10. 验证顺序

不要只靠截图或 runtime probe 下结论。推荐顺序：

1. 清 compile log 和 Stack issue。
2. 读回关键参数、mode、enum、static switch。
3. 检查 Renderer class、材质、贴图、binding、pivot。
4. 对事件/碰撞/时间相关效果，从 0 连续推进到目标帧。
5. 最后做视觉检查。

Probe 证明统计数据，截图证明某个视角的视觉状态；两者都不能替代 readback、Stack 和 compile。

## 11. 失败时先找根因

常见失败方向：

- 看不见：颜色黑、alpha 为 0、材质透明、尺寸太小、Renderer visibility、相机裁剪。
- 不动：速度为 0、力未接入、Solve 顺序错误、Drag 过强。
- 方向错：速度模式、速度源点、坐标空间或对齐方式错误。
- 形状像圆点：尺寸模式、Renderer binding 或材质贴图错误。
- 命中位置错：pivot、anchor、event payload、Shape Origin 不一致。
- Stack 感叹号：模块依赖、执行顺序、事件源、隐藏分支或失效输入。
- System 不出粒子但 emitter 正常：System handle、refresh、编译状态、Emitter enabled、scalability、事件依赖或坏实例状态。

先定位根因，再修改。不要用更多模块掩盖错误。

## 12. 最小流程

```text
视觉目标
  -> 语义拆层
  -> Renderer / 材质 / 贴图选择
  -> 每层生成位置、运动、生命周期
  -> mode / binding / active branch 检查
  -> apply
  -> compile / Stack / readback
  -> 时间推进或视觉验证
  -> 收敛多余层
```

每个 emitter 都要能回答：负责什么视觉语义、生成在哪里、如何运动、何时结束、Renderer 读哪些属性、锚点是否一致、关键参数是否读回且处于活跃分支。
