# Texture / RenderTarget / Media 指令

本分册覆盖 Texture2D、TextureCube、Texture2DArray、TextureCubeArray、VolumeTexture、VirtualTexture、RuntimeVirtualTexture、RenderTarget、Media、SparseVolumeTexture、Texture Graph、SubUVAnimation、Paper2D、TextureLightProfile、TextureCollection 和跨资产 usage 验证。

## 边界

- `asset_import_texture` 仍是 Texture2D 外部图片导入入口；本分册不新增 `texture_import`。
- Texture2D 的浅层属性写入继续走 `asset_export_property_json / asset_apply_property_json`；本分册只补重导入、info、像素、导出和语义校验。
- Material / UMG / Niagara / Blueprint / Component / Sequence 中的贴图引用 authoring 继续走各自 folder workflow；本分册的 `texture_usage_*` 只做读回和关系验证。
- RenderTarget 读像素、截图、draw/copy/capture、转静态 Texture、TextureGraph bake/probe 依赖有效 RHI；`-NullRHI` 下必须返回明确诊断，不得崩溃或假成功。
- `render_target_read_pixels / sample_uv / export_image / create_static_texture` 当前只承诺 `TextureRenderTarget2D`；Cube、2DArray、Volume RT 当前承诺 create/info/export/apply JSON。

## Texture2D

| 指令 | 作用 |
| --- | --- |
| `texture_reimport` | 重导入已有 Texture；可传 `source_filename` 覆盖源文件，或使用资产已有导入数据。 |
| `texture_get_info` | 读取尺寸、格式、mip、压缩、source 和可选像素统计。 |
| `texture_validate_settings` | 按 `expected_usage=color/normal/mask/ui/data` 做只读语义校验。 |
| `texture_export_image` | 将 Texture source 导出为 `png/exr/hdr/tga`。 |
| `texture_pixel_probe` | 读取采样和统计信息，返回 `stats`、`probe_passed`。 |
| `texture_screenshot` | 生成 Texture 预览图，并返回非黑/通道统计证据。 |

## 组合 Texture

| 指令 | 作用 |
| --- | --- |
| `texture_array_create` / `texture_array_export_folder` / `texture_array_apply_folder` | 从 Texture2D 列表创建、导出、回写 Texture2DArray。 |
| `texture_cube_create` / `texture_cube_export_folder` / `texture_cube_apply_folder` | 从 6 面 Texture2D 创建、导出、回写 TextureCube。 |
| `texture_cube_array_create` / `texture_cube_array_export_folder` / `texture_cube_array_apply_folder` | 从 TextureCube 列表创建、导出、回写 TextureCubeArray。 |
| `volume_texture_create` / `volume_texture_export_folder` / `volume_texture_apply_folder` | 从 source texture 创建、导出、回写 VolumeTexture。 |

## Virtual Texture / Runtime Virtual Texture

| 指令 | 作用 |
| --- | --- |
| `virtual_texture_get_info` | 读取 Texture 的 VT 设置和项目 VT 状态。 |
| `virtual_texture_validate_setup` | 校验静态 VT 设置、项目开关和预期引用。 |
| `runtime_virtual_texture_create` | 创建 RuntimeVirtualTexture 资产。 |
| `runtime_virtual_texture_get_info` | 读取 RVT 尺寸、tile、material type 和引用摘要。 |
| `runtime_virtual_texture_export_json` / `runtime_virtual_texture_apply_json` | RVT 单文件 JSON 导出/回写。 |
| `runtime_virtual_texture_validate_setup` | 校验 RVT 关卡/材质使用关系。 |

## RenderTarget

| 指令 | 作用 |
| --- | --- |
| `render_target_create` | 创建 `2d/canvas2d/cube/2d_array/volume` RenderTarget。 |
| `render_target_get_info` | 读取 RenderTarget 摘要和可选像素统计。 |
| `render_target_export_json` / `render_target_validate_json` / `render_target_apply_json` | RT 单文件 JSON 导出、校验、回写。 |
| `render_target_resize` | 显式 resize；必须传 `allow_resize=true`。 |
| `render_target_clear` | 清空 2D RT；接受 `clear_color`，兼容旧 `color`。 |
| `render_target_draw_material` | 用材质绘制到 2D RT，返回 `drawn` 与 `stats_after`。 |
| `render_target_copy_texture` | 将 Texture 绘制/拷贝到 2D RT；接受 `target_render_target`。 |
| `render_target_capture_scene` | 使用临时 SceneCapture 写入 2D RT，返回 `captured` 与 `stats_after`。 |
| `render_target_read_pixels` / `render_target_sample_uv` | 2D RT 读像素统计或按 UV 采样，支持 `rect/max_pixels/uvs[]`。 |
| `render_target_export_image` | 导出 RT 为图片文件。 |
| `render_target_create_static_texture` | 从 2D RT 创建静态 Texture2D；接受 `render_target + destination_path + destination_name`，原生路径失败时会用读回像素创建 Texture2D。 |
| `render_target_probe` | 一体化 2D RT 读回探针，返回 `probe_passed` 与 `steps[]`。 |
| `scene_capture_validate_render_target` | 校验 SceneCaptureComponent2D 到 RT 的绑定关系。 |
| `scene_capture_runtime_probe` | 触发 capture 并验证命令链路。 |

