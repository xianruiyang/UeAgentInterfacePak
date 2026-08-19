# 02-2-Houdini体积对象的理解

# 02-2-Houdini体积对象的理解

## 关键术语

- `GPU`、`UV`、`Houdini`、`Smoke`、`材质`、`碰撞`、`速度`、`烟雾`、`火焰`、`attribadjustvector_velocity`、`Niagara`、`Velocity`、`Material`、`系统`、`蓝图`、`用户参数`、`Niagara System`、`Emitter`

## 分段知识

### 00:00:00-00:02:59 Smoke

- 本段定位：Smoke。
- 知识点：写作的结构现在这样分开的结构 被认为是最早使用的那个版本的结构 所以这里的fibelow就是fx self 就像上面这种self 可以看作是和以前一样。
- 知识点：预设已经设置好了 然后这里可观察到的选项设置结构 和我们即将使用的obj中的fibelow solver 节点的构成有些不同 所以这个fibelow。
- 知识点：烟雾效果通常依赖较长 Lifetime、透明度衰减、噪声扰动和柔和的材质混合。
- 知识点：模拟预设 现在有91帧正在计算到91帧的这个过程 然后 现在比想象中快 但想停止时按ESC避免不必要的计算 做模拟工作时有时会无意中进行不必要的计算。
- 知识点：这时候一定要按SE键 然后就即使要按多次也要停止无用的计算 然后再查看 然后 这里现在是一个新创建的预设 正在使用objfibelow。
- 复现要点：Initialize Particle 通常负责 Lifetime、Color、Position、Sprite Size 或 Mesh Scale 等基础属性。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`Lifetime`、`材质`、`透明度`、`噪声`、`烟雾`。

**关键画面：**

这一帧是在 Houdini 里查看一个名为 `billowy_smoke` 的烟雾预设结构。左侧视口已经显示出一团正在上翻、分叉的体积烟雾；中间网络窗口则把这套烟雾从源场到烘焙输出的主链路完整摊开，说明作者首先是在讲“这一版 Smoke 预设的组织结构”。

中间网络中当前可直接确认的节点链如下：

- `pyrosource1`
- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `Object Merge`：`import_fields_from_dops`
- `Pyro Bake Volume`：`pyrolook_billowy_smoke`
- `Null`：`RENDER_Billowy_Smoke`

这些节点是自上而下串联的，表示流程是：

1. 先生成或准备 Pyro 源数据 `pyrosource1`
2. 通过 `attribadjustvector_velocity` 调整 `v / velocity`
3. 用 `volumerasterizeattributes` 把属性栅格化为体积字段
4. 再由 `import_fields_from_dops` 从 DOP 模拟里把字段取回到当前几何网络
5. 交给 `pyrolook_billowy_smoke` 做体积外观烘焙/材质化处理
6. 最终输出到 `RENDER_Billowy_Smoke`

右侧参数面板当前显示的是 `Object Merge import_fields_from_dops`，能直接确认：

- `Number of Objects = 3`
- `Enable Merge 1`：启用
  - `Object 1 = *e_simulation:* / density`（前缀部分可见，明确是导入 `density` 字段）
- `Enable Merge 2`：启用
  - `Object 2 = *smoke_simulation:* / vel`（明确是导入 `vel` 字段）
- `Enable Merge 3`：启用，但当前对象路径未填写完成
- `Transform = Into This Object`
- `Add Path Attribute`：启用

左侧视口时间轴停在第 `91` 帧，和正文“现在有 91 帧正在计算到 91 帧的过程”一致，说明这是在一个已运行到中段的 Smoke 模拟上查看网络。

这张图表达的是：作者把当前使用的 Billowy Smoke 预设拆成“源数据构建、速度调整、体积栅格化、从 DOP 取回字段、Pyro Bake Volume 烘焙外观、最终输出”这几个明确层次，让读者先理解现在常用的 Houdini 体积烟雾结构，再去讨论后面 Niagara 侧的材质、生命周期和烟雾呈现方式。
这一帧继续停在 `billowy_smoke` 网络，但视角更进一步，重点切到实际驱动体积求解的 `pyrosolver1` / `pyrosolver_billowy_smoke` 节点，以及右侧 `Pyro Solver pyrosolver1` 的参数页。左侧视口里现在只有一团较小、贴近底部的烟雾体，时间轴停在第 `1` 帧，说明这是刚开始或刚重置后的求解状态。

中间网络当前可直接确认的链路为：

- `smoke_base1`（节点标签上方显示 `Torus`）
- `pyrosource2`
- `attribadjustvector_velocity1`
- `volumerasterizeattributes1`
- `pyrosolver_billowy_smoke`
- `Pyro Bake Volume pyrolook_billowy_smoke1`
- `Null RENDER_Billowy_Smoke1`

左侧另有一枚绿色节点 `pyrosolver1`，其下方标签显示 `0.1`，说明作者同时保留了基础求解器实例作为对照或上层封装引用。

右侧 `Pyro Solver pyrosolver1` 当前位于 `Output` 页签，可直接确认的参数如下：

- 顶部控制
  - `Start Frame = 1`
  - 有 `Reset Simulation` 按钮
  - 有 `Quick Setups` 下拉
- `General`
  - `Voxel Size = 0.1`
  - `Velocity Voxel Scale = 1`
  - `Time Scale = 1`
- `Simulation`
  - `Simulation Type = Sparse`
  - `Global Substeps = 1`
  - `Min Substeps = 1`
  - `Max Substeps = 1`
  - `CFL Condition = 1`
  - `Advection-Reflection = Disabled`
  - `Cache Memory (MB) = 5000`

这张图表达的是：作者正在说明当前常用的 Houdini 烟雾求解器已经大幅简化，大部分关键控制都能直接在 `Pyro Solver` 参数面板里看到和修改，尤其是 `Sparse` 类型、`Voxel Size`、`Substeps` 与缓存内存这类决定模拟开销和精度的核心项。结合正文“想停止时按 ESC 避免无用计算”“主要会使用这个求解器”的上下文，这一帧的重点就是告诉读者：做 Smoke 时先学会控制求解器的计算规模，比盲目让模拟一直跑下去更重要。
这一帧进一步钻进了 `pyrosolver_billowy_smoke` 内部的 `dopnet1` 动态网络，用来展示当前 Smoke 预设在 DOP 层实际上覆盖了哪些求解与开关结构。左侧视口显示的是一个环形/甜甜圈状的浅色烟雾体，说明当前源体是环形基底；中间网络则不再是简单的一条 SOP 链，而是多分支汇入的 DOP 求解网络。

中间网络里当前能直接辨认出的关键节点包括：

- `source_volumes`
- `volumeinstancesource1`
- `sopsolver5`
- `gasrest2field1`
- `sopsolver2`
- `gasintermittentsolve1`
- `speed_field1`
- `sopsolver4`
- `enableSolver1`
- `source_density_limit1`
- `minimal_source`
- 多个 `switch` / `merge`
- 最终汇入底部的 `pyro_solver`

从连线关系上能确认几点：

- 这是一个多分支汇流到 `pyro_solver` 的网络，而不是单个源节点直接接求解器
- 网络里显式存在多个 `switch` 和 `enableSolver`/`gasintermittentsolve` 一类的控制节点，说明作者强调的是“为了覆盖不同情况，内部预设比表面看到的更复杂”
- `source_volumes`、`volumeinstancesource1`、`source_density_limit1`、`minimal_source` 等节点名表明，这一套网络同时处理源体积注入、实例化源、密度限制和最小化源配置

右侧参数面板当前显示的是 `ROP Output output1`，能直接确认：

