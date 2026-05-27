---
title: "命令行参数参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-command-line-arguments-reference"
breadcrumbs: ["虚幻引擎5.7文档", "用C++编程", "虚幻架构", "命令行参数", "命令行参数参考"]
---

# 命令行参数参考

> 路径：虚幻引擎5.7文档 / 用C++编程 / 虚幻架构 / 命令行参数 / 命令行参数参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-command-line-arguments-reference

## 标记

虚幻引擎命令行标记可以传递到可执行文件，用于指定特定行为。例如，要使用 `DumpAssetRegistry` 标记运行虚幻编辑器，则需使用

```
UnrealEditor.exe -DumpAssetRegistry
```

命令行参数不区分大小写。这意味着以下命令全部等效：

```
UnrealEditor.exe -DumpAssetRegistryUnrealEditor.exe -dumpassetregistryUnrealEditor.exe -DUMPASSETREGISTRY
```

## 标记

|

参数

|

说明

|

备注和用法

| | --- | --- | --- | |

30hzmin

| | | |

60hzmin

| | | |

aftermathall

| | | |

aftermathmarkers

| | | |

aftermathresources

| | | |

AlignFilesLargerThanBlock

| 对齐大于区块大小的文件。 | | |

AllowCaching

| 针对支持的平台允许本地缓存。 | | |

AllowCommandletAudio

| | | |

AllowCommandletCEF

| | | |

AllowCommandletRendering

| | | |

AllowCPUDevices

| | | |

AllowPixelStreamingCommands

| | | |

AllowSafePixelStreamingCommandsOnly

| | | |

AllowSoftwareRendering

| 允许D3D11和D3D12 RHI回退到软件渲染。 | | |

AllowStdOutLogVerbosity

| | | |

AllowTranslationPickerSubmissionsToOneSky

| | | |

AllowUncookedAssetReferences

| | | |

allusers

| | | |

analytics

| 发送分析数据，用于材质着色器的追踪用途。 | | |

ANALYTICSDISABLECACHING

| 禁用缓存分析事件。 | | |

ANALYTICSTRACKPER

| 追踪分析性能。 | | |

AssetRegistryValidatePackageExists

| 验证程序包是否存在于资产注册表中。 | | |

AssignNewMapGuids

| 重置关卡资产的本地缓存。 | | |

AsyncLoadingThread

| 为包流送启用异步加载线程。 | | |

AsyncPostLoad

| 为包流送启用异步后期加载。 | | |

attachPIX

| 附加要处理的PIX。 | | |

attachRenderDoc

| 附加要处理的RenderDoc。 | | |

AudioMixer

| 强制加载音频混合器。 | | |

AuditFiles

| 审核PAK文件。 | | |

AutoDeclinePackageRecovery

| 自动拒绝包恢复。 | | |

AutomatedMapBuild

| 执行指定地图的自动化编译。 | | |

AutoQuit

| 分析启动失败或成功完成时关闭应用程序。 | | |

AutoSubmit

| 自动提交世界分区编译器标签。 | | |

BENCHMARK

| 设置基准。 | | |

bForceSmokeTests

| 强制烟雾测试。 | | |

bugvideocap

| 将漏洞数据库标记为可以上传视频。 | | |

buildHLODs

| 编译HLOD。 | | |

BuildIdOverride

| | | |

BUILDMACHINE

| 将此计算机设置为编译计算机，以确定是否启用了调试输出。 | | |

CachePerPak

| | | |

CacheStoreTestWarm

| | | |

CacheTrackRecorderISHEADLESS

| | | |

CalcCompressionBlockCRCs

| | | |

CefAllowAllCookies

| | | |

cefverbose

| | | |

checkpak

| | | |

Clean

| | | |

CLEANCLASSES

| | | |

CleanCrashReports

| 清除位于

../Saved/Crashes

中的崩溃报告文件夹。 | | |

ClearOpenGLBinaryProgramCache

| 删除OpenGL的

ProgramBinaryCache

文件夹。 | | |

clearPSODriverCache

| 清除PSO驱动程序缓存。 | | |

ClearVulkanBinaryProgramCache

| 删除Vulkan的

ProgramBinaryCache

文件夹。 | | |

ClusterForceApplyResponse

| | | |

compress

| 启用压缩。 | 已弃用。 | |

compressionEnableDDC

| 使用DDC进行压缩。 | | |

CompressionTest

| 测试数据包压缩。 | | |

ConcurrentSave

| | | |

CookAllVerseInternalDigests

| | | |

cookchild

| | | |

cookcommandlet

| | | |

CookIgnoreTimeouts

| 忽略烘焙超时。 | | |

CookMemoryAnalysis

| 始终显示烘焙内存分析。 | | |

CookOnTheFly

| 即时烘焙服务器。 | | |

cooksinglepackage

| 烘焙不带引用的数据包。 | | |

CookTestPendingBuilds

| | | |

CrashForUAT

| | | |

crashreports

| 始终显示崩溃报告。 | | |

CreateContentPatch

| | | |

csvABTestFastCVarSet

| | | |

csvDemoStopAfterProfile

| | | |

csvDemoStopCsvAtReplayEnd

| | | |

csvGpuStats

| 使用CSV分析器记录GPU统计数据。 | | |

csvNamedEvents

| | | |

csvNamedEventsTiming

| | | |

csvNoProcessingThread

| | | |

csvoutput

| | | |

csvStatCounts

| | | |

csvTest

| | | |

csvTestMT

| | | |

d3d11

| | | |

d3d12

| | | |

d3d12gpuvalidation

| 请求GPU验证时启用调试层。 | | |

d3dbreakonwarning

| | | |

d3ddebug

| 将调试设备用于d3d。 | | |

d3debug

| 将调试设备用于d3d。 | | |

DDC-Verify

| 创建验证节点。 | | |

DDC2AsyncTextureBuilds

| 使用新的纹理派生的数据构建。 | | |

DDC2RemoteExecution

| 将远程执行用于派生的数据构建。 | | |

DDC2TextureBuilds

| 使用新的纹理派生的数据构建。 | | |

DDCSkipSpeedTest

| 跳过速度测试。 | | |

DDCTOUCH

| 在所有指定的文件系统后端上启用触摸。 | | |

DEBUGANALYTICS

| | | |

DebugCapture

| 转储位图以用于调试目的。 | | |

DebugCoreRedirects

| 为核心重定向启用调试模式。 | | |

debughangdetection

| | | |

debuglog

| | | |

DebugTools

| 加载控件反射器。 | | |

DefaultLoadBehaviorTest

| 尝试从引用类获取元。这只在已经加载的类中查看。 | | |

DeleteHLODs

| | | |

DeleteLocalCache

| 删除所有本地缓存的文件。 | | |

deleteuserpsocache

| 删除用户可写的PSO缓存。 | | |

DEMOMODE

| 启用演示模式。 | | |

detectvulkan

| 检测Android版Vulkan。 | | |

Deterministic

|

-UseFixedTimeStep -FixedSeed

的快捷方式。 | | |

DeterministicAudio

| 强制实施非实时音频渲染器。 | | |

DeveloperReport

| | | |

Diff

| 执行两个文件的对比。 | | |

DIFFNORANDCOOK

| | | |

DIFFONLY

| | | |

directcompile

| | | |

directcomposition

| | | |

disableanalysiscache

| 将缓存设置为临时模式。 | | |

disablecleanup

| | | |

DisableEDLCookChecker

| | | |

DisableForkedHTTPThread

| | | |

DisableForkedOutputThread

| | | |

DisableHttpDomainRestrictions

| 禁用HTTP域允许列表。 | | |

disableiosredeem

| | | |

DisablePendingKill

| | | |

DisablePostForkThreading

| 禁用多线程。 | | |

DisablePython

| 禁用Python脚本。 | | |

DisableSSLCertificatePinning

| | | |

DisableTouch

| 禁用触摸输入。 | | |

DisableUploadSymbols

| 禁止上传到符号存储。 | | |

disablezlib

| 禁用作为压缩选项的ZLib。 | | |

DistributedBuild

| | | |

dllerrors

| | | |

DoNotClusterByOrderPriority

| | | |

DUMPALLWARNINGS

| | | |

