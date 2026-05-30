# 声音 (SoundWave) 无法在虚幻引擎 5.5 中播放 [RU/EN]

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/PZkG/sound-soundwave-not-playing-in-unreal-engine-5-5-ru-en

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 6263 字符。

## 摘要

修复“FSoundWaveData::LoadZerothChunk：从 DDC 加载第零块失败。资产需要手动重新烹饪。”在虚幻引擎 5.5 中

## 中文整理

### =========== RUS ==========

大家好！最近我们注意到，在虚幻引擎 5.5.3 中，尽管属性中指定了一些声波的路径，但它们的再现效果很差。让我们按顺序开始加载/保存 SoundWave 时，控制台日志中弹出以下警告：

```
LogAudio: Warning: FSoundWaveData::LoadZerothChunk: Unsuccessful load of zeroth chunk from DDC. Asset requires manual re-cook.
Asset: '04'
DerivedDataKey: 'STREAMEDAUDIO_D092D8E4F0024390B5D31F4EE3C4A2C5_BINKA_SCVER_5028_R4DV_false_SR0_48000$2e000000_SR1_32000$2e000000_SR2_24000$2e000000_SR3_12000$2e000000_SR4_8000$2e000000_QMOD_1$2e000000_CQLT_$2d1_ASTH_0$2e000000_INLC_false_LCK1_0$2e000000_CSZE_65536_LCF_false_ZCS_256_MCSO_0_END_11_QLT_80_CHN_2_SRQ_ESoundwaveSampleRateSettings$3a$3aMax_CK1_0$2e000000__645CA2DA4C04E2E36378A58E67C32ED3'
LogAudio: Warning: FSoundWaveData::LoadZerothChunk: Unsuccessful load of zeroth chunk from DDC. Asset requires manual re-cook.
Asset: '04'
DerivedDataKey: 'STREAMEDAUDIO_D092D8E4F0024390B5D31F4EE3C4A2C5_BINKA_SCVER_5028_R4DV_false_SR0_48000$2e000000_SR1_32000$2e000000_SR2_24000$2e000000_SR3_12000$2e000000_SR4_8000$2e000000_QMOD_1$2e000000_CQLT_$2d1_ASTH_0$2e000000_INLC_false_LCK1_0$2e000000_CSZE_65536_LCF_false_ZCS_256_MCSO_0_END_11_QLT_80_CHN_2_SRQ_ESoundwaveSampleRateSettings$3a$3aMax_CK1_0$2e000000__645CA2DA4C04E2E36378A58E67C32ED3'
LogAudio: Warning: Flagging SoundWave '/Game/Music/MainMenu/04' to have errors, preventing playback. ErrorMsg='ICompressedAudioInfo::StreamCompressedInfo failed'
```

这并不好玩，不是吗？因此，我的修复之路从重新烹饪整个项目开始（P.S.我不确定重新烹饪是否有帮助，但无论如何保留指南）。为此，请转到“C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64”并打开 CMD，在其中写入：

```cpp
.\UnrealEditor-Cmd.exe "C:\Path\To\YourProject.uproject" -run=Cook -TargetPlatform=Windows -Iterate
```

我们等待...但是，因为... Zen 对我来说被禁用了，然后在出现了很多垃圾邮件错误 507 之后，我将其关闭并继续（我不确定重新烹饪是否有帮助？如果您以某种方式取消订阅，我会很高兴）第二步是打开“YourProject\Saved\Config\WindowsEditor”并删除文件“EditorPerProjectUserSettings.ini”（不要忘记备份以防万一）第三步是删除项目根文件夹中的“DerivedDataCache”、“Intermediate”和“Binaries” - 宾果！启动项目后，着色器的编译将开始（为您按 F），之后项目应该能够上传声音并打开它们（但是，这就是它应该如何工作）。我唯一要告诉你的是：如果你看到黑色纹理和白色材质，而不是足够的东西，请退出虚幻引擎，删除“二进制文件”并重新开始（就像我个人所做的那样）。另一个着色器编译将开始，之后一切都会就位。我希望我对你有帮助。在评论中写下您修复错误的其他方法 =) 让我们在虚幻引擎 5 的精彩故事中互相帮助保持理智