- `Start/End/Inc = 1 / 240 / 1`
- 有 `Save to Disk`
- 有 `Save to Disk in Background`
- `Render with Take = (Current)`
- `Output File` 使用 `$HIP / $HIPNAME / opname(...)` 一类变量表达式
- `Output Every Sim Frame Using $SF`：启用
- `Create Intermediate Directories`：启用
- `Initialize Simulation OPs`：未启用
- `Alfred Style Progress`：未启用

这张图表达的是：虽然外层 `Pyro Solver` 面板看起来已经足够简洁，但其内部 `dopnet1` 仍然是为多种模拟场景预留了大量分支控制、源处理和开关逻辑的复杂网络。结合正文“参数化后都拿出来了”“以后学习其他预设时不会混乱”“这个结构也要多少了解一些”的意图，这一帧是在提醒读者：日常工作可以主要使用外层简化求解器，但理解内部 DOP 网络如何组织源、限制和附加求解器，才能真正知道这个 Smoke 预设为什么能覆盖不同情况。

### 00:03:03-00:05:56 GPU、UV

- 本段定位：GPU、UV。
- 知识点：参数化后都拿出来了 在锁上 然后 所以现在在里面用网络在无求解器里能看到的选项 大部分都能在这里控制 这里有个写着sparse的部分 在网络里。
- 知识点：现在有个写着sparse的求解器 还有普通的求解器 这是旧的求解器 标记为的部分可以看作是18.5版本 UV break 里面是做得更轻量。
- 知识点：质量也更高了 视觉上 这个完全可以用GPU计算 用GPU也能确认 那为了快速工作主要会使用这个求解器 不过这个结构也跟您说一下 对这个结构也要多少了解一些。
- 知识点：以后其他 其他布丁学习的时候 这个为什么是这样不会产生混乱 已经解释过了 最近这个求解器用的比较多 比如说简单的工作之类的情况下 需要像视频那样细节设置的复杂设置时。
- 知识点：有时也会用到这部分 有时也会用到这部分 我们只用这个求解器 就能做出想要的样子 就是 这样知道 然后 非常简洁吧 这里一眼就能全看到。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`GPU`。

**关键画面：**

这一帧把注意力从上一段的整体 Smoke 链路收缩到真正负责当前预设的核心求解器 `pyrosolver_billowy_smoke`。左侧视口里显示的是一个由大量点构成的环形/甜甜圈状源体，说明当前网络仍然以 Torus 体积作为烟雾注入基础；中间则把 `volumerasterizeattributes`、`pyrosolver_billowy_smoke`、`pyrolook_billowy_smoke1`、`RENDER_Billowy_Smoke1` 这条主干链放大展示。

中间网络当前能直接确认：

- `attribadjustvector_velocity`
- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
  - 节点下方标签：`0.1`
- `Pyro Bake Volume pyrolook_billowy_smoke1`
- `Null RENDER_Billowy_Smoke1`

这表明当前工作流已经不是直接使用旧版普通求解器，而是通过一个专门封装过的 `pyrosolver_billowy_smoke` 预设节点，把前面的速度调整与体积栅格化结果直接送入稀疏烟雾解算。

右侧参数面板标题显示的是 `Pyro Solver pyrosolver_billowy_smoke`，仍在 `Output` 页签，当前可直接确认的数值与上一段一致：

- `Voxel Size = 0.1`
- `Velocity Voxel Scale = 1`
- `Time Scale = 1`
- `Simulation Type = Sparse`
- `Global Substeps = 1`
- `Min Substeps = 1`
- `Max Substeps = 1`
- `CFL Condition = 1`
- `Advection-Reflection = Disabled`
- `Cache Memory (MB) = 5000`

这张图表达的是：当前真正推荐使用的是这个 `Sparse` 型的烟雾求解器封装，而不是再回到旧式结构里逐个拼接复杂解算器。结合本段“写着 sparse 的部分可以看作更轻量”“质量也更高”“这里一眼就能全看到”的上下文，这一帧就是在强调：对日常工作来说，核心关注点已经收敛到 `pyrosolver_billowy_smoke` 这类轻量、高质量、可直接控制的求解器节点本身。
这一帧把旧式求解器 `pyrosolver1` 和当前主用的 `pyrosolver_billowy_smoke` 同时摆在一个视图里进行对照。左侧视口显示的是一团更平滑的环形烟雾体，而中间网络则清楚展示了从 `smoke_base1` 到 `RENDER_Billowy_Smoke1` 的新链路，同时在左下保留了一个独立的 `pyrosolver1` 作为参照。

当前可直接确认的节点关系如下：

