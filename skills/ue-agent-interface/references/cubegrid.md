# CubeGrid 体积编辑

适合连续白盒、平台、台阶、坡道和体块切除。入口是 `client.mesh.voxel_grid_begin(...)`，返回
`result.voxel_grid` typed handle；先检查结果，再保留 handle 连续编辑。创建使用 `mode="create"`；
已有网格使用 `mode="edit", actor_ref=<公开返回的精确 Actor 路径>`。

`begin` 的 `cell_size`、`origin`、`anchor` 使用厘米；`rotation` 是 UE pitch/yaw/roll，单位 degree。
origin/rotation 定义 grid-local 到 world 的网格坐标系，anchor 是 grid-local 中的 Actor 枢轴。

- `add_bounds(bounds)` / `remove_bounds(bounds)`：对网格选区增加或删去整格。bounds 显式包含
  `space="grid_local"|"component_local"|"world"` 及 `min/max` 或 `center/extent`；非整格边界向外覆盖，
  旋转空间的 AABB 也会保守覆盖。精确斜面或定向切口使用 shape。
- `add_shape(shape)` / `remove_shape(shape)`：精确体积并集/差集，支持 `box`、`square_pyramid`、
  `triangular_prism`。shape 必须给 `kind`、`space`、`center:{x,y,z}`、正数 `size:{x,y,z}`，尺寸为厘米；
  可选 `rotation:{pitch,yaw,roll}` 使用 degree，在所声明的 space 中解释。
  四棱锥底面位于局部 -Z、尖顶在 +Z；三角柱是沿 Y 挤出的直角 XZ 三角形，从 -X 的低端升至 +X 高端。
  旋转可改变坡向或尖顶方向。remove_shape 切去相交体积，不是按名称移除一个独立形状。
- `read()`：观察当前编辑状态；整格状态返回 cell 数，精确实体返回体积、grid-local 边界和凸片数。
  凸片是结果表达，不是额外 Actor，也不要求调用方维护。
- `apply(keep_session=True)`：提交并保存后继续编辑；默认 `keep_session=False` 提交并释放 handle。
  碰撞默认跟随几何精确生成；斜面和切口使用凸片，不用盒体填平。通常不必指定 collision，显式关闭可用
  `collision={"mode":"none"}`。结果的 warnings 与读回仍须检查。
  完全切空也可正常提交：Actor 保留以便继续编辑，体积、网格和碰撞计数均为零，不残留原碰撞；
  空结果本身不构成错误或警告，也不会自动删除 Actor。
- `close()` 释放干净会话；`cancel()` 丢弃未提交编辑，新建且从未提交的 Actor 会一并清理。
  已提交的 Actor 保留。会话身份、revision 和持久化收据由 SDK 管理，不手工提取或转发。

例如在网格局部坐标创建一段宽 200、长 400、高 100 厘米的坡道：

```python
result = client.mesh.voxel_grid_begin(mode="create", cell_size=100, label="Ramp")
result.raise_for_error()
grid = result.voxel_grid
grid.add_shape({
    "kind": "triangular_prism", "space": "grid_local",
    "center": {"x": 200, "y": 0, "z": 50},
    "size": {"x": 400, "y": 200, "z": 100},
}).raise_for_error()
result = grid.apply(color=[0.22, 0.36, 0.48])
result.raise_for_error()
print(result.payload.get("warnings"), result.payload.get("readback"))
```

新建网格首次 apply 默认使用插件内置尺寸材质；`color` 是 0～1 的线性 RGB，可省略或在后续 apply 时修改。
网格原点首次按实际局部 bounds-min 固定，后续改变几何不会重新对齐。显式 `material_ref` 可换成其他材质，
此时不要同时传 `color`；编辑既有网格默认保留原材质。

创建前使用已保存且目标 package 干净的地图；既有地图有授权待保存内容时先按普通资源保存流程处理。
apply 自身负责目标保存和独立读回，不需要为普通制作额外切图、重载或启动 PIE。