### ============ ENG ============

大家好，又回来了！最近，我们注意到在虚幻引擎 5.5.3 中，声波无法正常播放，即使它们的路径在属性中设置正确。那么，让我们从顶部开始。加载/保存 SoundWave 时，控制台日志中会弹出此警告：

```
LogAudio: Warning: FSoundWaveData::LoadZerothChunk: Unsuccessful load of zeroth chunk from DDC. Asset requires manual re-cook.
Asset: '04'
DerivedDataKey: 'STREAMEDAUDIO_D092D8E4F0024390B5D31F4EE3C4A2C5_BINKA_SCVER_5028_R4DV_false_SR0_48000$2e000000_SR1_32000$2e000000_SR2_24000$2e000000_SR3_12000$2e000000_SR4_8000$2e000000_QMOD_1$2e000000_CQLT_$2d1_ASTH_0$2e000000_INLC_false_LCK1_0$2e000000_CSZE_65536_LCF_false_ZCS_256_MCSO_0_END_11_QLT_80_CHN_2_SRQ_ESoundwaveSampleRateSettings$3a$3aMax_CK1_0$2e000000__645CA2DA4C04E2E36378A58E67C32ED3'
LogAudio: Warning: FSoundWaveData::LoadZerothChunk: Unsuccessful load of zeroth chunk from DDC. Asset requires manual re-cook.
Asset: '04'
DerivedDataKey: 'STREAMEDAUDIO_D092D8E4F0024390B5D31F4EE3C4A2C5_BINKA_SCVER_5028_R4DV_false_SR0_48000$2e000000_SR1_32000$2e000000_SR2_24000$2e000000_SR3_12000$2e000000_SR4_8000$2e000000_QMOD_1$2e000000_CQLT_$2d1_ASTH_0$2e000000_INLC_false_LCK1_0$2e000000_CSZE_65536_LCF_false_ZCS_256_MCSO_0_END_11_QLT_80_CHN_2_SRQ_ESoundwaveSampleRateSettings$3a$3aMax_CK1_0$2e000000__645CA2DA4C04E2E36378A58E67C32ED3'
LogAudio: Warning: Flagging SoundWave '/Game/Music/MainMenu/04' to have errors, preventing playback. ErrorMsg='ICompressedAudioInfo::StreamCompressedInfo failed'
```

不太有趣，是吧？因此，解决这个问题的旅程始于对项目的全面重新设计。 （P.S. 不是 100% 确定重新烹饪修复了它，但是嘿 - 无论如何，这里有一个指南！）。为此，请转到：“C:\Program Files\Epic Games\UE_5.5\Engine\Binaries\Win64” 在该文件夹中打开 CMD，然后输入以下命令：

```cpp
.\UnrealEditor-Cmd.exe "C:\Path\To\YourProject.uproject" -run=Cook -TargetPlatform=Windows -Iterate
```

现在……我们等待。由于我禁用了 Zen，在出现大量 507 错误之后，我只是将其关闭并继续前进。 （仍然不确定重新烹饪是否真的有帮助？如果您也尝试一下，我很想听听您的结果！）第二步 - 转到：“YourProject\Saved\Config\WindowsEditor”并删除文件：EditorPerProjectUserSettings.ini（不要忘记进行备份，以防万一。安全第一，稍后混乱。）第三步 - 删除项目根目录中的这些文件夹：“DerivedDataCache”、“Intermediate”、“Binaries”。宾果！当您再次启动该项目时，您将看到绚丽的着色器编译屏幕。之后，项目应该正常启动，您应该能够再次导入并播放 SoundWaves - 您知道，因为它应该可以工作。最后一点：如果您看到黑色纹理和白色材质，而不是任何正常的东西，请退出虚幻引擎，删除“二进制文件”，然后再次启动它。 （这对我有用。）它将触发另一轮着色器编译，但这一次，事情应该最终就位。希望这对您有所帮助！如果您找到了解决此问题的其他方法 - 请在评论中留言！ =) 让我们在虚幻引擎 5 的精彩故事中互相帮助保持理智