- 主链
  - `smoke_base1`（标签上方标注 `Torus`）
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke`
  - `Pyro Bake Volume pyrolook_billowy_smoke1`
  - `Null RENDER_Billowy_Smoke1`
- 对照节点
  - `pyrosolver1`

图中两个求解器节点下方都显示 `0.1`，说明它们至少在当前演示里共享同样的基础体素尺寸级别；但真正接在主链里的只有 `pyrosolver_billowy_smoke`，也就是当前推荐使用的那条稀疏链路。

右侧参数面板依旧是 `Pyro Solver pyrosolver_billowy_smoke`，当前可直接确认：

- `Simulation Type = Sparse`
- `Voxel Size = 0.1`
- `Velocity Voxel Scale = 1`
- `Time Scale = 1`
- `Global Substeps = 1`
- `Min Substeps = 1`
- `Max Substeps = 1`
- `CFL Condition = 1`
- `Cache Memory (MB) = 5000`

结合正文“这个完全可以用 GPU 计算”“为了快速工作主要会使用这个求解器”“最近这个求解器用得比较多”的上下文，这张图表达的是：作者不是简单列出两个求解器，而是在明确比较后给出选择结论。也就是，旧版普通 `pyrosolver1` 结构仍然存在并值得理解，但在当前版本工作流里，实际更常用的是这条围绕 `pyrosolver_billowy_smoke` 构建的稀疏求解链，因为它更简洁、速度更快，也更适合后续接 GPU 或快速迭代。
这一帧继续停在同一条稀疏烟雾链上，但当前真正被选中并展开参数的是 `Pyro Bake Volume pyrolook_billowy_smoke1`。左侧视口里的环形烟雾已经不再只是点云或稀疏体素可视化，而是呈现出更接近最终渲染的柔和体积外观，说明作者开始讲的是这个预设如何把解算结果快速转成可用的烟雾材质表现。

中间网络当前可直接确认的主链仍是：

- `volumerasterizeattributes`
- `pyrosolver_billowy_smoke`
- `Pyro Bake Volume pyrolook_billowy_smoke1`
- `Null RENDER_Billowy_Smoke1`

右侧参数面板标题显示为 `Pyro Bake Volume pyrolook_billowy_smoke1`，当前位于 `Smoke` 页签，可直接确认如下：

- `General`
  - `Assign Material = matnet/Pyro_Shader`
- `Smoke`
  - `Density Scale = 5`
  - `Smoke Color`：当前为一组偏暖灰棕色的颜色值，右侧有 `Use Ramp`
  - `Density Range = 0 ~ 1`
  - 有 `Compute Range` 按钮
  - `Smoke Color Ramp`
    - 颜色带从左到右是偏冷浅灰逐渐过渡到偏暖米灰
  - `Shadow Color`：接近白色
  - `Shadow Density = 1`
  - `Ambient Shadow Scale = 0.5`

左侧视口能看到的结果也与这些参数一致：烟雾整体是偏灰棕、边缘柔和、中心厚实的 Billowy 体积，而不是高饱和颜色或高对比火焰。

这张图表达的是：在当前 Houdini 体积工作流里，`Pyro Bake Volume` 节点已经把相当一部分最终 Smoke 外观控制集中到了一个地方，尤其是密度缩放、颜色坡度和阴影表现。结合本段“这里一眼就能全看到”“更轻量、质量更高”的意图，这一帧说明作者并不需要再手工搭一整套复杂体积材质网络，就能先用 `pyrolook_billowy_smoke1` 快速得到一个可工作的烟雾外观，再根据项目需要继续细调。

### 00:06:04-00:08:55 UV、材质、速度

- 本段定位：UV、材质、速度。
- 知识点：连滑板都表现出来了 可以说 这个Pyro Bake Volume这个节点 是为了和Pyro Solver一起使用 以便快速工作而制作的。
- 知识点：以前也有这种节点 但现在有这种节点 这种节点也没有 无条件在这里的材质中 单独用火制作材质使用。
- 知识点：这种过程也包含在这里 这里拆开看里面 可以看作是方便制作使用的节点 而且质量上以前对这部分也有点 以及在方面的材质。
- 知识点：或者做和定制 现在这些部分用起来方便多了 然后 在游戏领域积极利用这个节点 比起追求超高质量 工作效率和速度。
- 知识点：这些方面是不能忽视的 所以积极利用是好的 所以可以主要使用这部分 并会以结构进行 实力是 可以方便简单地看到这种 圆码结构和Pyro解算器的。
- 复现要点：材质侧要核对 Blend Mode、Opacity/Alpha、Emissive、UV/Panner、Depth Fade 或 SubUV/Flipbook 的真实连接。
- 核对对象：`材质`、`速度`、`火焰`、`冲击波`。

**关键画面：**

这一帧继续编辑 `Pyro Bake Volume pyrolook_billowy_smoke1`，但右侧已经从前一段的 `Smoke` 页切换到 `Scatter` 页。左侧视口中的体积不再是单纯的灰棕烟雾，而是内部开始出现明显的橙色高亮区域，说明作者正在讲怎样用 `Pyro Bake Volume` 直接把烟雾解算结果快速变成更像火焰/热区的可视化外观。

中间网络当前主链仍可确认：

- `smoke_base1`
- `pyrosource2`
- `attribadjustvector_velocity1`
- `volumerasterizeattributes1`
- `pyrosolver_billowy_smoke`
- `Pyro Bake Volume pyrolook_billowy_smoke1`
- `Null RENDER_Billowy_Smoke1`

右侧 `Pyro Bake Volume pyrolook_billowy_smoke1` 当前位于 `Scatter` 页签，能直接确认的参数如下：

- `Scatter`
  - `Intensity Scale = 250`
  - `Hot Core Scale = 0`
  - `Color Mode = Color Ramp`
  - `Source Range = 0.1 ~ 1`
  - 有 `Compute Range` 按钮
  - `Scatter Color Ramp`
    - 颜色带从左到右大致是：深棕/暗红 -> 橙色 -> 浅橙/亮橙
- 下方可见控制分组
  - `Blur`
  - `Masking`

左侧视口结果与这些参数直接对应：烟雾团内部带有暖色发光区，但又没有做成纯白高温火芯，因为 `Hot Core Scale` 当前就是 `0`。这意味着作者是在保留烟雾体积轮廓的前提下，仅通过 `Scatter` 增加受热和发亮的层次。

这张图表达的是：`Pyro Bake Volume` 不只是给 Smoke 指定一个基础材质，它还把火焰/热散射外观整合进同一个快速控制界面里。结合正文“这个节点是为了和 Pyro Solver 一起使用，以便快速工作”“单独用火制作材质的过程也包含在这里”的上下文，可以确认这一帧是在强调：许多原本要单独搭材质网络做的火焰色散和热区处理，现在可以直接在 `Scatter` 页通过强度和颜色坡度完成。
这一帧继续使用同一套 `pyrosolver_billowy_smoke + pyrolook_billowy_smoke1` 组合，但时间轴已经推进到第 `54` 帧，左侧视口里可以直接看到烟雾体积和内部橙色热区被一并烘焙出来后的中段效果。相比上一张更像是参数讲解，这一张更偏向验证 `Pyro Bake Volume` 在实际播放中是否能稳定给出“烟雾 + 火焰感”的组合外观。

中间网络当前仍然是同一条主链：

- `smoke_base1`
- `pyrosource2`
- `attribadjustvector_velocity1`
- `volumerasterizeattributes1`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke1`
- `RENDER_Billowy_Smoke1`

图中还能看到左侧保留着对照节点 `pyrosolver1`，而真正接在主链上的仍是 `pyrosolver_billowy_smoke`。这说明作者不是在切换回旧结构，而是在持续利用新求解器与 Bake 节点一起工作。

右侧参数面板当前仍停留在 `Pyro Solver pyrosolver_billowy_smoke` 的基础页，能确认的核心状态保持不变：

- `Simulation Type = Sparse`
- `Voxel Size = 0.1`
- `Global Substeps = 1`
- `Min Substeps = 1`
- `Max Substeps = 1`
- `Cache Memory (MB) = 5000`

左侧视口结果则提供了这张图最关键的验证信息：

- 烟雾外轮廓仍然保持柔和、体积感较强的 Billowy 形态
- 体积内部存在连续的橙色高亮区，而不是零散闪点
- 火焰/热区并没有完全吞掉烟雾体本身，二者仍是叠加关系

这张图表达的是：`Pyro Bake Volume` 的价值不只是“把参数集中起来”，而是它确实能在播放过程中的中段帧稳定输出一个既保留烟雾体积、又带有热散射和火焰感的可用结果。结合正文“以前这些部分要单独做材质”“现在方便多了”“在游戏领域积极利用这个节点”的意思，这一帧是在用实际结果证明：这条更轻量的 Bake 工作流足以满足很多实时效果制作需求。
这一帧继续停在同一条 `billowy_smoke` 主链上，但画面右侧弹出了 Houdini 的 `TAB Menu`，并且搜索词是 `pyro`。这说明作者已经从“当前这个 Pyro Bake Volume 怎么用”进一步切到“这些节点其实都能视为预设化的 Pyro 组件入口”，也就是在交代这套结构的来源和扩展方式。

中间网络当前仍能直接确认：

- `smoke_base1`
- `pyrosource2`
- `attribadjustvector_velocity1`
- `volumerasterizeattributes1`
- `pyrosolver_billowy_smoke`
- `Pyro Bake Volume pyrolook_billowy_smoke1`
- `Null RENDER_Billowy_Smoke1`
- 左侧保留对照节点：`pyrosolver1`

右侧 `TAB Menu` 中当前可辨认出的 Pyro 相关节点/预设包括：

- `Pyro Solver`
- `Pyro Source`
- `Pyro Trail`
- `Pyro Bake Volume`
- `Pyro Burst Source`
- `Pyro Configure Bonfire`
- `Pyro Configure Fireball`
- `Pyro Configure Shockwave`
- `Pyro Post-Process`
- `Pyro Source Instance`
- `Pyro Source Pack`
- `Pyro Source Spread`
- `Pyro Spawn Sources`
- `Pyro Trail Path`
- `Pyro Trail Source`
- `Pyro Configure Aerial Explosion`
- `Pyro Configure Billowy Smoke`
- `Pyro Configure GPU Torch`
- `Pyro Configure Ground Explosion`
- `Pyro Configure Spreading Fire`
- `Pyro Muzzle Flash Source`
- `Pyro Scatter from Burst`
- `Pyro Configure GPU Ground Explosion`

当前高亮的菜单项是：

- `Pyro Configure Ground Explosion`

同时在菜单下方 `History` 区域还能看到：

- `Pyro Configure Billowy Smoke`
- `Pyro Solver`
- `Sphere`
- `Test Geometry: Pig Head`
- `VDB from Polygons`