DumpAssetRegistry

| 将关于资产注册表的扩展信息转储到日志。 | | |

DumpAsyncStallsOnExit

| | | |

dumpconfig

| 将所有配置设置转储到日志。 | | |

DumpEarlyConfigReads

| | | |

DumpEarlyPakFileReads

| | | |

DUMPMOVIE

| | | |

DumpRPCs

| 将所有RPC和完整参数列表转储到日志。 | | |

DumpStats

| | | |

dx11

| 将DX11用于RHI。 | | |

dx12 | 将DX12于RHI。 | | |

dxdebug

| 使用DirectX调试设备。 | | |

EditorDomain

| | | |

emitdrawevents

| | | |

emulatestereo

| | | |

enableailogging

| | | |

enableallfeatures

| | | |

enableallplugins

| | | |

enablehttpdomainrestrictions

| 启用HTTP域允许列表。 | | |

enablependingkill

| | | |

enablesystrace

| | | |

EnableTitleFileV2

| | | |

EnableUserCloudV2

| | | |

encrypt

| | | |

encryptindex

| | | |

encryptionini

| | | |

EOSPixelStreamingEnabled

| | | |

EOSUseEngineEncoders

| | | |

EpicPortal

| 是否由Epic游戏商城启动。 | | |

es31

| | | |

ExcludeDeleted

| | | |

ExecuteBuildsLocally

| 允许从此点远程执行派生的数据构建。 | | |

ExitAfterCsvProfiling

| 完成CSV分析后退出。 | | |

ExitAfterReplay

| 已播放最后一次重播后退出。 | | |

ExportBuilds

| | | |

externalcomposition

| | | |

extract

| 提取提供的PAK文件。 |

-Extract

[-responsefile=

-order=

]

| |

extracttomountpoint

| | | |

FailIfGeneratedCodeChanges

| 仅当生成的代码未更改时编译模块。 | | |

FakeForking

| 运行伪叉取。 | | |

faketouches

| 伪造触摸事件以模拟移动设备。 | | |

fallbackOrderForNonUassetFiles

| | | |

fastcook

| 目标支持时使用快速烘焙路径。 | | |

fastexit

| | | |

FATALSCRIPTWARNINGS

| 将脚本警告视为致命错误。 | | |

FeatureLevelES31

| | | |

FileLog

| | | |

FileOpenLog

| | | |

FilePackageOpenLog

| | | |

FileRegions

| | | |

FilterBulkData

| 将数据块类型筛选器设置为

EChunkTypeFilter::BulkData

。 | | |

FilterLowLevelMouse

| 应用低级别鼠标筛选器，筛选掉行为类似触摸输入的鼠标输入。 | | |

FilterPackageData

| 将数据块类型筛选器设置为

EChunkTypeFilter::PackageData

。 | | |

FinalizeHLODs

| | | |

firstinstall

| | | |

FixedSeed

| 将0用作

FRandomStream

的种子。 | | |

flushWaitingRoomData

| | | |

forceajausage

| 强制使用Aja媒体捕获。 | | |

ForceAllowQos

| | | |

ForceAsyncCompute

| | | |

forceblackmagicusage

| 强制使用Black Magic媒体捕获。 | | |

forcecefaccelpaint

| | | |

forcecompress

| | 已弃用。 | |

forcedadcheck

| | | |

forcedependsgathering

| | | |

forcedisablesm6

| 禁用sm6。 | | |

forcegenericio

| | | |

forcelogcallstacks

| | | |

forcelogflush

| 强制在每行之后清空日志。 | | |

forcemetalheap

| 强制在MacOS上使用MTLHeap。 | | |

forcepakprocessreads

| 将通常只用于压缩文件的FPakProcessedReadRequest系统用于异步读取pak文件。 | | |

forcepassthrough

| 强制OSS使用直通套接字，而不是连接到平台会话int。 | | |

forcepatchcheck

| | | |

forcequitafterearlyreads

| | | |

forceres

| 如果用户请求的大小超过显示屏，使用此项可防止引擎自动调整新实例大小以不超出屏幕边界。 | | |

forcerhibypass

| | | |

forcevreditor

| 直接转至VR编辑器模式。 | | |

forcezeroadapters

| | | |

forkautostatsport

| | | |

FrameproEnableContextSwitches

| | | |

fullcook

| | | |

fullcrashdump

| 为崩溃创建完整内存迷你转储。 | | |

fullcrashdumpalways

| 始终为崩溃创建完整内存迷你转储。 | | |

fulldebugcoreredirects

| 启用完整调试模式并设置为最大冗长度。 | | |

fullscreen

| 使用全屏模式。 | | |

fullsizescreenshots

| 始终使用完整尺寸的截屏。 | | |

fullstdoutlogoutputs

| | | |

game

| | | |

generatepixmappingfile

| |

-GeneratePIXMappingFile

[-OutputPath=

]

| |

generatezenfilesystemmanifest

| |

-GenerateZenFileSystemManifest -TargetPlatform=

| |

genericconsoleoutput

| | | |

gfn

| | | |

gl

| | | |

glescompat

| | | |

gpucrashdebugging

| 启用所有可能的GPU崩溃调试模式，带来轻微的性能影响。 | | |

gpucrashdump

| 启用特定于供应商的GPU崩溃转储。 | | |

gpulockstep

| 创建信号量，用于对命令缓冲区进行多重缓冲。 | | |

gpuvalidation

| 仅在Windows上受支持。 | | |

guidedpresentation

| | | |

hdr

| 强制使用HDR。 | | |

headerdiffs

| 使用头文件对比。 | | |

help

| | | |

helpcookusage

| | | |

hidden

| | | |

hitchdetectionstackwalk

| | | |

hitchdetectionstartrunning

| | | |

hitchdetectionstartsuspended

| | | |

hwcpipe

| | | |

hybriditerativedebug

| | | |

IgnoreDebugger

| | | |

IgnoreHeaderDiffs

| | | |

immersive

| | | |

IncludeDebugOutput

| 在生成的输出中包括额外内容，辅助调试。 | | |

includedeleted

| | | |

IncludeExportHashes

| | | |

Info

| | | |

InsightsTest

| | | |

Installed

| | | |

InstalledEngine

| 启用安装的引擎行为。 | | |

installge

| 将游戏添加到资源管理器。 | | |

iterate

| 使用迭代式烘焙。 | | |

joystick

| 不需要虚拟摇杆。 | | |

JsonDebugOutput

| | | |

JsonStdOut

| | | |

KairosOnly

| | | |

KeepPackageGUIDOnSave

| | | |

KillAllPopUpBlockingWindows

| | | |

lanplay

| 是否在局域网上运行。 | | |

LazyLoadImports

| | | |

LEETIFYUnlocalized

| 将未本地化的文本转换为Leet。 | | |

List

| |

-List

[-SizeFilter=N]

| |

listformats

| 列出支持的PAK文件格式。 | | |

LiveCoding

| | | |

LLM

|

LLM_COMMANDLINE_ENABLES_FUNCTIONALITY

为true时启用低级别内存追踪器。 | | |

LLMCSV

| 启用带CSV输出的低级别内存追踪器。 | | |

LLMDISABLEAUTOPUBLISH

| 禁用低级别内存追踪器自动发布。 | | |

LOG

| 打开新日志窗口。 | | |

LogHotfixPakContents

| | | |

LogLocalizationConflicts

| 将本地化冲突记录为警告。 | | |

LogNavOctree

| | | |

logpso

| 强制对PSO进行日志记录。 | | |

logpsodetails

| 强制对PSO详情进行日志记录。 | | |

LogThreadedParticleTicking

| 记录在粒子系统中进行线程更新的原因。 | | |

LOGTOMEMORY

| | | |

longtimeouts

| 允许应用乘数，以获得网络连接的正确断开连接行为，并在需要时额外宽限。 | | |

LookLooseFirst

| 首先浏览松散PAK文件。 | | |

luna

| | | |

mallocframeprofiler

| 激活malloc帧分析器。 | 推荐启用

bGenerateSymbols

以确保调用堆栈可以解析，并启用

bRetainFramePointers

以确保帧指针保持有效。此外，禁用故障检测器