RHI 依赖命令在 `-NullRHI` 下返回 `render_resource_unavailable_null_rhi`；TextureGraph 渲染返回 `texture_graph_render_unavailable_null_rhi`。

## Media

| 指令 | 作用 |
| --- | --- |
| `media_source_create` / `media_source_get_info` / `media_source_export_json` / `media_source_apply_json` | File/Stream MediaSource 创建、读取、导出、回写。 |
| `media_player_create` / `media_player_export_json` / `media_player_apply_json` | MediaPlayer 创建、导出、回写；`media_player_create` 可用 `video_output_texture` 同步创建并绑定 MediaTexture。 |
| `media_texture_create` / `media_texture_export_json` / `media_texture_apply_json` | MediaTexture 创建、导出、回写；创建时支持 `media_player`、`address_x/y` 与 `clear_color`。 |
| `media_runtime_probe` | 校验 MediaPlayer 能否播放指定 MediaSource，可选尝试打开。 |

## SVT / TextureGraph / 2D 派生资产

| 指令 | 作用 |
| --- | --- |
| `sparse_volume_texture_import` / `sparse_volume_texture_reimport` | 导入或重导入 OpenVDB/SVT。 |
| `sparse_volume_texture_get_info` / `sparse_volume_texture_export_json` / `sparse_volume_texture_apply_json` / `sparse_volume_texture_preview_probe` / `sparse_volume_texture_validate_setup` | SVT 摘要、JSON、预览探针和使用关系校验。 |
| `texture_graph_create` / `texture_graph_get_info` / `texture_graph_export_folder` / `texture_graph_validate_folder` / `texture_graph_apply_folder` / `texture_graph_bake_outputs` / `texture_graph_runtime_probe` | Texture Graph folder workflow、bake 和运行探针。 |
| `subuv_animation_create` / `subuv_animation_get_info` / `subuv_animation_export_json` / `subuv_animation_apply_json` / `subuv_animation_preview_probe` | SubUVAnimation 创建、JSON 和帧探针。 |
| `paper_sprite_create` / `paper_sprite_export_json` / `paper_sprite_apply_json` | PaperSprite 创建和 JSON。 |
| `paper_flipbook_create` / `paper_flipbook_export_json` / `paper_flipbook_apply_json` | PaperFlipbook 创建和 JSON。 |
| `paper_tileset_export_folder` / `paper_tileset_apply_folder` / `paper_tilemap_export_folder` / `paper_tilemap_apply_folder` | Paper TileSet/TileMap folder workflow。 |
| `paper2d_preview_probe` | Paper2D 预览探针。 |
| `light_profile_texture_import` / `light_profile_texture_get_info` / `light_profile_validate_setup` | IES/TextureLightProfile 导入、读取和 LightComponent 使用校验。 |
| `texture_collection_create` / `texture_collection_get_info` / `texture_collection_export_json` / `texture_collection_apply_json` / `texture_collection_validate_usage` | TextureCollection 创建、JSON 和材质使用校验。 |

## Usage 验证

| 指令 | 作用 |
| --- | --- |
| `texture_usage_validate` | 校验贴图/RT/Media/SVT 的预期引用关系。 |
| `texture_usage_get_references` | 读取 referencer 摘要。 |
| `texture_usage_probe_media` | 验证 MediaTexture 资产链路。 |
| `texture_usage_probe_sparse_volume` | 验证 SVT 资产链路。 |

## 测试覆盖

- 自动化测试：`GptProjectTest.UeAgentInterface.Smoke.TextureRenderTargetMediaWorkflow`。
- 非 NullRHI 路径覆盖真实 RT clear/read/export/static texture、draw material、copy texture、scene capture、TextureGraph bake/probe。
- NullRHI 路径覆盖所有 RHI 依赖命令的明确失败诊断，防止再次出现截图/渲染读回类崩溃。
- 当前测试文件已直接覆盖本分册新增命令路由；新增命令时必须同步扩展该 smoke。
