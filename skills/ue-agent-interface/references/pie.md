# 运行时 PIE 调试

用于依赖游戏运行的行为。资产自身预览见[资产预览](asset-preview.md)，静态场景配置见[场景制作](scene-creation.md)。

## 默认只用输入、等待和截图

普通行为测试尽量用输入、等待、截图/截图集完成。先从画面和实际输入结果判断；观察不足时，
优先选择能看清目标的截图来源、视角或采样时机。确实无法据此解决的具体问题，才使用属性操作。
这是证据选择顺序，不要求为已经明确不可视的目标先做一轮无效截图。

属性操作会增加 Current HJSON 引用定位、流程编写和结果阅读的时间与 Token；不预先搜索所有相关变量，
不因“数值证明更充分”就追加读值，也不把每次采样固定成所有关联对象的整套读取。
输入本身不能证明目标行为成功，截图仍需实际查看。

## 开始、运行、查看、继续

```python
session = client.pie.start(name="current-test")
result = session.run([
    {"type": "capture_start", "name": "motion", "interval": 0.25,
     "source": "pie_output_surface", "format": "png"},
    {"type": "input_key", "key": "W", "event": "pressed"},
    {"type": "wait", "duration_ms": 500},
    {"type": "input_key", "key": "W", "event": "released"},
    {"type": "capture_stop", "name": "motion"},
])
print(result.ok, result.payload.get("execution"), result.payload.get("diagnostics"))
# 查看有序结果和图像，再决定下一段；正常结束本次测试时关闭。
closed = session.close()
closed.raise_for_error()
print(closed.payload.get("lifecycle_status"), closed.payload.get("cleanup_complete"), closed.diagnostics)
```

`start` 返回初始化暂停快照入口。`run` 提交有限流程，返回有序结果和下一暂停快照。
已确定的动作合成连续段，需新视觉或语义判断时再暂停给模型；不按每次输入或截图拆交接。

多分辨率运行验证用 `client.pie.start("ui-check", viewport_width=1920, viewport_height=1080)`。
宽高是当前会话真实视口的物理像素，分别省略时默认 1280/720；不通过修改普通 Play 窗口偏好
控制调试窗口，也不缩放截图冒充目标尺寸。以 `pie_output_surface` 返回和原图尺寸核对。

`wait.duration_ms` 使用毫秒，从实际执行时开始等待相应游戏时间，随后继续顺序操作；卡顿不会预先消耗后续等待。
等待中安排动作可用相对本段起点的绝对游戏秒 `at_seconds`；同刻已就绪动作保持声明顺序。无需指定帧数。
输入支持键、视口像素指针、滚轮、Unicode 文本和 Action 注入；按需查快照键目录，Action 注入不等于UI键鼠。
时长由场景决定，示例不是固定测试时长。参数、引用路径与支持边界见 CMD `docs/active/pie_flows.md`。

## 截图与结果

屏幕/UI 用 `pie_output_surface`；玩家相机或指定方位按正式合同选择。
`capture_start` 采首帧，随后按游戏秒 `interval` 采样；`capture_stop` 返回截图集，未关闭的集合在段末关闭。
先看集合 `overview` 再选择必要原帧；按实际 `game_seconds`、缺帧和失败信息判断覆盖，不假定设定频率均已采到。
比较亮度时保持来源、视角和场景状态一致；固定等待不证明曝光已稳定。
构图和曝光随[场景制作](scene-creation.md)在 Editor 中完成；已有适用画面则复用，运行时相机或效果另按实际需要观察。

`run` 的 `execution/results/snapshot/diagnostics` 分别说明执行、有序返回、暂停快照和诊断；调用成功不等于行为通过。
`results` 按操作顺序包含读值、单图和截图集；每图 `artifact_index` 对应 `result.artifacts`：

```python
file = result.artifacts[artifact_index].materialize("tmp/current-task/frame.png")
print(file.path)
```

保存自动避让不同内容的同名文件，使用返回路径；本地保存失败只重试同一产物，不调用 `session.resume()` 或重跑截图。

失败也要消费已取得的图像/读值，明确未执行范围，不重放整段。完整结果按需落盘；执行脚本直接输出
execution/diagnostics，以及每组 name/status/frame_count/missed_frames/failed_frames、实际起止时间和
overview/所选原帧的物化路径。正常摘要足够时直接看图，不逐轮搜索整份 JSON 和日志重复核对。

## 确有缺口时使用属性

先明确画面不能回答的具体问题，再定位所需对象/字段。从 Current HJSON 复制公开 `ref` 用于
`property_get/property_set`，不直接编辑快照来修改运行世界。复用仍有效的引用，不遍历整个快照。
终点只读关键状态；需要连续数值时，只在相关变化区间采相关字段。关系已证实后，不在每个时点重复读取所有对象。
只有目标本身需要修改运行属性且普通输入不能完成时才用 `property_set`，不能用属性改写替代待验证的真实输入行为。

重要引用更新报告已用/关注引用的结构变化；无更新不代表数值或世界未变。
属性可写不等于执行了移动、瞬移等原生行为；写后即时读回不能替代实际运行后的效果。
`property_set` 在原生更新后按原输入核验；读回失败不表示写入已回滚，不盲目重放。
集合元素以值定位，修改元素后，后续操作须使用更新后的 `set_value`。

## 结束与恢复

正常暂停保留按键/轴；下一段显式松开，或结束时 `session.close()`。
消费关闭结果并确认 `cleanup_complete`；主动结束会话的取消诊断不等于清理失败，顶层 `ok` 也不证明已清理。
同一 Editor 中跨进程用 `client.pie.recover("current-test")`；未完成的 run 先用 `session.resume()` 领取原流程。
SDK 管理恢复记录和句柄推进，不建常驻服务，不手工操作 checkpoint/release，也不调用底层 runtime scenario 命令。
恢复错误不代表动作没发生；按公开诊断与 CMD 恢复合同处理，不删除记录、换名重启或盲目重放来掩盖未知状态。

证据齐备后，连续完成关闭本次 PIE、任务要求的 Editor 展示和必要状态读回。按任务约定比较本次改变的状态与原基线，
保留用户原有 dirty、窗口和 Editor override，不将理想默认值当作恢复目标。交付直接引用已有证据，
不为写报告重复运行或导出。