ALLOW_HITCH_DETECTION=0

有助于确保运行更快速、更准确。 | |

MatchAutoStatCapture

| 自动捕获游戏比赛的统计数据。 | | |

MAXQUALITYMODE

| 将所有

r.Shadow

控制台变量设置为最大设置。 | | |

MemPro

| 启用MemPro内存分析器。 | | |

Messaging

| 显式启用消息传递模块。 | | |

metaldistancefields

| 启用距离场AO。 | | |

metalfence

| 启用Metal Fence（MTLFence）。 | | |

metalgpudebug

| 启用Metal命令缓冲区调试。 | | |

metalheap

| 启用Metal Heap（MTLHeap）。 | | |

metaliabs

| 启用Metal IAB。 | | |

MetalIntermediateBackBuffer

| 启用对Metal中间后台缓冲区的支持。 | | |

metalmrt

| 启用对Metal MRT的支持。 | | |

MetalOffscreenOnly

| | | |

metalpointlights

| 启用对顶点-着色器-层点光源渲染的支持。 | | |

metalretainrefs

| | | |

metalshaderdebug

| 启用MetalGPU追踪。 | | |

metalsm5

| 使用Metal SM5。 | | |

metaltextureheaps

| 启用Metal纹理堆。 | | |

metaltiledreflections

| 在MacOS Metal上启用图块化反射。 | | |

metaltlv

| | | |

metalunretained

| | | |

Minimized

| | | |

mirrorshaderstats

| | | |

mixedreality

| | | |

MockGFN

| 将Mock GFN用于GeForceNOW。 | | |

MTCHILD

| 执行MT烘焙时，对最大并发异步数据块进行限制。 | | |

mtl

| 强制使用MTL RHI。 | | |

multiprocess

| 使用多进程模式。 | | |

MultiprocessOSS

| | | |

MultiprocessSaveConfig

| | | |

MutablePortableSerialization

| | | |

neverfirst

| | | |

NeverStreamOutRenderAssets

| | | |

NewConsole

| 打开新控制台窗口。 | | |

NewKeyboard

| 使用新的集成键盘。 | | |

NewTrimCache

| | | |

noailogging

| 禁用AI日志记录。 | | |

NoAmbientActors

| 将环境声Actor静音。 | | |

NoAssetRegistryCache

| 禁用资产注册表缓存。 | | |

NoAssetRegistryCacheRead

| 禁止读取资产注册表缓存。 | | |

NoAssetRegistryCacheWrite

| 禁止写入资产注册表缓存。 | | |

NoAsyncLoadingThread

| 为包流送禁用异步加载线程。 | | |

NoAsyncPostLoad

| 为包流送禁用异步后期加载。 | | |

NOAUTOINIUPDATE

| 禁止自动更新配置（

.ini

）文件。 | | |

NoCache

| | | |

nocef

| 在Web浏览器中禁用Chromium Embedded Framework（CEF）。 | | |

nocefaccelpaint

| 禁用CEF加速绘制。 | | |

nocheckpointhangdetector

| 禁用检查点挂起检测。 | | |

NoChunkInstall

| 禁用HTTP数据块安装。 | | |

NOCONSOLE

| 禁用控制台。 | | |

nod3dasync

| 禁用D3D异步资源创建。 | | |

NODDCCLEANUP

| 禁止删除未使用的DDC。 | | |

NoDebugExecBindings

| 禁止调试exec绑定。 | | |

NODEBUGOUTPUT

| 禁用单独的调试输出通道。 | | |

NODEFAULTLOG

| 禁用默认日志设备。 | | |

NoDependsGathering

| 禁止收集依赖数据。 | | |

NoDirectoryIndex

| 禁止创建目录索引。 | | |

NoDMXImportOption

| 禁用UI中的DMX导入选项。 | | |

nodrawevents

|

WITH_PROFILEGPU=1

时禁用绘制事件。 | | |

NoEditorDomain

| 禁用编辑器域。 | | |

NoEnginePlugins

| 禁用引擎插件。 | | |

NoEOS

| | | |

NoEpicPortal

| | | |

noexceptionhandler

| | | |

noeyetracking

| 禁用眼动追踪。 | | |

NoFakeForking

| 禁用伪叉取。 | | |

nofastbuildcontroller

| | | |

nofastbuildshadercompile

| | | |

nofbuildshadercompile

| | | |

NoFixupRedirectorsInCollections

| 禁止修复

FCollectionManager

中的重定向器。 | | |

NoGamepad

| 强制禁用游戏手柄。 | | |

noglobalshaderddc

| 禁用全局着色器DDC。 | | |

NoGoWide

| | | |

nogpucrashdebugging

| 禁用GPU崩溃调试。 | | |

nohdr

| 禁用HDR渲染。 | | |

noheartbeatthread

| 禁用心跳线程。 | | |

nohighdpi

| 禁用Slate中的高DPI。 | | |

nohmd

| 禁用HMD设备。 | | |

NOINI

| 不更新配置文件。 | | |

noinnerexception

| 禁用原生C++中的异常处理程序。 | | |

NoLightswitch

| | | |

NOLLM

| 禁用低级别内存追踪器。 | | |

NoLoadingScreen

| 禁用非发布构建中的加载屏幕。 | | |

NoLoadTrackClear

| 禁止重置高级别加载时间。 | | |

NoLogThread

| 禁用日志线程。 | | |

NOLOGTOMEMORY

| 禁止记录到内存。 | | |

nomaterialshaderddc

| 禁用材质着色器DDC。 | | |

NoMCP

| 禁用MCP后端。 | | |

NOMCPXMPP

| | | |

nometalfence

| 禁用MacOS Metal Fence（MTLFence）。 | | |

nometalheap

| 禁用MacOS Metal Heap。 | | |

nometalparallelencoder

| 禁用MacOS Metal并行编码器。 | | |

nometalv2

| 禁用Metal v2。 | | |

nomsaa

| 禁用多重采样抗锯齿（MSAA）。 | | |

NoPacketHandler

| 禁用数据包处理程序握手。 | | |

NoPak

| 禁用PAK文件。 | | |

noperfthreads

| | | |

NoProtectMemStack

| 启用炼狱（purgatory）和虚拟内存保护，捕获对内存堆栈项的陈旧指针。 | | |

norandomguids

| 为网络GUID禁用

SYS_getrandom

。 | | |

noraytracing

| 禁用光线追踪。 | | |

norecentproject

| 如果编辑器是从编辑器IDE启动的，不尝试加载最近的项目文件。 | | |

norelativemousemode

| 禁用Linux上的相对鼠标模式。 | | |

NoRemoteShaderCompile

| 禁用远程着色器编译。 | | |

norenderthread

| 禁用渲染线程。 | | |

NOREPLAYS

| 禁用录制文件重播。 | | |

noreuseconn

| 禁止将连接复用于Curl HTTP管理器。 | | |

norhithread

| 禁用RHI线程。 | | |

norocketcleanup

| 运行Rocket时不清理文件。 | | |

NoSaveDevAR

| 不保存开发资产注册表。 | | |

NOSCREENMESSAGES

| 禁用屏幕消息。 | | |

NoShaderCompile

| 不编译着色器。 | | |

noshaderddc

| 不检查首次遇到的材质，以模拟冷DDC。 | | |

noshaderworker

| 禁用着色器工作程序。 | | |

NOSPLASH

| 禁用启动画面。 | | |

nostablepipelinecache

| 指定管线文件缓存不稳定。 | | |

nothreading

| 禁用多线程。 | | |

nothreadtimeout

| 禁用渲染线程的线程超时。 | | |

NoTimeouts

| 禁用网络的连接超时。 | | |

NotInstalled

| 禁用安装的引擎行为。 | | |

NotInstalledEngine

| 禁用安装的引擎行为。 | | |

notracethreading

| 禁用追踪的工作线程。 | | |

NoTrials

| 禁用Oodle网络字典中的随机试用。 | | |

nouniques

| 对比两个PAK文件时，禁用两个文件的唯一文件日志记录。 | | |

nouniquesfile1

| 对比两个PAK文件时，禁用第一个文件参数的唯一文件日志记录。 | | |

nouniquesfile2