这张图表达的是：作者想说明当前看到的 `Billowy Smoke` 链路、`Pyro Solver`、`Pyro Bake Volume`、以及将来要做的爆炸、火球、冲击波等结构，本质上都是 Houdini 提供的一组预设化 Pyro 配置入口。结合正文“这些都可以看作是使用预设的火焰求解器制作的部分”“比追求超高质量，工作效率和速度不能忽视”的意思，这一帧是在强调：理解并善用这些 `Pyro Configure ...` 预设，比从零手搭整套体积网络更适合游戏特效工作流。

### 00:09:00-00:11:58 烟雾、火焰

- 本段定位：烟雾、火焰。
- 知识点：后面有这种预设 然后 公示 现在越来越注重便利性 叫火人这种一式 以前为了做这种形状用Mids 先这样爆开的方式 然后 来做 那里 现在这样用体积属性。
- 知识点：换一下 用来做圆 把那些过程简化为一个节点 有爆炸的某种形态 这里每个点都有体积 快现在跑起来 可以看作转换成属性 像这样 所以就有了那些字段。
- 知识点：现在可以看作模拟在进行 模拟的部分这样着思 非常好 这个过程也包含在这里 嗯 这样然后这种爆炸 烟雾火焰的原厂应用厂 也都有点不同 在表现 爆炸或火焰的部分。
- 知识点：这种叫Flame的厂 这种叫Divergence的厂 其实必不可少 所以一起确认这些厂的差异也挺好的 现在正在播放 爆炸或类似爆炸的情况就是这样。
- 知识点：通过火焰领域 通过发散领域 膨胀或者扩散这些火的表达 这些领域需要存在 因为有些人 所以这些差异以后 就通过实力可以进行 这些资源也有 但资源也很多。
- 核对对象：`烟雾`、`火焰`、`冲击波`。

**关键画面：**

这一帧从前面的 `billowy_smoke` 讲解切换到了更明确的爆炸/火球预设链。中间网络右侧已经出现一条新的节点链，核心从 `pyroburstsource` 开始，经过 `volumerasterizeattributes2`、`pyrosolver_fireball`、`pyrolook_fireball`，最终输出到 `RENDER_Simple_Fireball`。这说明作者开始拿 Houdini 提供的火球/爆炸型预设来解释烟雾、火焰和冲击波的差异。

中间网络当前能直接确认的节点链如下：

- 左侧仍保留此前的烟雾链局部：
  - `smoke_base1`
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke`
- 新出现的爆炸/火球链：
  - `pyroburstsource`
  - `volumerasterizeattributes2`
  - `pyrosolver_fireball`
    - 节点下方标签：`0.15`
  - `Pyro Bake Volume pyrolook_fireball`
    - 当前显示 `Viewing Output 1`
  - `Null RENDER_Simple_Fireball`

右侧参数面板当前显示的是 `Pyro Burst Source pyroburstsource`，位于 `Burst Shape` 页签，能直接确认的参数如下：

- 顶部
  - `Guide Display = None`
  - `Randomization By = Point Number`
- `Burst Shape > Shape`
  - `Burst Type = Explosion`
  - `Shape Offset = 0`
  - `Initial Size = 1`
  - `Direction = (0, 1, 0)`
  - `Spread Angle = 90`
  - `Roundness = 0.5`
- `Trailing`
  - `Number of Trailings = 250`
  - `Trailing Separation = 0.1`
  - `Trailing Length = 1`
  - `Trailing Thickness = 0.25`

左侧视口当前是空的，说明这个时刻更偏向参数搭建阶段，而不是已经播放到明显可见的火球结果。

这张图表达的是：做爆炸或火球时，作者不再从通用 `pyrosource + velocity + rasterize` 结构一步步搭起，而是直接用 `pyroburstsource` 这种更具爆发语义的预设源节点来构造初始形状与拖尾分布。结合正文“叫火人这种一式”“以前为了做这种形状要先爆开再做”“现在把那些过程简化为一个节点”的上下文，这一帧是在强调：Houdini 已经把很多常见爆炸形态预设化，能用更少节点快速生成可用的爆炸场。
这一帧继续停在火球/爆炸链，但焦点已经从 `pyroburstsource` 转移到 `pyrosolver_fireball` 本身。左侧视口能看到一团较矮、较紧凑的烟雾/火焰体；中间网络则把 `pyroburstsource -> volumerasterizeattributes -> pyrosolver_fireball -> pyrolook_fireball -> RENDER_Simple_Fireball` 这条链清楚摊开。右侧最重要的是 `Pyro Solver pyrosolver_fireball` 的 `Source Volumes`，它直接说明这个爆炸求解器吃哪些字段。

中间网络当前可直接确认：

- 左侧保留的烟雾链：
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke`
  - `pyrolook_billowy_smoke1`
- 右侧当前正在讲解的火球链：
  - `pyroburstsource`
  - `volumerasterizeattributes2`
  - `pyrosolver_fireball`
    - 标签：`0.15`
  - `pyrolook_fireball`
    - 当前显示 `Viewing Output 1`
  - `RENDER_Simple_Fireball`

右侧 `Pyro Solver pyrosolver_fireball` 当前位于 `Source Volumes`，可直接确认：

- `Number of Sources = 5`
- `Source 1: density`
  - `Operation = Maximum`
  - `Source Volume = density`
  - `Target Field = density`
  - `Source Scale = 1`
- `Source 2: temperature`
  - `Operation = Pull`
  - `Source Volume = temperature`
  - `Target Field = temperature`
  - `Source Scale = 1`
  - `Acceleration Strength = 50`
  - `Deceleration Strength = 0`
- `Source 3: flame`
  - `Operation = Maximum`
  - `Source Volume = burn`
  - `Target Field = flame`
  - `Source Scale = 1`
- `Source 4: divergence`
  - `Operation = Add`
  - `Source Volume = burn`
  - `Target Field = divergence`
  - `Source Scale = 10`
- `Source 5: vel`
  - `Operation = Pull`
  - `Source Volume = v`
  - `Target Field = vel`
  - `Source Scale = 5`
  - `Acceleration Strength = 1`

这张图表达的是：火球/爆炸预设和单纯烟雾预设的关键差异，不只是外观节点不同，而是在求解器输入字段上就更完整。除了 `density` 和 `vel`，它还明确把 `temperature`、`flame`、`divergence` 都作为独立驱动项接进求解器。结合正文“这种叫 flame 的场、叫 divergence 的场其实必不可少”“通过火焰领域、发散领域去表达膨胀和扩散”的意思，这一帧是在强调：想让爆炸或火焰真正有冲击、膨胀和燃烧感，这几个字段必须被一起送进解算。
这一帧继续停留在火球/爆炸链，但左侧视口已经显示出非常明确的蘑菇云式火球结果：底部有一根上升的柱状热流，上方则膨成多个高亮火团组成的爆炸云。中间网络仍是 `pyroburstsource -> volumerasterizeattributes2 -> pyrosolver_fireball -> pyrolook_fireball -> RENDER_Simple_Fireball` 这条链，而右侧弹出的 `TAB Menu` 则进一步说明：除了当前这个 `pyroburstsource`，Houdini 还提供了很多其他 Source 预设可直接试用。

中间网络当前可直接确认：

- `pyroburstsource`
- `volumerasterizeattributes2`
- `pyrosolver_fireball`
  - 标签：`0.15`
- `pyrolook_fireball`
  - `Viewing Output 1`
- `Null RENDER_Simple_Fireball`

左侧视口结果提供了本张图最关键的效果验证：

- 爆炸已经不只是单纯球形火团，而是发展成带立柱和上方膨胀云团的蘑菇云轮廓
- 火焰高亮区在每个团块内部都有明显斑驳变化，而不是一整块均匀发光
- 这说明当前 `flame / divergence / temperature` 这套字段输入已经开始对形体膨胀和内部热区结构产生效果

