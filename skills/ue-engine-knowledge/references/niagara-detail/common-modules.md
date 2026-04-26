# Niagara 常用模块选择

本文件用于快速决定常见 Gameplay VFX、命中特效、拖尾、环境循环和 UI 风格特效应该从哪些模块开始。完整模块索引见 `module-inventory.md`，分类参数名见 `modules/`。

## 生成与初始化

- `InitializeParticle`：设置粒子基础属性，如 Lifetime、Sprite Size、Color、Mass、Position。几乎所有粒子 Emitter 都需要。
- `InitializeRibbon`：设置 Ribbon 宽度、朝向和初始属性。
- `SpawnRate`：持续按时间生成，适合烟、火、雨、环境粒子、持续拖尾。
- `SpawnBurst_Instantaneous`：单帧爆发，适合爆炸、命中、枪口火、火花。
- `SpawnPerUnit`：按移动距离生成，适合速度变化明显的轨迹拖尾。

## 位置与采样

- `BoxLocation`：盒状区域生成，适合区域雨、房间尘埃、体积填充。
- `SphereLocation`：球形区域生成，适合光环、蓄力、径向爆发。
- `ConeLocation`：锥形区域生成，适合喷射、尾焰、方向性爆发。
- `StaticMeshLocation` / `SkeletalMeshLocation`：从网格表面或骨骼网格采样。
- `SocketLocation`：从 socket 生成，适合武器、手部、脚底等明确挂点。

## 速度、力与求解

- `AddVelocity`：设置初速度；必须检查模式和方向，避免零向量。
- `AddVelocityInCone`：带扩散角的初速度，适合喷射、散射和爆炸碎片。
- `GravityForce`：重力；与 `SolveForcesAndVelocity` 的顺序必须正确。
- `Drag`：阻尼；控制粒子速度衰减。
- `CurlNoiseForce`：涡流扰动；适合烟雾、火焰、魔法能量。
- `SolveForcesAndVelocity`：把力积分到位置/速度。

## 碰撞与事件

- `Collision`：常用碰撞响应，默认优先 Ray Trace。
- `GenerateCollisionEvent`：碰撞后生成事件，供 Event Handler 消费。
- `ReceiveCollisionEvent`：接收碰撞事件，水花、碎片、命中二级粒子应在事件位置生成。
- `GenerateDeathEvent` / `ReceiveDeathEvent`：生命周期结束时触发二级效果。
- `KillParticles`：清理粒子，但不要清掉后续事件需要的 payload。

## 制作注意

- 先创建最小 System/Emitter，再导出 folder JSON 修改。
- 修改后 apply，并检查 Stack issue、compile log、runtime probe。
- 颜色、向量和枚举要用 UE 结构化文本，并检查读回。
- 出现红色感叹号不要猜，先用 `niagara_get_stack_issues` 读具体内容。