| 对比两个PAK文件时，禁用第二个文件参数的唯一文件日志记录。 | | |

novendordevice

| 禁用供应商设备类型。 | | |

NOVERIFYGC

| 禁用垃圾回收验证。 | | |

novsync

| 设置

r.vsync 0

。 | | |

nowrite

| 禁用配置文件写入。 | | |

noxgecontroller

| 禁用XGE控制器模块。 | | |

noxgeshadercompile

| 禁用XGE控制器着色器编译器。 | | |

noxrstereo

| 不使用XR系统获取立体渲染设备。 | | |

NoZenAutoLaunch

| 重载运行中Zen服务器的URL。 | | |

nullrhi

| 使用null渲染硬件接口以无界面方式运行UE。 | | |

NUTMonitorBeacon

| 启用Netcode单元测试监控信标。 | | |

NUTServer

| | | |

oldeditorstyle

| 禁用虚幻编辑器Slate的星舰样式。 | | |

onethread

| 使用单线程。 | | |

OnlyDeleted

| | | |

Oodle

| 强制启用Oodle。 | | |

OodleCapturing

| 启用Oodle捕获模式。 | | |

OodleDebugColor

| 启用Oodle调试颜色编码。 | | |

OodleDebugDump

| 启用Oodle调试转储。 | | |

OpenGL

| 使用OpenGL。 | | |

openglDebug

| 启用OpenGL调试。 | | |

openglNoDebug

| 禁用OpenGL调试。 | | |

openxrdebug

| 启用OpenXR调试。 | | |

openxrvalidation

| 启用OpenXR验证层。 | | |

PacketAudit

| 启用数据包审核器。 | | |

parallelrendering

| 启用并行渲染并设置

r.RHICmdBypass 0

。 | | |

PGOSweepToSaveDir

| | | |

PhysicsRunsOnGT

| 设置

p.PhysicsRunsOnGT 1

。 | 如果启用此项，物理线程会在游戏线程上运行，但遇到碰撞检测等任务时仍将扩大运行范围。 | |

pie

| 使用"在编辑器中运行"。 | | |

PIEVIACONSOLE

| | | |

poisonmallocproxy

| 启用内存毒性测试。 | | |

Portrait

| 重载游戏窗口设置并交换X和Y分辨率。 | | |

PostForkThreading

| 启用多线程。 | | |

PrecompiledShadersOnly

| 禁用着色器编译器。 | | |

preferAMD

| 首选AMD作为RHI适配器供应商。 | | |

PreferedHighPerformance

| 首选最佳D3D设备的高性能。 | | |

PreferedMinimalPower

| 首选最佳D3D设备的最低功耗。 | | |

preferIntel

| 首选Intel作为RHI适配器供应商。 | | |

preferMS

| 首选MS作为RHI适配器供应商。 | | |

preferNvidia

| 首选Nvidia作为RHI适配器供应商。 | | |

PreloadDevAR

| 预加载开发自动注册。 | | |

preloadmodulesymbols

| 预加载模块符号。 | | |

PrintVulkanPixelFormatMappings

| 打印Vulkan像素格式支持。 | | |

ProfileReadSpeed

| 加载提供的

.UTOC

文件并读取其完整内容。 | | |

profilestats

| 网络驱动程序的分析统计数据。 | | |

PROMPTREMOTEDEBUG

| 远程调试的提示。 | | |

PROMPTREMOTEDEBUGENSURE

| 远程调试和ensure上的远程调试的提示。 | | |

psocache

| 强制使用PSO缓存。 | | |

purgatorymallocproxy

| 启用内存炼狱（purgatory）测试。 | | |

q

| 禁用Epic门户。 | 与

-NoEpicPortal

相同。 | |

quadoverdraw

| | | |

RandomizeLoadOrder

| 设置

s.RandomizeLoadOrder 1

。 | 如果

s.RandomizeLoadOrder > 0

，则使用此种子随机化待处理程序包的加载顺序，而不是使用最高效的顺序。这可以用于查找漏洞。 | |

RandomNickname

| 将随机昵称用于社交用户中的好友。 | | |

RANDOMPACKAGEORDER

| 将随机烘焙顺序用于程序包。 | | |

RCProtocolsDisable

| 禁用远程控制协议模块。 | | |

RCWebControlDisable

| 禁用Web远程控制模块。 | | |

RCWebControlEnable

| 在

-game

和打包游戏中强制启用Web控制模块。 | | |

RCWebInterfaceEnable

| 在

-game

、打包的游戏中以及编译计算机上强制启用Web控制接口模块。 | | |

rdgclobberresources

| 设置

r.RDG.ClobberResources 1

。 | 在分配时间使用请求的清除颜色清除所有渲染目标和纹理缓冲区UAV。适合用于调试。 | |

rdgdebug

| 设置

r.RDG.Debug 1

。 | 针对连接和执行通道期间找到的效率低下情况输出警告。发射警告一次。 | |

rdgdebugextendresourcelifetimes

| 设置

r.RDG.ExtendResourceLifetimes 1

。 | 扩展资源的资源生命周期，以便它们无法与图表中的其他任何资源重叠内存。适合用于在临时锯齿导致问题时进行调试。 | |

rdgimmediate

| 设置

r.RDG.ImmediateMode 1

。 | 通道一创建就执行。适合用于在使通道的lambda崩溃时获得连接代码的调用堆栈。 | |

rdgtransitionlog

| 设置

r.RDG.TransitionLog -1

。 | 针对所有帧将资源过渡记录到控制台。 | |

RebuildHLODs

| 强制重新编译HLOD。 | | |

RedirectNSLog

| | | |

ReduceThreadUsage

| 禁用任务图表和线程池。 | | |

REGENERATEINIS

| 重新生成配置文件。 | | |

RELEASEANALYTICS

| 为

FAnalytics

设置

EAnalyticsBuildType::Release

。 | | |

RemapPluginContentToGame

| | | |

RemoteControlIsHeadless

| 将远程控制Web界面的通知系统配置为不发射UI通知。 | | |

RemoveInvalidKeys

| 删除输入设置的无效密钥。 | | |

Rename

| | | |

RenderOffScreen

| 在屏幕之外渲染。 | | |

Repack

| 重新打包PAK文件。 |

-Repack

[-Output=

]

| |

RepDriverDisable

| 设置

Net.RepDriver.Enable 0

。 | 使用旧版网络驱动程序实现。 | |

RepDriverEnable

| 设置

Net.RepDriver.Enable 1

。 | 启用复制启动程序。 | |

reportpso

| 强制报告新PSO。 | | |

ResetTutorials

| 为所有教程重置"看过此教程？（Have seen this tutorial?）"标记。 | | |

ResumeRunTest

| | | |

rhithread

| 启用RHI线程。 | | |

rhiunittest

| 运行RHI单元测试。 | | |

RHIValidation

| 启用RHI验证。 | | |

RunningFromUnrealEd

| 世界分区编译器命令是否从虚幻编辑器运行。 | | |

RUNNINGUNATTENDEDSCRIPT

| 虚幻引擎是否在运行无人照管的脚本。 | | |

SaveForDiff

| | | |

SavePackagesThatHaveFailedLoads

| 保存有失败加载的程序包。 | | |

SaveToUserDir

| 保存到用户目录。 | | |

savevulkanpsocacheonexit

| 在关闭期间保存Vulkan PSO缓存。 | | |

SCRIPTSTACKONWARNINGS

| 在警告上显示Kismet脚本堆栈。 | | |

SendAutomationAnalytics

| 发送自动化控制器分析。 | | |

SetupHLODs

| 将世界分区HLOD编译器设置为使用

EHLODBuildStep::HLOD

| | |

ShaderCodeLibrarySeparateLoadingCache

| | | |

ShaderSymbolsExportZip

| 创建着色器符号输出文件。 | | |

sign

| 启用容器签名。 | | |

signed

| | | |

signedpak

| 检查PAK签名。 | | |

SILENT

| 禁用所有日志文本输出。 | | |

SimMobile

| 模拟移动体验。 | | |

singlescanneronly

| 使用单个扫描程序线程。 | | |

SingleThreadedPhysics

| 将单个线程用于物理。 | | |

SkipAssetScan

| 跳过资产管理器资产扫描。 | | |