右侧 `TAB Menu` 当前搜索词是 `source`，可辨认出的 Source 类节点/预设包括：

- `Collision Source`
- `Crowd Source`
- `Debris Source`
- `Grain Source`
- `MPM Source`
- `Ocean Source`
- `Pyro Source`
- `Whitewater Source`
- `FLIP DOP Source`
- `FLIP Source: Instant`
- `FLIP Source: Pressure`
- `FLIP Source: Velocity`
- `Pyro Burst Source`
- `Pyro Shockwave Source`
- `Pyro Source Instance`
- `Pyro Source Pack`
- `Pyro Source Spread`
- `Pyro Spawn Sources`
- `Pyro Trail Source`
- `Pyro Muzzle Flash Source`

当前高亮的是：

- `Pyro Muzzle Flash Source`

这张图表达的是：当前这个蘑菇云火球并不是唯一的 Pyro Source 预设形式，Houdini 还准备了 Shockwave、Trail、Muzzle Flash、Spread 等多种源节点，分别面向不同类型的爆炸和火焰形态。结合正文“还有扩散源”“要不要一个一个试着做一下”的意思，这一帧是在鼓励读者：先理解 `pyroburstsource` 是怎样生成爆炸基底的，再继续尝试其他 Source 预设，就能更快拓展出不同风格的烟雾与火焰效果。

### 00:12:01-00:14:58 烟雾

- 本段定位：烟雾。
- 知识点：这样试着做一下确认一下 请看一下 得把分区大小调在台地 就能以不费力的性能查看 像冲击波爆炸这种情况就会这样出现 再继续下去的话 应该可以。
- 知识点：更简单地确认一下 现在体速变得很大 然后分辨率就像被破坏了一样 因为要用很少的体速来表达 所以会变得非常简单 像这种冲击波源在这里 振动波源是专门用来表现。
- 知识点：振动波形态的节点 这个源节点是为了方便使用 像火球那样的扩散型爆炸而设计的 这些选项我们稍后可以一起过一遍 我们可能无法一下子看完所有这些。
- 知识点：振动波或轨迹之类的 地面 看地面爆炸就是这里 这样对指痕的表达 用源在制作 这样 在这里 在虚幻中制作轨迹资源时 烟雾会这样生成 像爆炸一样碰碰碰。
- 知识点：这些源节点也是为了方便而制作的 所以这些源是如何构成的 确认一下也不错 基本上因为经常用爆炸之类的场景 所以 视频中 侦察是必须的。
- 复现要点：Spawn Rate、Burst 或 Spawn Per Unit 决定生成节奏，需要和 Lifetime 配合控制屏幕密度。
- 核对对象：`烟雾`、`冲击波`。

**关键画面：**

这张图展示的是 Houdini 中用于制作火球/烟雾体积源的基础网络与预览结果。

左侧视口显示当前帧的体积预览：一个由多个球团堆叠形成的亮黄色火球云团，下方带有向上翻卷的烟柱，整体被包在体积模拟边界框内。时间轴停在第 38 帧。

中间网络从上到下依次为：

`pyroburstsource` → `volumerasterizeattributes2` → `pyrosolver_fireball` → `pyrolook_fireball` → `RENDER_Simple_Fireball`

可据此理解这套流程：

- `pyroburstsource`：生成爆炸/火球用的体积源。
- `volumerasterizeattributes2`：把源数据栅格化为体积属性，供后续 Pyro 求解器读取。
- `pyrosolver_fireball`：执行火球类烟火体积模拟。
- `pyrolook_fireball`：进行 Pyro Bake Volume 外观整形与渲染外观调整。
- `RENDER_Simple_Fireball`：作为最终输出节点。

右侧参数面板当前选中的是 `pyroburstsource` 节点，处于 `Source` 页签，可确认的关键设置为：

- `Source Type` 设为 `Individual Volumes`
- `Number of Sources` 为 `5`
- 下方列出了 `Volume 1` 到 `Volume 4` 的折叠项，表示该节点会管理多组体积源

这张图的作用是说明：教程中的烟雾/冲击波素材并不是直接从单个粒子发射器开始，而是先在 Houdini 里通过 `pyroburstsource` 组织多组体积源，再经由体积栅格化、Pyro 求解和外观烘焙，得到可作为爆炸烟雾基础的火球体积结果。
这张图展示的是用于“火球扩散爆炸”效果的源节点拆分方式：一条支路专门生成火球源，另一条支路处理冲击波相关属性，之后再统一合并进入同一个 Pyro 求解器。

左侧视口当前显示的是一团较小的绿色/蓝色源点分布，时间轴停在第 10 帧，用来检查源体积或源点的初始形态。

中间网络可确认的结构如下：

- 左侧支路：`pyroburstsource_fireball` → `volumerasterizeattributes3`
- 右侧支路：上方一个 `pyroburstsource_*` 节点 → `adjust_shockwave*` → `volumerasterizeattributes*`
- 两条支路汇入：`merge_all_sources`
- 合并后进入：`pyrosolver_fireball_shockwave`

从这个结构可以直接看出，教程不是只做单一烟雾，而是把“火球体积源”和“冲击波修正后的体积源”分别准备，再通过 `merge_all_sources` 合并，最后交给同一个求解器统一模拟，以得到既有主体火球又有冲击扩散感的爆炸烟雾。

右侧参数面板当前选中的是 `Pyro Burst Source` 节点，位于 `Burst Shape` 页签，可确认的参数为：

- `Burst Type`：`Explosion`
- `Shape Offset`：`0`
- `Initial Size`：`1`
- `Direction`：`1`
- `Spread Angle`：`90`
- `Roundness`：`0.5`

同页签下方 `Trailing` 区域还能确认：

- `Number of Trailings`：`250`
- `Trailing Separation`：`0.1`
- `Trailing Length`：数值较小，截图可见为默认附近，但具体值不够清晰
- `Trailing Thickness`：`0.25`

这张图的重点是说明：`pyroburstsource_fireball` 这类源节点本身已经封装了适合火球型扩散爆炸的形状参数与拖尾分布参数，调节这些参数可以直接改变火球爆开的初始体积轮廓，以及后续烟雾与冲击波在求解器中的输入形态。
这张图展示的是地面爆炸烟雾的体积源合并方式，重点在于把多种体积字段按不同运算规则写入 Pyro Solver 的输入字段。

左侧视口显示的是分散在地面上方向四周抛出的白色短线状源点，时间轴停在第 34 帧，说明这里正在检查地面爆炸拖尾或碎散源的分布形态。

中间网络中，当前可确认的主链路为：

- `pyroburstsource_explosions` → `volumerasterizeattributes5` → `merge_for_sim` → `pyrosolver_ground_explosion`

右侧还能看到另一条参与合并的支路，包含：

- `pointreplicate_burst*`
- `offset_startframe`
- 一个 `pyrotrailsource*` 节点
- 后续经过属性调整与拆分节点，再并入 `merge_for_sim`

求解器下游还能确认：

- `merge_firetrails`
- `pyrolook_ground*`
- 最终输出 `RENDER_Ground*`

右侧参数面板当前选中的是 `Pyro Solver` 节点，位于 `Sources` 页签，`Source Type` 为 `Individual Volumes`，`Number of Sources` 为 `6`。截图中能可靠读出的前五组 `Source Volumes` 如下：

- `Source 1`
  - `Source Volume`：`density`
  - `Target Field`：`density`
  - `Operation`：`Add`
  - `Source Scale`：`0.1`
- `Source 2`
  - `Source Volume`：`trail_density`
  - `Target Field`：`density`
  - `Operation`：`Maximum`
  - `Source Scale`：`0.35`
