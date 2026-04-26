# Niagara 默认参数与命名空间

本文件说明 Niagara 参数面板分组和常见 `Engine Provided` 参数。参数名、类型和命名空间保持 UE 原始英文。

## 面板分组

| 分组 | 中文说明 |
|---|---|
| `User Exposed` | 外部可传入参数，通常由实例、Blueprint、C++ 或 Sequencer 驱动。 |
| `System Attributes` | System 阶段写入的持久值；是命名空间，不是固定列表。 |
| `Emitter Attributes` | Emitter 阶段写入的持久值；是命名空间，不是固定列表。 |
| `Particle Attributes` | Particle 阶段写入的持久值，包含内置粒子属性。 |
| `Module Outputs` | 当前执行链的临时下游值。 |
| `Engine Provided` | 引擎或 owner context 注入的只读运行时值。 |
| `Module Locals` | 模块局部变量。 |
| `Stage Transients` | 当前 stage 作用域内的临时值。 |
| `Local Modules` | 当前脚本内定义的 scratch/local module。 |

## 常见 Engine Provided 参数

- `Engine.*`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.DeltaTime`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Emitter.ID`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Emitter.InstanceSeed`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Emitter.NumParticles`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Emitter.SimulationPosition`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Emitter.SpawnCountScale`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Emitter.TotalSpawnedParticles`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.ExecIndex`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.ExecutionCount`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.GlobalSpawnCountScale`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.GlobalSystemCountScale`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.InverseDeltaTime`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.NumSystemInstances`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.ExecutionState`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.LODDistance`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.LODDistanceFraction`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.LWCTile`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.Position`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.Rotation`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.Scale`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemLocalToWorld`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemLocalToWorldNoScale`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemLocalToWorldTransposed`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemWorldToLocal`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemWorldToLocalNoScale`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemWorldToLocalTransposed`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemXAxis`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemYAxis`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.SystemZAxis`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.TimeSinceRendered`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Owner.Velocity`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.QualityLevel`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.RealTime`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.Age`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.CurrentTimeStep`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.NumEmitters`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.NumEmittersAlive`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.NumParticles`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.NumTimeSteps`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.RandomSeed`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.SignificanceIndex`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.TickCount`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.System.TimeStepFraction`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.Time`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。
- `Engine.WorldDeltaTime`：Niagara 引擎注入的运行时参数，按命名空间含义读取，不作为普通 User 参数手写。

## 使用规则

- `Engine.*` 通常不要手动创建同名 User 参数。
- 写入 User 参数时使用 `User.` 命名空间，并通过导出 JSON 读回确认类型。
- Particle / Emitter / System 属性要在正确 stage 写入。
- 向量和颜色使用结构化文本，例如 `(X=...,Y=...,Z=...)`、`(R=...,G=...,B=...,A=...)`。
