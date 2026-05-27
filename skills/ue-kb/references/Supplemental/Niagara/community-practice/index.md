# Niagara 社区实践专题索引

本索引用于让知识库检索到 Niagara 社区实践资料的主题边界。官方文档优先；本专题用于补充案例流程、性能经验和工程接入细节。

## Fluids

Niagara Fluids、3D Gas、火焰和烟气等体积类效果实践。

- [Niagara Fluids：探索 3D 气体发射器](fluids/niagara-fluids-3d-gas-emitter.md)
- [虚幻引擎的火焰和气体特效：EmberGen 与 Niagara Fluids 对比 - 第一部分](fluids/fire-and-gas-vfx-embergen-vs-niagara-fluids-part-1.md)
- [虚幻引擎的火焰和气体特效：EmberGen vs Niagara Fluids - 第二部分](fluids/fire-and-gas-vfx-embergen-vs-niagara-fluids-part-2.md)

## Performance

Scalability、Effect Type、性能测量、系统复用和大量粒子渲染实践。

- [Nanite Niagara GPU 粒子渲染器及使用单个 Niagara 系统渲染 33 种不同网格的 10 万个粒子。蓝图和 C++代码性能评测](performance/nanite-niagara-gpu-particle-renderer-performance.md)
- [Niagara 可扩展性：效果类型](performance/niagara-scalability-effect-types.md)
- [优化 Niagara | 可扩展性和最佳实践](performance/optimizing-niagara-scalability-best-practices.md)
- [优化 Niagara | 性能衡量](performance/optimizing-niagara-measuring-performance.md)
- [优化 Niagara | 系统即服务](performance/optimizing-niagara-systems-as-a-service.md)

## Data Channels

Niagara Data Channel 的概念、版本变化和最小示例。

- [Niagara 数据通道 5.4 更新](data-channels/niagara-data-channels-5-4-update.md)
- [Niagara 数据通道基础示例](data-channels/basic-niagara-data-channel-example.md)
- [Niagara 数据通道简介](data-channels/niagara-data-channels-intro.md)

## Scripting

HLSL、C++、Blueprint 粒子数据导出和运行时接口。

- [Niagara - HLSL 中的随机数和随机浮点动态输入](scripting/niagara-random-hlsl-dynamic-input.md)
- [在 C++ 中使用 Niagara](scripting/using-niagara-in-c-plus-plus.md)
- [将 Niagara 粒子数据导出到蓝图](scripting/export-niagara-particle-data-to-blueprint.md)
- [尼亚加拉 - 导出粒子数据](scripting/niagara-export-particle-data.md)

## Advanced Simulation

重力、空间殖民、Marching Cubes、Procedural Mesh、海洋等高级模拟案例。

- [Niagara 重力模拟](advanced-simulation/gravity-simulation-in-niagara.md)
- [Niagara 中的 Space Colonization 算法](advanced-simulation/space-colonization-algorithm-in-niagara.md)
- [使用 Niagara 在虚幻引擎中开发行进立方体插件](advanced-simulation/marching-cubes-plugin-with-niagara.md)
- [尼亚加拉 - 程序化网格](advanced-simulation/niagara-procedural-mesh.md)
- [海洋模拟](advanced-simulation/ocean-simulation.md)

## Blueprint Integration

通过 Blueprint 模块控制 Niagara 粒子和效果的实践。

- [蓝图模块：控制尼亚加拉效应（第三部分）](blueprint-integration/blueprint-module-controlling-niagara-effects-part-3.md)
- [蓝图模块：控制尼亚加拉粒子（第一部分）](blueprint-integration/blueprint-module-controlling-niagara-particles-part-1.md)
- [蓝图模块：控制尼亚加拉粒子（第二部分）](blueprint-integration/blueprint-module-controlling-niagara-particles-part-2.md)

## Cache And Sequencer

Niagara Cache、Simulation Cache 与 Sequencer 结合使用。

- [Sequencer 中的 Niagara 模拟缓存](cache-sequencer/niagara-simulation-caching-in-sequencer.md)
- [使用 Niagara 缓存](cache-sequencer/using-niagara-caches.md)

## Migration

从 Unity Particle System / VFX Graph 迁移到 Unreal Niagara 的对照案例。

- [Unity 到 Unreal 5：Niagara 系统教程 - 闪亮勾拳特效](migration/unity-to-unreal-sparkly-hook-punch-fx.md)
- [Unity 到 Unreal 引擎的粒子效果](migration/particles-from-unity-to-unreal.md)
- [在虚幻引擎中重制 Unity 粒子系统](migration/remaking-a-unity-particle-system-in-unreal.md)

## Effect Recipes

烟雾、闪电、爆炸、碰撞、遮罩、翻页纹理等效果制作案例。

- [Niagara 示例包：最佳实践](effect-recipes/niagara-example-pack-best-practices.md)
- [使用 Niagara 创建用于动画全息材质的翻页书纹理](effect-recipes/flipbook-textures-animated-hologram-materials.md)
- [使用 Niagara 制作攀爬粒子遮罩特效](effect-recipes/climbing-particle-mask-effect-with-niagara.md)
- [创建风格化漫画特效（第一部分）：烟雾轨迹](effect-recipes/stylized-comic-fx-smoke-trails.md)
- [尼亚加拉模块：烟雾效果](effect-recipes/niagara-module-smoke-effect.md)
- [尼亚加拉电子爆炸粒子特效教程](effect-recipes/niagara-electronic-explosion-particle-tutorial.md)
- [Niagara 碰撞](effect-recipes/niagara-collisions.md)
- [尼亚加拉示例包：烟雾和火焰精灵材质](effect-recipes/niagara-smoke-fire-sprites-material.md)
- [常见问题解答：Niagara 和视觉特效](effect-recipes/faq-niagara-visual-effects.md)
- [闪电特效分步指南](effect-recipes/lightning-vfx-step-by-step-guide.md)