- `Source 3`
  - `Source Volume`：`temperature`
  - `Target Field`：`temperature`
  - `Operation`：`Maximum`
  - `Source Scale`：`1`
- `Source 4`
  - `Source Volume`：`burn`
  - `Target Field`：`flame`
  - `Operation`：`Maximum`
  - `Source Scale`：`2`
- `Source 5`
  - `Target Field`：`divergence`
  - `Operation`：`Pull`
  - 源字段名称在截图中只能确认与 `burn` 相关，最后一组完整文本不够清晰

这张图的实际含义是：教程把主体爆炸密度、拖尾密度、温度、燃烧值等字段分开准备，再在 `Pyro Solver` 的 `Sources` 面板中逐项指定“写入哪个目标场、采用什么合并运算、缩放多少强度”。这样就能分别控制地面爆炸的主体烟团、拖尾烟丝、火焰强度和发散/回吸行为，而不是把所有体积信息粗暴地写进同一个字段。

### 00:15:03-00:17:58 碰撞

- 本段定位：碰撞。
- 知识点：现在把密度和轨迹密度分开的原因 是因为这里现在分成了两个源来制作 这样自定义自断只换成体积数据 拿去做模拟源用就行 这样动画化了源 这样拿加密货币就会这样。
- 知识点：如果这个角色有跳舞的动作 把它当做原材料使用 然后跳舞的过程中人体会不断漏烟 人体挥动手臂的动作等部分 也会产生碰撞 烟会快速移动 做成动画。
- 知识点：对吧 嗯 轻松想的时候 那样的话现在模拟制作吧 又想的太难 还有我没看的东西 那看看喷火吧 这个好像有键指 就是所以会越来越宽 占据这个区域的话。
- 知识点：只有这些黄点会着火 可以看作是喷火的模拟结构 所以这里可以连接输入 还有这些源。
- 复现要点：碰撞、GPU/CPU Sim、Bounds 和 Local Space 会影响可见性、性能和触发精度，复现时要单独检查。
- 核对对象：`碰撞`。

**关键画面：**

这张图说明在“碰撞”相关的地面爆炸模拟里，主体密度源和轨迹密度源是分开准备的，`volumerasterizeattributes5` 负责把其中一组源点栅格化为多个体积字段，再送入后面的模拟合并节点。

左侧视口显示的是一圈散开的白色短线状源点，分布在地面上方，时间轴停在第 34 帧。这说明当前查看的是碰撞或拖尾相关的离散源点，而不是最终烟雾体积。

中间网络中能确认的局部结构为：

- `pyroburstsource_explosions` → `volumerasterizeattributes5` → `merge_for_sim` → `pyrosolver_ground_explosion`

同一画面里还能看到另一条用于轨迹/拖尾的支路：

- `pointreplicate_burst*`
- `offset_startframe`
- `pyrotrail*`
- 经过属性调整和后续节点后，也会并入 `merge_for_sim`

右侧参数面板当前选中的是 `Volume Rasterize Attributes` 节点 `volumerasterizeattributes5`，可确认的关键设置为：

- `Attributes`：`density temperature burn v`
- `Source Attribute`：`source_name`
- `Visible Volumes`：`*`

`Filter` 区域可确认：

- `Filter`：`Gaussian`
- `Voxel Size`：`0.05`
- `Particle Scale`：`1`
- `Minimum Filter Size`：`0.75`

`Coverage` 区域可确认：

- `Coverage Scale`：`1`
- 勾选了 `Normalize by Clamped Coverage`
- `Attribute Rules` 中当前展示的是属性 `v`
- `Method`：`Weighted Average`

这张图的实际含义是：教程先把碰撞/爆炸源点拆成不同来源，再用 `volumerasterizeattributes5` 一次性输出 `density`、`temperature`、`burn` 和 `v` 等多个体积场。这样后面的 Pyro Solver 就能分别读取密度、温度、燃烧和速度信息，而不是只拿到单一体积，从而更容易把碰撞、拖尾和爆炸主体分开控制。
这张图展示的是一套更直接的“带碰撞的喷火/烟雾模拟”网络：左侧先从源几何生成 Pyro Source 点，再做热区和扩散处理，右侧单独准备碰撞源，最后两路一起送进 `pyrosolver2`。

中间网络从上到下可确认的主结构为：

- 上游输入 `source`
- `reference_configuration*`（Time Shift）
- `create_source_points`（Pyro Source）
- `create_hot_group`（Group Create）
- `make_region_hot`（Attribute Wrangle）
- `simulate_spread`（Pyro Source Spread）
- `rasterize`（Volume Rasterize Attributes）
- `pyrosolver2`

并行的碰撞支路为：

- `source` 另一输出连到 `collisionsource1`
- `collisionsource1` 再进入 `merge1`
- `rasterize` 的体积输出也进入 `pyrosolver2`
- `merge1` 的结果作为碰撞相关输入并入 `pyrosolver2`

从节点命名可以直接判断这套流程的意图：

- `create_source_points`：把输入几何转成可供燃烧/烟雾使用的发射点
- `create_hot_group` 与 `make_region_hot`：挑出需要着火的区域，并写入热区属性
- `simulate_spread`：让热区或火焰沿点集方向蔓延
- `rasterize`：把点属性转成求解器所需体积场
- `collisionsource1`：生成碰撞体积或碰撞相关场，供烟雾与角色/几何体交互

右侧参数面板当前选中的是 `Pyro Solver` 节点 `pyrosolver2`，位于 `Setup` 页签，可确认的参数为：

- `Voxel Size`：`0.005`
- `Velocity Voxel Scale`：`1`
- `Time Scale`：`1`

`Simulation` 区域可确认：

- `Simulation Type`：`Sparse`
- `Global Substeps`：`1`
- `Min Substeps`：`1`
- `Max Substeps`：`3`
- `CFL Condition`：`1`
- `Advection-Reflection`：`Single Project`
- `Reflection Amount`：`0.95`
- 勾选 `Cache Memory (MB)`，数值为 `5000`

这张图的重点是：碰撞不是在最终渲染阶段补上的，而是在体积求解阶段就通过 `collisionsource1` 作为一条独立输入支路并入求解器。这样角色动作、喷火方向或几何体阻挡都会在模拟阶段直接影响烟雾运动，而不是只改变外观。
这张图展示的是“只有局部区域着火”的源设置方式：用一个独立的盒体 `hot_region` 指定角色模型上哪些空间位置会被标记为高温区，然后这些高温区再传递给后续的 Pyro Source 与扩散节点。

左侧视口里显示的是一个猪头形状的线框几何体，说明这里的输入并不是简单球体，而是角色或模型网格本身。时间轴停在第 7 帧。

中间网络中可确认的空间关系与节点链为：

- 上游测试几何：`testgeometry_pighead1`
- 进入 `source`
- `source` 向下连接到 `create_source_points`
- `create_source_points` → `create_hot_group` → `make_region_hot` → `simulate_spread`
- `source` 另一条线连接到 `collisionsource1`
- `collisionsource1` 再连接到 `merge1`
- 一个独立的 `Box` 节点 `hot_region` 通过虚线引用方式参与热区定义
- 右上角还能看到 `sphere2`，但当前未接入主链

按照这张图可建立明确的空间合同：

- `subject`：角色网格 `testgeometry_pighead1` 与热区控制盒 `hot_region`
- `dimension`：三维 Houdini 对象空间
- `Fsemantic`：`hot_region` 不是最终可见物体，而是“哪些部位允许点燃/升温”的空间掩码
- `Fwrite`：通过 `create_hot_group` / `make_region_hot` 把盒体覆盖到的区域写成热区属性
- `Fread`：后续 `simulate_spread` 和体积栅格化节点读取这些热区属性，生成真正的燃烧/烟雾源
- `Fverify`：左侧角色线框加右侧 `hot_region` 节点共同说明，着火区域依赖模型局部空间中的盒体位置，而不是全模型统一点燃
- `conversion_chain`：角色几何 `source` → 热区盒体 `hot_region` 参与分组/属性写入 → 热区属性传给 Pyro Source 链路 → 再进入碰撞与体积模拟