skipbuildpatchprereq

|强制跳过先决条件安装。 | | |

SKIPCOMPILE

| 启动时跳过编译。 | | |

SkipHotfixCheck

| 跳过热修复检查。 | | |

SkipMapCheck

| 跳过地图检查。 | | |

SkipOptionalPakFiles

| 跳过可选的PAK文件。 | | |

SkipPatchCheck

| 跳过补丁检查。 | | |

skippsoclear

| 跳过清除PSO缓存。 | | |

skipreplayrollback

| 跳过启动Actor回滚。 | | |

SkipSaveAssetRegistry

| 跳过保存资产注册表。 | | |

SlateDebug

| 创建用于调试的Slate测试窗口。 | | |

sm5

| 强制使用SM5。 | | |

sm6 | 强制使用SM6。 | |

| 列 1 | 列 2 | 列 3 |
| --- | --- | --- |
| `SortByOrdering` | 按提供的顺序对PAK文件排序。 | 与 `-order=<COMMA_SEP_STRING_FILE_ORDER>` 一起使用。 |
| `SoundWaveDataHasStreamingDisabled` | 允许编辑器加载为禁用了流送的平台保存的数据。 |  |
| `StableNullID` | 为在线子系统Null强制使用稳定Null ID。 |  |
| `Staged2Zen` |  | `-Staged2Zen -BuildPath=<Path> -ProjectName=<ProjectName> -TargetPlatform=<Platform>` |
| `staticswitches` | 显示静态开关使用和成本的详细信息。 |  |
| `statnamedevents` | 启用命名统计数据事件。 |  |
| `statunit` | 启动时执行 `stat unit` 控制台命令。 |  |
| `stdout` | 将stdout用于日志输出。 |  |
| `Streaming` | 使用流送网络平台文件。 |  |
| `streamingaccuracy` | 强制流送准确性。 |  |
| `streamingbuild` | 强制纹理流送构建。 |  |
| `TAKERECORDERISHEADLESS` | 针对镜头试拍录制器强制使用无界面行为并禁用通知。 |  |
| `TaskGraphForceNewBackend` | 设置 `TaskGraph.NumForegroundWorkers 2` 或使用提供的 `-foregroundworkers=` 。 | 配置前景工作线程的数量。 |
| `TaskGraphForceOldBackend` |  |  |
| `Test` |  | `-Test <PakFile>` |
| `TESTANALYTICS` | 将分析构建类型设置为 `EAnalyticsBuildType::Test` 。 |  |
| `testdocs` | 文档的Web版本优先于磁盘上的版本。 |  |
| `testeditordomaindeterminism` | 测试编辑器域确定性。 |  |
| `testsanitizer` | 为在线子系统启用消息净化器子系统。 |  |
| `TestTutorialAlerts` | 测试虚幻编辑器启动教程警报。 |  |
| `textconfig` |  |  |
| `threading` | `DEFAULT_NO_THREADING=1` 时启用多线程。 |  |
| `TrackBootLoading` |  |  |
| `TREATLOADWARNINGSASERRORS` | 将加载警告视为错误。 |  |
| `unattended` | 以无人照管模式运行。 | 无人照管的应用程序未由任何人监控，无法接收用户输入。使用此项可禁用UI弹窗和其他对话框。 |
| `uninstallge` | 卸载游戏资源管理器。 |  |
| `UnitTestClientDebug` | 等同于 `-windowed -resx=1024 -resy=768 <PARAMS_LIST> -ini:Engine:[DevOptions.Shaders]:bAllowAsynchronousShaderCompiling=False` 以及虚函数 `SetupDefaultClientParameters` 中要添加的命令。 | Usage `-UnitTestClientDebug -UnitTestClientParams="<PARAMS_LIST>"` |
| `USEALLAVAILABLECORES` | 使用所有可用核心。 |  |
| `useaudiocapturetimecode` | 强制使用音频捕获时间码。 |  |
| `UseFixedTimeStep` | 使用固定时间步长。 |  |
| `usehyperthreading` | 使用超线程。将逻辑核心限制设置为物理核心限制。 |  |
| `UseIoStore` | 强制使用Io Store。 |  |
| `UseLocalIPs` |  |  |
| `UseNSUrlConnection` | 使用NSUrl连接。 | 已弃用。在UE 5.4中已删除。 |
| `UsePaks` | 使用PAK文件。 |  |
| `useperfthreads` | 强制使用线程以提高性能。 |  |
| `UseSwappyThreads` | `USE_ANDROID_OPENGL_SWAPPY=1` 时启用swappy线程。 |  |
| `UTF8Output` | 将输出设置为UTF8。 |  |
| `Verbose` | 使用详细日志记录。 |  |
| `verbosenamedevents` | 为外部分析器命名的事件发射详细统计数据。 |  |
| `Verify` | 验证PAK文件。 | 用途：`-Verify -Test <PakFile>` 。 |
| `VerifyDDC` | 验证从DDC检索的项目。 |  |
| `VERIFYGC` | 设置 `gc.VerifyAssumptions true` 。 |  |
| `verifyhashdatabase` | 读取并哈希资产注册表以验证注册表中的现有哈希。 |  |
| `vktrace` | 启用Vulkan追踪层。 |  |
| `VMGPU` | 启用虚拟多GPU模式。 |  |
| `vr` | 使用VR模式。 |  |
| `VREditor` | 在VR模式下启动虚幻编辑器。 |  |
| `vsync` | 设置 `r.vsync 1` 。 |  |
| `vulkan` | 使用Vulkan RHI。 |  |
| `vulkanapidump` | 启用Vulkan API转储层。 |  |
| `vulkanbestpractices` | 启用Vulkan最佳实践验证功能。 |  |
| `vulkandebug` | 设置 `r.Vulkan.EnableValidation 2` 。 | 启用错误和警告。 |
| `vulkandebugmarkers` | 强制启用Vulkan调试标识。 |  |
| `vulkandebugsync` | 启用Vulkan同步验证功能。 |  |
| `WaitAndForkRequireResponse` | 等待响应信号。 | 用法 `-WaitAndForkRequireResponse -WaitAndForkResponseTimeout=<TIME>` 。 |
| `waitforattach` | 停止启动并等待调试器附加后继续。 |  |
| `waitforattachcrc` | 停止启动并等待崩溃报告客户端器附加后继续。 |  |
| `WaitForDebugger` | 停止启动并等待调试器附加后继续。 | 与 `-waitforattach` 相同。 |
| `WarnIfAssetsLoaded` | 启用资产加载时的警告。 |  |
| `WARNINGSASERRORS` | 将警告视为错误。 |  |
| `WhatsAtOffset` |  | 用法：`-WhatsAtOffset <PakFile> [Offset...]` 。 |
| `Windowed` | 使用窗口模式。 | 使用 `-Windowed -ResX=<HORIZONTAL> -ResY=<VERTICAL>` 指定水平和垂直分辨率。 |
| `writepakchunkorder` |  |  |
| `xgecontroller` | 启用XGE控制器。 |  |
| `xrtrackingonly` | 仅将XR用于追踪信息，不渲染到XR设备。 |  |
| `ZenLoader` | 设置 `s.ZenLoaderEnabled true` 。 |  |

## 关键字参数

下表包含虚幻引擎命令行关键字参数的列表。运行这些命令的语法是 `-<Keyword>=<Value>` 。

例如，要运行虚幻编辑器并指定在端口 `8888` 上侦听传入的在线信标连接，请输入：

```
	UnrealEditor.exe -BeaconPort=8888
```

这些命令不区分大小写，因此以下命令全部等效：

```
	UnrealEditor.exe -BeaconPort=8888	UnrealEditor.exe -beaconport=8888	UnrealEditor.exe -BEACONPORT=8888
```

### 关键字参数列表