右侧参数面板当前选中的是 `Box` 节点 `hot_region`，可确认的参数为：

- `Primitive Type`：`Polygon`
- `Connectivity`：`Quadrilaterals`
- 勾选 `Consolidate Corner Points`
- `Size`：`1, 1, 1`
- `Center`：`0, 0, 0`
- `Rotate`：`0, 0, 0`
- `Uniform Scale`：`0.05`

这张图的重点是：教程并不是让整个模型都持续喷火，而是先放置一个很小的热区盒体，只让该盒体覆盖到的局部区域成为火焰/烟雾源。这样模型挥手、跳舞或移动时，碰撞与燃烧都会集中发生在被指定的身体局部，便于做“身体某处漏烟、擦出火焰、局部受击冒烟”这类效果。

### 00:18:06-00:20:19 烟雾

- 本段定位：烟雾。
- 知识点：在这个模拟中 因为是不需要烟的火的表现 那个 所以没有什么单独的密度之类的 然后 所以根据是什么类型的 什么表现的模拟 这种源的结构也会改变。
- 知识点：看看这点 还有这种差异烟雾和爆炸的 原厂设置 看看这些 所以最终利用这种源输入中的原厂 烟雾如何动画化 烟雾形态如何形成。
- 知识点：这些都由它负责 在一个球解器中 最重要的就是这个球解器的作用 而且这些假体积或渲染之类的过程 并不那么难 其实 当在调整这个球解器的数值时。
- 知识点：可以感受到形状是如何变化的 就是 可以看作是对这些部分的训练 这些部分几乎就是全部了 所以这种形状怎么制作 用什么相机角度拍摄 怎么带到虚幻里使用。
- 知识点：可以看作是一场战斗 这次时间像这样简单的体积形态 模拟的种类多种案例一起看看 继续看了一下这个流程 别想得太复杂 别想这种结构 按这种案例一起做一下看看。
- 核对对象：`烟雾`。

**关键画面：**

这张图展示的是“只做火焰、不单独做烟密度”的局部燃烧源设置方式：角色模型上某一块被 `hot_region` 选中的区域会持续提供燃烧和温度场，再由 `pyrosolver2` 直接读取这些字段驱动火焰形态。

左侧视口显示一个角色/雕像样式的点云模型，模型上半部被橙黄色区域覆盖，外面还有一个蓝色线框盒体。可据此判断：

- 黑色点云是原始几何或采样后的源模型
- 橙黄色区域是当前被认定为“热区/着火区”的部分
- 蓝色线框盒体对应热区控制范围

中间网络延续前一组的局部热区流程，可确认的链路为：

- `source`
- `reference_configuration*`
- `create_source_points`
- `create_hot_group`
- `make_region_hot`
- `simulate_spread`
- `rasterize`
- `collisionsource1`
- `merge1`
- `pyrosolver2`
- 旁路存在 `hot_region` 盒体节点，以虚线关系参与热区控制

右侧参数面板当前选中的是 `pyrosolver2`，位于 `Sourcing` 页签，`Source Type` 为 `Individual Volumes`，可确认 `Number of Sources` 为 `2`，两组体积输入规则分别是：

- `Source 1: flame`
  - `Operation`：`Maximum`
  - `Source Volume`：`burn`
  - `Target Field`：`flame`
  - `Source Scale`：`1`
- `Source 2: temperature`
  - `Operation`：`Pull`
  - `Source Volume`：`temperature`
  - `Target Field`：`temperature`
  - `Source Scale`：`1`
  - `Acceleration Strength`：`50`
  - `Deceleration Strength`：`0`

这张图说明本段教程的关键差异：当前模拟并没有额外输入 `density` 这类独立烟雾体积，而是主要把 `burn` 写到 `flame`，把 `temperature` 写到 `temperature`，直接做偏火焰型的体积表现。也就是说，源结构会跟最终目标表现绑定，如果要的是“着火”而不是“浓烟”，就可以只保留火焰与温度相关场。
这张图对比了“烟雾型”与“火球型”两套 Pyro 网络。当前选中的是左侧的 `pyrosolver_billowy_smoke`，右侧同时保留一条 `pyrosolver_fireball` 参考链，用来说明不同表现目标会使用不同的源字段组合与后处理节点。

左侧视口仍显示同一个局部热区模型：黑色点云模型上有一块橙黄色着火区域，并被蓝色盒体限制范围。说明本图重点不在热区定义，而在求解器如何读取这些源。

中间网络可确认分成两组：

- 烟雾链：
  - `smoke_base1`（Torus）
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke`
  - `pyrolook_billowy_smoke1`
  - `RENDER_Billowy_Smoke1`
- 火球参考链：
  - `pyroburstsource`
  - `volumerasterizeattributes2`
  - `pyrosolver_fireball`
  - `pyrolook_fireball`
  - `RENDER_Simple_Fireball`

右侧参数面板当前选中的是 `pyrosolver_billowy_smoke`，位于 `Sourcing` 页签，`Source Type` 为 `Individual Volumes`，`Number of Sources` 为 `3`。截图中能可靠读出的三组输入规则为：

- `Source 1: density`
  - `Operation`：`Add`
  - `Source Volume`：`density`
  - `Target Field`：`density`
  - `Source Scale`：`1`
- `Source 2: temperature`
  - `Operation`：`Pull`
  - `Source Volume`：`temperature`
  - `Target Field`：`temperature`
  - `Source Scale`：`1`
  - `Acceleration Strength`：`50`
  - `Deceleration Strength`：`0`
- `Source 3: vel`
  - `Operation`：`Add`
  - `Source Volume`：`v`
  - `Target Field`：`vel`
  - `Source Scale`：`1`

这张图的重点是：一旦目标从“火焰”切换成“烟雾”，求解器就会明确读取 `density`、`temperature` 和 `velocity` 三类输入，其中 `density` 决定烟量，`temperature` 决定浮升/热运动倾向，`vel` 决定初始流向。右侧保留的火球链则是在提醒读者，同样是 Pyro，源结构和 look 节点都要随着最终形态一起变化。
这张图把对比进一步明确到“火球型 Pyro Solver 具体吃哪些字段”。当前右侧选中的是 `pyrosolver_fireball`，左侧仍保留 `pyrosolver_billowy_smoke`，中间与右侧同时展示了简单火球链和多源合并火球链。

网络中可确认的三组结构为：

- 左侧烟雾链：
  - `smoke_base1`
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke`
  - `pyrolook_billowy_smoke1`
  - `RENDER_Billowy_Smoke1`
- 中间简单火球链：
  - `pyroburstsource`
  - `volumerasterizeattributes2`
  - `pyrosolver_fireball`
  - `pyrolook_fireball`
  - `RENDER_Simple_Fireball`
- 右侧多源火球链：
  - `pyroburstsource_fireball`
  - `volumerasterizeattributes3`
  - `merge_all_sources`
  - `pyrosolver_fireball_*`
  - `pyrolook_fireball_*`
  - 最终渲染输出节点

右侧参数面板当前选中的是 `pyrosolver_fireball`，位于 `Sourcing` 页签，`Source Type` 为 `Individual Volumes`，`Number of Sources` 为 `5`。截图中能可靠读出的前五组体积输入为：

- `Source 1: density`
  - `Operation`：`Maximum`
  - `Source Volume`：`density`
  - `Target Field`：`density`
  - `Source Scale`：`1`
- `Source 2: temperature`
  - `Operation`：`Pull`
  - `Source Volume`：`temperature`
  - `Target Field`：`temperature`
  - `Source Scale`：`1`
  - `Acceleration Strength`：`50`
  - `Deceleration Strength`：`0`
- `Source 3: flame`
  - `Operation`：`Maximum`
  - `Source Volume`：`burn`
  - `Target Field`：`flame`
  - `Source Scale`：`1`
- `Source 4: divergence`
  - `Operation`：`Add`
  - `Source Volume`：`burn`
  - `Target Field`：`divergence`
  - `Source Scale`：`10`
- `Source 5: vel`
  - 条目标题可确认是 `vel`
  - 其余具体文本在当前截图下半部被裁切，无法完整读取

这张图的结论很直接：火球型求解器比前一张的 billowy smoke 求解器多读了 `flame` 与 `divergence` 这两类关键字段。也就是说，火球/爆炸不只是“更热的烟”，而是需要显式注入火焰场和发散场，才能把体积往外爆开并保持燃烧核心；而普通烟雾链更偏向 `density + temperature + velocity` 的组合。

## 补充视觉证据

### S01 00:01:36

这张补充图展示的是教程最前面用于快速搭建 billowy smoke 的基础网络，重点是右侧这条以 `smoke_base1` 为起点的烟雾预设链，以及 `smoke_base1` 这个 Torus 源几何的初始参数。

左侧视口能看到一个放在包围盒中的模糊扁平环状烟团，时间轴停在第 1 帧，说明当前只是用基础体积源快速预览出烟团雏形。

中间网络中可确认出两条相近但用途不同的链路：

- 左上简化链：
  - `sphere1`
  - `pyrosource1`
  - `attribadjustvector_velocity`
  - `volumerasterizeattributes`
- 右侧主链：
  - `smoke_base1`（Torus）
  - `pyrosource2`
  - `attribadjustvector_velocity1`
  - `volumerasterizeattributes1`
  - `pyrosolver_billowy_smoke`
  - `pyrolook_billowy_smoke1`
  - `RENDER_Billowy_Smoke1`

下方还能看到一条旧的导出/查看链：

- `import_fields_from_dops`
- `pyrolook_billowy_smoke`
- `RENDER_Billowy_Smoke`

右侧参数面板当前选中的是 `smoke_base1`，节点类型为 `Torus`，可确认的参数为：

- `Primitive Type`：`Polygon`
- `Connectivity`：`Quadrilaterals`
- `Orientation`：`Y Axis`
- `Radius`：`1 , 0.5`
- `Center`：`0 , 0 , 0`
- `Rotate`：`0 , 0 , 0`
- `Uniform Scale`：`1`
- `Rows`：`12`
- `Columns`：`24`

这张图的作用是补充说明：教程里的 billowy smoke 并不是直接从复杂碰撞或角色网格开始，而是先用一个简单的 Torus 作为环状烟源，再经 `Pyro Source -> Velocity 调整 -> Volume Rasterize -> Pyro Solver -> Pyro Bake Volume` 形成可渲染的烟雾预设。这样后面讲求解器、材质或源字段差异时，读者能先明确最基础的烟源骨架。

### S02 00:03:48

这张补充图展示的是 billowy smoke 示例在 DOP 网络中的旧版稀疏 Pyro 结构，用来对照前面 SOP 级别的预设链，说明体积源最终是如何送入 `Smoke Object + Volume Source + Pyro Solver` 这一套经典求解器结构的。

左侧视口显示一个卷曲上升的浅棕色烟团，位于体积边界框内，时间轴停在第 1 帧。这个形态与前一张的环状基础烟源相对应，说明这里已经进入求解后的体积结果预览。

中间网络可确认的节点关系为：

- `pyro`，标注为 `Smoke Object (Sparse)`
- `source_volumes`，标注为 `Volume Source`
- `pyro_solver`，标注为 `Pyro Solver (Sparse)`
- `output`

连线关系是：

- `pyro` 连接到 `pyro_solver`
- `source_volumes` 连接到 `pyro_solver`
- `pyro_solver` 输出到 `output`

右侧参数面板当前选中的是右侧另一个 `pyrosolver1` 节点，界面在 `Simulation` 页签，可确认的参数为：

- `Time Scale`：`1`
- `Temperature Diffusion`：`0.5`
- `Cooling Rate`：`0.75`
- `Viscosity`：`0`
- `Buoyancy Lift`：`5`
- `Buoyancy Dir`：`0 , 1 , 0`

下方还能确认：

- 勾选 `Make Objects Mutual Affectors`
- `Group`：`*`
- `Data Name`：`Solver`

这张图的重点是：教程这里在强调旧版 Pyro 解算的骨架非常直接，核心就是“烟雾对象 + 体积源 + 求解器”。真正决定烟雾向上卷、扩散快慢和冷却速度的，是求解器里的 `Temperature Diffusion`、`Cooling Rate`、`Buoyancy Lift` 这类动力学参数，而不是只看源几何本身。

### S03 00:06:19

这张补充图展示的是 billowy smoke 预设链的渲染外观阶段，重点从“怎么解算体积”切换到“怎么把体积烘焙并着色为可见烟雾”。当前选中的是 `pyrolook_billowy_smoke1`，右侧显示 `Pyro Bake Volume` 的烟雾散射参数。

左侧视口显示已经成形的体积烟柱：底部较亮、整体带暖棕色散射，顶部卷起多个烟团，仍位于体积边界框中。时间轴停在第 75 帧，说明这里查看的是中后段的渲染外观，而不是初始源。

中间网络可确认的主链为：

- `smoke_base1`
- `pyrosource2`
- `attribadjustvector_velocity1`
- `volumerasterizeattributes1`
- `pyrosolver_billowy_smoke`
- `pyrolook_billowy_smoke1`
- `RENDER_Billowy_Smoke1`

左侧还保留一个旧的 `pyrosolver1` 作为对照，但当前画面重点是新链中的 `Pyro Bake Volume` 外观节点。

右侧参数面板当前选中的是 `Pyro Bake Volume` 节点 `pyrolook_billowy_smoke1`，位于 `Smoke` 页签，可确认的设置为：

- 已勾选 `Assign Material`
- 材质路径：`matnet/Pyro_Shader`

`Scatter` 区域可确认：

- `Intensity Scale`：`250`
- `Hot Core Scale`：`0`
- `Color Mode`：`Color Ramp`
- `Source Range`：`0.1` 到 `1`
- 使用了一条从深棕色过渡到浅橙色的 `Scatter Color Ramp`

同页签下方还能确认：

- `Blur` 分组存在且已展开开关区域
- `Masking` 分组存在且已展开开关区域

这张图的重点是：即使体积求解部分不变，最终烟雾看起来“更厚、更暖、更像游戏里可用的烟柱”，很大程度取决于 `Pyro Bake Volume` 的着色与散射设置。这里通过较高的 `Intensity Scale`、关闭 `Hot Core`、并使用暖色散射渐变，把基础 billowy smoke 从灰色体积预览转换成可直接用于演示和后续参考的渲染结果。

## 复现检查

- 先单独验证 Emitter 的 Spawn、Lifetime、Renderer 和材质，再叠加到完整 Niagara System。
- 节点名、模块名和参数值以关键截图中的实际 UI 为准；OCR 只用于辅助定位。
- 涉及透明、Additive、SubUV、Flipbook 或 Depth Fade 时，重点检查材质混合模式、Alpha/Opacity 与 Emissive 强度。
- 涉及蓝图、Sequencer 或 Montage 时，确认触发位置、触发时机、生命周期和销毁逻辑。
- 涉及 GPU/CPU Sim、Collision、Bounds 或 Local Space 时，单独验证可见性、性能和碰撞触发范围。