| **参数** | **说明** | **备注和用法** |
| --- | --- | --- |
| `AbsCrashReportClientLog` | 指定崩溃报告客户端的日志，不检查文件名长度。 |  |
| `ABSLOG` | 绝对日志文件名。 | 不检查文件名长度。 |
| `aes` | AES加密密钥。 | 已弃用。请改用 `-cryptokeys=`。 |
| `allowsyscallfilterfile` | 系统调用筛选器文件路径。 |  |
| `ANALYTICSAPPVERSION` | 强制使用特定AppVersion进行分析。 |  |
| `ANALYTICSUSERID` | 重载分析用户ID。 |  |
| `AssetRegistryFile` | 资产注册表文件路径。 |  |
| `AssetRegistryWriteback` | 打开提供的容器目录，并将资产的程序包的区块大小信息添加到其在资产注册表中的资产标签。这也可以在预演过程中使用 `-WriteBackMetadataToAssetRegistry` 执行。 | 资产注册表回写需要 `-ContainerDirectory=Path/To/Containers`。预演之后的AssetRegistryWriteback已弃用，将在5.5中删除。在预演期间通过项目打包设置使用回写。 |
| `AutomatedPerfTesting` |  |  |
| `AutoSubmitTags` | 自动提交标签用于世界分区编译器命令。 |  |
| `Base` | 对比资产批量数据命令的基础开发资产注册表。 |  |
| `BasedOnReleaseVersion` | 依赖发布版本的资产注册表的发布版本。 |  |
| `BasedOnReleaseVersionPath` | 依赖发布版本的资产注册表的发布版本路径。 |  |
| `BeaconPort` | 重载在线信标主机的默认端口。 |  |
| `BENCHMARKSECONDS` | 添加用于基准设定的秒设置。 | 仅在设置 `FApp::IsBenchmarking` 时应用的秒数版本。这样在iOS上会更轻松，其中有一个开关设置用于启用基准设定，但不希望让用户还必须禁用秒数设置。即使基准设定未启用， `-seconds=` 将在设定的时间后退出应用。注意：如果指定此项，这将覆盖 `-seconds=` 。 |
| `Builder` | 世界分区编译器命令编译器类名。 |  |
| `BuilderCount` | 世界分区HLOD编译器的编译器数量。 |  |
| `BuilderIdx` |  |  |
| `BuildHLODLayer` | 要编译的HLOD层。 |  |
| `BuildIdOverride` | 要重载的编译ID。 | 常用于将匹配范围缩小到特定服务器。 |
| `BuildManifest` | 世界分区HLOD编译器的构建清单。 |  |
| `BuildPath` |  | 用法：`-Staged2Zen -BuildPath=<Path> -ProjectName=<ProjectName> -TargetPlatform=<Platform>` 。 |
| `BuildSingleHLOD` | 要编译的HLOD Actor。 |  |
| `BuildVersion` |  |  |
| `CapturePercentage` | 在Oodle捕获模式中指定捕获百分比。 | 用法：`-OodleCapturing -CapturePercentage=<Percent>`。 |
| `cefdebug` | 要为CEF调试的端口。 |  |
| `ClientNetPingICMPAddress` |  |  |
| `ClientNetPingUDPAddress` |  |  |
| `ClusterCSV` | 使用指定路径创建群集CSV。 |  |
| `Commands` | 为IO Store工具指定命令列表文件。 |  |
| `compresslevel` | 程序包压缩的Oodle压缩级别。 |  |
| `compressmethod` | Oodle压缩方法。 |  |
| `ConsoleTitle` | 设置控制台输出窗口的标题。 |  |
| `ConsoleX` | 设置控制台输出窗口的水平位置。 |  |
| `ConsoleY` | 设置控制台输出窗口的垂直位置。 |  |
| `ContainerDirectory` | 打开给定的容器目录和给定的资产注册表，并将资产的程序包的区块大小信息添加到其在资产注册表中的资产标签。 | 用法：`-AssetRegistryWriteback=<Filename> -ContainerDirectory=<Path>` 。 |
| `CookerOrder` |  | 已弃用。`-CookerOrder=` 将被IoStore忽略。`-GameOrder=` 和 `-CookerOrder=` 已弃用，而改用 `-Order`。 |
| `CrashGUID` | 使用此GUID创建特定于崩溃的目录。 |  |
| `cryptokeys` | 指定加密密钥缓存文件。 |  |
| `csv` |  | 用法：`-list=<ContainerFile> -csv=<path>` 。 |
| `csvABTest` | CSV分析器A/B测试字符串。 |  |
| `csvABTestStatFrameOffset` | 要偏移统计数据的帧数。 |  |
| `csvABTestSwitchDuration` | 切换时长的帧数。 |  |
| `csvCaptureFrames` | 帧数。 |  |
| `csvCaptureOnEventFrameCount` | 发生事件时要捕获的帧数。 |  |
| `csvCategories` | CSV分析器类别列表。 | 用法：`-csvCategories="<Cat1>,<Cat2>,...,<CatN>"`。 |
| `csvCompression` | CSV分析器压缩模式。设置 `csv.CompressionMode` 。 | 控制CSV文件在写出时是否压缩。如果为0，则强制禁用压缩，所有文件都作为未压缩的 `.csv` 文件写入。如果为1，则强制启用压缩，所有文件都作为压缩的 `.csv.gz` 文件写入。 |
| `csvMetadata` | CSV分析器元数据列表。 | 用法：`-csvMetadata="<Key1>=<Value1>,<Key2>=<Value2>,...,<KeyN>=<ValueN>"`。 |
| `csvRepeat` | CSV重复数量。 |  |
| `CULTURE` | 文本本地化管理器使用提供的文化。 | 适合用于测试本地化。 |
| `CULTUREFORCOOKING` | 重载请求的文本本地化管理器文化，用于从命令行烘焙。 |  |
| `Current` |  |  |
| `DCID` | 数据中心ID。 |  |
| `DebugSound` | 调试音频声音命令。 |  |
| `DebugSymbols` | 调试符号路径。 |  |
| `DefaultViewportMouseCaptureMode` | 设置默认视口 `EMouseCaptureMode`。 |  |
| `Describe` |  | 用法：`-Describe=<Path> -PackageFilter=<Filter> -DumpToFile=<Path> [-IncludeExportHashes]`。 |
| `DeveloperReportOutputPath` |  | 已弃用。使用不带参数的 `-DeveloperReport`。 |
| `DevelopmentAssetRegistryPlatformOverride` | 开发资产注册表的平台重载。 |  |
| `DeviceProfile` | 重载设备描述名称。 |  |
| `diffonlybreakoffset` | 要中断的对比偏移。 |  |
| `diffoutputdir` | 提供的目录的输出对比。 |  |
| `DisplayReportOutputPath` | 报告URL路径。 |  |
| `DLCNAME` |  |  |
| `DP` | 重载设备描述名称。 |  |
| `DPCVar` | 使用提供的控制台变量重载设备描述设置。 |  |
| `DPCVars` | 使用提供的控制台变量重载设备描述设置。 |  |
| `DPFragments` | 重载所选设备描述片段。 | 用法：`-DPFragments=fragmentname,fragmentname2,[taggedname]fragment,...`。 |
| `DumpClustersWithObjects` | 将带有UObject的群集转储到日志。 |  |
| `DumpRPCs` | 挂接所有RPC调用，并将函数和完整参数列表转储到日志。 | 用法：`-DumpRPCs` or `-DumpRPCs="<RPC1>,<RPC2>,...,<RPCN>"`。 |
| `DumpToFile` |  |  |
| `EditorPixelStreamingRes` | 虚幻编辑器像素流送分辨率。 |  |
| `EditorPixelStreamingResX` | 虚幻编辑器像素流送水平分辨率。 |  |
| `EditorPixelStreamingResY` | 虚幻编辑器像素流送垂直分辨率。 |  |
| `enabledrpccategories` | 带有外部RPC注册表的已启用RPC类别的列表。 |  |
| `EncryptionKeyOverrideGuid` | 重载加密密钥。 |  |
| `enginedir` | 用于编译插件的引擎根目录。 |  |
| `EOSArtifactNameOverride` | 重载EOS构件名称。 |  |
| `EPICAPP` | 重载Epic应用构件名称。 | 该值通常来自Epic游戏商城，你不需要指定此项。 |
| `EPICENV` | 重载Epic Env。 |  |
| `EpicSandboxId` | 重载Epic沙盒ID。 | 该值通常来自Epic游戏商城，你不需要指定此项。 |
| `EXEC` | 执行指定的exec文件。 |  |
| `ExecCmds` | 执行指定的控制台命令。 | 用法： `-ExecCmds="<Cmd1> <Val1>',<Cmd2> '<Val2>',...,<CmdN> '<ValN>'"` |
| `extractedpakcryptokeys` | 提取的PAK加密密钥文件。 |  |
| `extractedpaktemp` |  |  |
| `ExtraReleaseVersionAssets` |  |  |
| `eyetracking` | 指定显式HMD模块。 |  |
| `filehostip` | 文件主机IP。 |  |
| `fileserverport` | 重载文件服务器端口。 |  |
| `Filter` |  |  |
| `ForceTickMax` | 强制使用最大更新时间切片。 |  |
| `ForceTickMin` | 强制使用最小更新时间切片。 |  |
| `FPS` | 重载固定的更新速率帧/秒。 |  |
| `FullscreenDisplay` |  |  |
| `GameOrder` |  | 已弃用。`-GameOrder=` 已弃用，而改用不带参数的 `-Order`。 |
| `gauntlet` | 运行指定的Gauntlet测试控制器。 |  |
| `graphicsadapter` |  |  |
| `handleensurepercent` | 处理ensure的时间百分比。 |  |
| `hmd` | 指定显式HMD模块。 |  |
| `HordeBatchId` | Horde批处理ID。 |  |
| `HordeJobId` | Horde作业ID。 |  |
| `HordeStepId` | Horde步骤ID。 |  |
| `HordeStepName` | Horde步骤名称。 |  |
| `HordeTemplateId` | Horde模板ID。 |  |
| `HordeTemplateName` | Horde模板名称。 |  |
| `HOTFIXPREFIX` |  |  |
| `HTTP` | HTTP模式。 |  |
| `httpproxy` | HTTP代理地址。 |  |
| `IniBootstrap` | 引导指定的配置缓存文件。 |  |
| `InspectChunk` |  |  |
| `InstallBundleCacheSize` | 重载安装缓存大小。 |  |
| `iterative` |  |  |
| `List` |  | 用法：`-list=<ContainerFile> -csv=<path>`。 |
| `LLMTrackPeaks` | 将 `LLM.TrackPeaks` 设置为指定值。 | 跟踪每个类别中自进程开始时间而不是当前帧的值以来的峰值内存。 |
| `-LOG` | 指定日志文件名。 |  |
| `logcategoryfiles` |  |  |
| `LogCommand` | 指定每个类别的日志冗长度。 | 用法：`-LogCommand="LogLine=Command"`。 |
| `LogDebug` | 为指定日志类别执行调试日志跟踪。 |  |
| `LOGFLUSHINTERVAL` | 将 `log.flushInterval` 设置为指定值。 | 日志记录间隔，以秒为单位。默认值为 `0.2f`。 |
| `LogHighlights` | 指定每个类别中控制台输出的日志类别颜色。逗号分隔的字符串列表。 | 用法：`-LogHighlights="LogNet Cyan, LogTemp Green"`。 |
| `LogStringHighlights` | 基于匹配字符串指定控制台输出中的日志字符串颜色。逗号分隔的字符串列表。 | 用法：`-LogStringHighlights="UNetConnection::Close=Purple, NotifyAcceptingConnection accepted from=DarkGreen"`。 |
| `LogTrace` | 为指定行添加用于日志跟踪的日志行。 |  |
| `MacCursorTypeOverride` | 重载MacOS光标类型。 |  |
| `MacExplicitRenderer` | 将 `Mac.ExplicitRendererID` 设置为指定值。 | 强制Mac RHI使用指定的渲染设备，它是 `FMacPlatformMisc::GetGPUDescriptors` 提供的GPU列表中从0开始的索引，或使用-1禁用，而使用默认设备。 |
| `Manifest` | S3缓存存储的清单。 |  |
| `map` | 使用提供的地图。 |  |
| `MaterialStatsMirror` | 材质统计数据镜像位置。 |  |
| `MaxAlloc` | 将malloc的最大单次分配限制为此字节数。 | 适合用于调试。 |
| `MaxDiffstoLog` | 要记录的最大对比数量。 |  |
| `MaxGPUCount` | 启用多个GPU或虚拟GPU时的最大GPU数量。 |  |
| `MaxPartySize` | 重载最大战队大小。 |  |
| `MCPCONFIG` | MCP配置重载。 |  |
| `McpRegion` | 强制特定MCP区域ID。 |  |
| `McpSubregion` | 强制特定MCP子区域ID。 |  |
| `mcsf` | 移动内容比例系数。 |  |
| `MemBucket` | 内存大小桶重载。 |  |
| `MemProTags` | MemPro内存分析器标签。 |  |
| `MergePaks` | 合并提供的PAK文件列表。 | 用法：`-MergePaks=Pak1+Pak2+...+PakN`。 |
| `MetalProfileFrames` | 要使用Metal RHI分析器分析的帧数。 |  |
| `MetalPSOCache` | 指定Metal PSO缓存模式。 |  |
| `MLAdapterPort` | 使用指定端口启动新的RPC服务器。 |  |
| `mobileresx` | 设置移动模式中的X（水平）分辨率。 |  |
| `mobileresy` | 设置移动模式中的Y（垂直）分辨率。 |  |
| `mode` | 场景组件渲染的详细模式。 |  |
| `ModulesBootstrap` | 引导模块。 | 适合用于通过重新加载模块管理器的序列化状态，避免开销大的目录枚举。 |
| `msaa` |  |  |
| `MULTIHOME` | 多宿主IP地址。 |  |
| `NetDriverOverrides` | 重载网络驱动程序。 | 每当使用逗号时使用引号。 格式： 重载主/游戏网络驱动程序（最常见用法）： `-NetDriverOverrides=DriverClassName` 覆盖特定/命名的网络驱动程序： `-NetDriverOverrides="DefName,DriverClassName"` 重载特定驱动程序，包括回退驱动程序： `-NetDriverOverrides="DefName,DriverClassName,DriverClassNameFallback"` 重载多个网络驱动程序： `-NetDriverOverrides="DriverClassName;DefName2,DriverClassName2"` 示例： 将WebSocket用于主游戏网络驱动程序： `-NetDriverOverrides=/Script/WebSocketNetworking.WebSocketNetDriver` 将WebSocket用于主游戏网络驱动程序和战队信标网络驱动程序： `-NetDriverOverrides="/Script/WebSocketNetworking.WebSocketNetDriver;BeaconNetDriver,/Script/WebSocketNetworking.WebSocketNetDriver"` |
| `NetTrace` | 设置网络跟踪冗长度。 |  |
| `NETWORKPROFILER` | 设置网络分析器的标签。 |  |
| `networkversionoverride` | 设置用于多人游戏的网络版本。 |  |
| `NewGridSize` | 更改世界分区的网格大小。 |  |
| `NewPackage` |  |  |
| `NUTConnectionTimeout` | 设置自定义网络驱动程序超时。 |  |
| `OodleCompressDLL` | 使用更早的编码器为发布的游戏维护相同的位流，避免补丁。 | 如果你想使用Oodle的最新引擎版本进行编码，请勿指定此项。 |
| `OodleSpaceSpeedTradeoff` | 调整Oodle Hydra压缩器，或使你的压缩偏向于更高的压缩率或更快的解码。 |  |
| `Order` |  |  |
| `OrderPriority` |  |  |
| `out` |  |  |
| `outorder` |  |  |
| `Output` |  |  |
| `OutputDir` |  |  |
| `OutputFile` | 创建二进制配置命令的输出文件。 |  |
| `OutputPath` |  |  |
| `PackageFilter` |  |  |
| `PackageStoreManifest` | 程序包存储清单文件的路径。 |  |
| `PakFile` |  | 用法：`-PakFile=<FileName> -Output=<FileName> [-Signed]`。 |
| `PatchCryptoKeys` | 带有补丁引用数据的加密密钥的文件名。 |  |
| `PATHS` |  |  |
| `pgoprofileoutput` | PGO配置文件输出目录。 |  |
| `PixelStreamingControlScheme` |  |  |
| `PixelStreamingFastPan` |  |  |
| `PixelStreamingID` |  |  |
| `PixelStreamingIP` |  |  |
| `PixelStreamingPort` |  |  |
| `PixelStreamingURL` |  |  |
| `Platform` |  |  |
| `PlatformName` |  |  |
| `PLATFORMTEST` | 在线子系统本地平台名称。 |  |
| `PlatformVariantName` |  |  |
| `Port` | 默认服务器端口。 |  |
| `PresentGPU` | 指定GPU以可视化在使用多个GPU时每个GPU渲染的内容。 |  |
| `Project` | `.uproject` 文件的路径。 |  |
| `project` |  |  |
| `projectdir` |  |  |
| `ProjectName` |  | 用法：`-Staged2Zen -BuildPath=<Path> -ProjectName=<ProjectName> -TargetPlatform=<Platform>`。 |
| `QueryPort` | 在线子系统（Steam）的服务器列表查询的默认查询端口。 | 还可以在 `[OnlineSubsystemSteam]` 引擎配置中使用 `GameServerQueryPort` 字段设置。默认端口是 `27015`。 |
| `rdgasynccompute` | 设置 `r.RDG.AsyncCompute`。 | 控制异步计算策略： 0：禁用，不使用异步计算 1：为标记了异步计算的通道而启用（默认值） 2：为能够使用计算命令列表而实现的所有计算通道而启用 |
| `rdgbreakpoint` | 设置 `r.RDG.Breakpoint`。 | 满足特定条件时调试器中的断点。 0：关闭（默认值） 1：出现RDG警告时 2：匹配调试筛选器的图表/通道编译时 3：匹配调试筛选器的图表/通道执行时 4：匹配调试筛选器的图表/通道/资源创建或销毁时 |
| `rdgcullpasses` | 设置 `r.RDG.Cullpasses`。 | 图表剔除带有未使用的输出的通道。 0：关闭 1：打开，默认值 |
| `rdgdebuggraphfilter` | 设置 `r.RDG.Debug.GraphFilter`。 | 将特定调试事件筛选到特定图表。设置为"None"以重置。 |
| `rdgdebugpassfilter` | 设置 `r.RDG.Debug.PassFilter`。 | 将特定调试事件筛选到特定通道。设置为"None"以重置。 |
| `rdgdebugresourcefilter` | 设置 `r.RDG.Debug.ResourceFilter`。 | 将特定调试事件筛选到特定资源。设置为"None"以重置。 |
| `rdgevents` | 设置 `r.RDG.Events`。 | 控制如何发射RDG事件。 0：关闭 1：启用事件并遵守 `RDG_EVENT_SCOPE_FINAL` （默认值） 2：启用事件并忽略 `RDG_EVENT_SCOPE_FINAL` |
| `rdgmergerenderpasses` | 设置 `r.RDG.MergeRenderPasses`。 | 图表将完全相同的连续渲染通道合并为单个渲染通道。 0：关闭 1：打开（默认值） |
| `rdgoverlapuavs` | 设置 `r.RDG.OverlapUAVs`。 | RDG将在请求时与UAV工作重叠；如果禁用，始终会插入UAV屏障。 |
| `rdgparallelexecute` | 设置 `r.RDG.ParallelExecute`。 | 支持时是否启用通道的并行执行。 0：关闭 1：打开（默认值） |
| `rdgparallelsetup` | 设置 `r.RDG.ParallelSetup`。 | RDG将在受到 `FRDGBuilder::FlushSetupQueue` 的调用提示时并行设置通道。 0：通道设置在 `AddPass` 中同步执行 1：通道设置异步执行（默认值） |
| `rdgtransientallocator` | 设置 `r.RDG.TransientAllocator`。 | RDG将使用 `RHITransientResourceAllocator` 分配所有临时资源。 0：禁用临时分配器 1：启用临时分配器（默认值） 2：仅使用 `FastVRAM` 标记为资源启用临时分配器 |
| `ReplicationCSVCaptureFrames` | 有客户端连接时启动CSV捕获，并在经过指定帧数之后自动终止进程。 |  |
| `ReportExportPath` | 自动化报告导出路径。 |  |
| `ReportOutputPath` |  | 已弃用。请改用 `-ReportExportPath=`。 |
| `ReportURL` | 自动化报告URL。 |  |
| `Res` | 设置窗口分辨率。 | 用法：`-Res=1280x768` 等效于 `-ResX=1280 -ResY=768`。 |
| `responseFile` | 使用指定名称生成PAK响应文件。 | 用法：`-Extract <PakFile> <OutputPath> [-responsefile=<outputresponsefilename> -order=<outputordermap>]`。 |
| `ResumeBuild` | 要恢复世界分区HLOD编译器的索引。 |  |
| `ResX` | 指定窗口宽度分辨率。 |  |
| `ResY` | 指定窗口高度分辨率。 |  |
| `SAVEWINPOS` | 将窗口位置加载/保存到游戏用户设置配置文件。 |  |
| `ScalabilityIniPlatformOverride` | 伸缩性配置平台重载文件。 |  |
| `ScriptObjects` | 脚本对象文件的路径。 |  |
| `SECONDS` | 最长更新时间，以秒为单位。 |  |
| `SessionFilter` | 设置会话筛选器。 | 用法：`-SessionFilter=<Filter1>+<Filter2>+...+<FilterN>`。 |
| `SessionLabel` | 设置会话标签。 |  |
| `SimulcastParameters` | 设置像素流送联播参数。 | 用法：`-SimulcastParameters=[Scaling1,MinBitrate1,MaxBitrate1,...,ScalingN,MinBitrateN,MaxBitrateN]`。 |
| `SizeFilter` | PAK文件大小筛选器。 | 用法：`-List <PakFile> [-SizeFilter=N]`。 |
| `SORT` | 在对比资产注册表中对报告的文件排序。 | 选项：name、size、class、change |
| `Source` | 用于对比的源文件。 | 用法：`-Diff -Source=<Path> -Target=<path>`。 |
| `SourceCryptoKeys` | 包含源加密密钥的文件。 |  |
| `StagedPluginsFile` |  |  |
| `StartupPaksWildcard` |  |  |
| `statsPort` | HTTP统计数据端口。 |  |
| `streaminghostip` |  |  |
| `SVNPass` | SVN源码控制密码。 |  |
| `SVNRepo` | SVN源码控制仓库名称。 |  |
| `SVNUser` | SVN源码控制用户名。 |  |
| `Target` |  |  |
| `TargetCryptoKeys` | 包含目标加密密钥的文件。 |  |
| `TargetPlatform` | 目标平台。 |  |
| `TaskGraphUseDynamicPrioritization` | 使用任务图表中的动态优先级安排。 |  |
| `TcpMessagingListen` | 要在其中侦听TCP消息传递连接的IP端点。 | 用法：`-TcpMessagingListen=<IP>:<Port>`。 |
| `TelemetryDirectory` | 自动化遥测的目录。 |  |
| `testexit` |  |  |
| `TestLoops` | 自动化测试的测试循环数量。 |  |
| `UnitTestCap` | 将首次运行单元测试的数量限制为此数量。 |  |
| `UseIrisReplication` | 强制使用Iris复制系统。 | 如果值大于0，使用Iris。如果值为0或更低，使用通用复制系统。如果命令行中未指定，使用配置的默认复制系统。 |
| `virtmemkb` | 将进程虚拟内存大小限制为指定的KB数。 |  |
| `vulkanpresentmode` | 指定Vulkan RHI演示模式。 | 选项： 0：立即 1：邮箱 2： FIFO |
| `vulkanvalidation` | 设置 `r.Vulkan.EnableValidation`。 | 设置Vulkan RHI验证模式。 0：禁用验证层 1：启用错误 2：启用错误和警告 3：启用错误、警告和性能警告 4：启用错误、警告、性能警告和参考消息 5：启用所有消息 |
| `WinX` | 设置初始水平窗口位置。 |  |
| `WinY` | 设置初始垂直窗口位置。 |  |
| `WriteBackMetadataToAssetRegistry` | 将压缩资产大小写回资产注册表。 | 选项： AdjacentFile OriginalFile 禁用 |
| `ZenCfgPath` |  |  |
| `ZenDataPath` |  |  |
| `ZenLogPath` |  |  |
