---
title: "Slate控件示例"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/slate-ui-widget-examples-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "创建用户界面", "Slate UI框架", "Slate控件示例"]
---

# Slate控件示例

> 路径：虚幻引擎5.7文档 / 创建用户界面 / Slate UI框架 / Slate控件示例

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/slate-ui-widget-examples-for-unreal-engine

## 通用Slate参数

以下参数通用于创建的所有控件。

- IsEnabled——指定是否能够与控件交互。如果禁用，则显示为灰色。
- ToolTip——指定该控件工具提示将使用哪一类自定义SToolTip控件。如果不指定，则不显示。
- ToolTipText——指定将显示哪一类文本作为该控件工具提示的简单提示文本。如果不指定，或者使用了ToolTip属性，则不显示。
- Cursor——指定鼠标悬浮于该控件时将显示的光标。
- Visibility——请参阅下面的"可视性"部分。

以下参数并不能适用于所有控件，但它们适用于大多数控件。

- Text——指定该控件拥有的文本（如果适用）。
- Content——指定应在控件内容部分中放置哪个控件（如果适用）。
- ReadOnly——如果为_true_，阻止编辑该控件。
- Style——指定控件使用的图像或字体样式。适用情况取决于控件。
- [...]ColorAndOpacity——控件或指定系统的颜色和不透明度。
- Padding——以slate单位表示的控件空间填充量，这里指在父代内控件的上下左右部分的空间。可以为所有四个部分指定一个值、指定一个水平和一个垂直值或者指定为四个单独的值。
- HAlign——控件内部内容水平对齐。
- VAlign——控件内部内容垂直对齐。

### 可视性

控件可视性决定了控件如何显示及其交互性。

- Visible（默认值）——控件正常显示。
- Collapsed——控件不可见，并且在局部中不占据空间。不可交互。
- Hidden——控件不可见，但在布局中占据空间。不可交互。
- HitTestInvisible——对用户可见，但仅显示为图片。不可交互。
- SelfHitTestInvisible——与HitTestInvisible相同，但不适用于子控件。

### 对齐

控件对齐决定了控件在其父代内部的位置。如果控件的父代与控件尺寸相同（不包含填充空间），则对齐没有意义。对于盒插槽，当您为该控件指定"填充（Fill）"或盒插槽指定"填充大小"（Fill Size）时，默认属于这种情况。

可能的对齐如下所示：

- HAlign_Fill/VAlign_Fill
- HAlign_Left
- VAlign_Top
- HAlign_Center/VAlign_Center
- HAlign_Right
- VAlign_Bottom

## 盒面板

**SHorizontalBox** 和 **SVerticalBox** 是设计布局时最常用的控件。这些盒面板声明为控件，但它们中间也会插入插槽。SHorizontalBox中的这些插槽的布局方式是第一个控件位于最左侧，最后一个位于最右侧，而SVerticalBox是自上而下布局。

**SScrollBox** 函数类似于SVerticalBox，唯一不同的是允许子插槽垂直滚动。

### 插槽属性

- 宽度或高度设置（以下选项互斥）：

  - 自动大小

    （默认值）——指定插槽将根据需要填充空间，但不会超额。插槽内的对齐不重要。
  - 填充大小

    ——指定填充系数将使其根据其他插槽的填充系数占据空间。朝着同一方向的插槽对齐不重要。
- 最大大小

  ——指定插槽可以拥有的最大大小，使用slate单位。
- 填充

  ——指定面板内的插槽填充。
- 对齐

  ——指定子控件如何在插槽内对齐。如果以相同方向指定"填充大小"，则该选项毫无意义。

以下是滚动盒中嵌套的自定大小水平盒和填充大小水平盒的示例。此外还显示了如何对这些插槽使用对齐。

```
	SNew(SScrollBox)	+SScrollBox::Slot() .Padding(10,5)	[		SNew(SHorizontalBox)		+SHorizontalBox::Slot() .HAlign(HAlign_Left)		[			...		]		+SHorizontalBox::Slot() .HAlign(HAlign_Center)		[			...		]		+SHorizontalBox::Slot() .HAlign(HAlign_Right)		[			...		]	]	+SScrollBox::Slot() .Padding(10,5)	[		SNew(SHorizontalBox)		+SHorizontalBox::Slot() .FillWidth(2)		[			...		]		+SHorizontalBox::Slot() .FillWidth(1)		[			...		]		+SHorizontalBox::Slot() .FillWidth(3)		[			...		]	] 
```

### 统一网格面板

**SUniformGridPanel** 是一个均匀地垂直和水平分发子控件的面板。其子插槽使用一对整数指定，它们指定子代的索引。下面是一个统一网格面板。

```
	SNew(SUniformGridPanel)	.SlotPadding( FMargin( 5.0f ) )	+SUniformGridPanel::Slot(0,0)	.HAlign(HAlign_Right)	[		...	]	+SUniformGridPanel::Slot(0,1)	.HAlign(HAlign_Right)	[		...	]	+SUniformGridPanel::Slot(0,2)	.HAlign(HAlign_Center)	[		...	]	+SUniformGridPanel::Slot(1,0)	[		...	]	+SUniformGridPanel::Slot(1,1)	[		...	] 
```

### 自动换行框

**SWrapBox** 是一个水平排列控件的框，这些控件超过一定宽度后，继续在下一行排列，以此类推。下面是一个示例。

```
	SNew(SWrapBox)	.PreferredWidth( 300.f )	+SWrapBox::Slot()	.Padding( 5 )	.VAlign(VAlign_Top)	[		...	]	+SWrapBox::Slot()	.Padding( 5 )	.VAlign(VAlign_Bottom)	[		...	]	+SWrapBox::Slot()	.Padding( FMargin(20, 5, 0, 5) )	.VAlign(VAlign_Center)	[		...	]	+SWrapBox::Slot()	.Padding( 0 )	.VAlign(VAlign_Fill)	[		...	] 
```

## 单选按钮

**单选按钮** 是slate中的复选框，因为复选框需要用于确定它们是否被选中的委托。为了创建一系列单选按钮，最简单的方法是创建用于确定选中了哪个复选框的列举。保存用于确定当前选项的列举实例。然后，对于检查委托，传递一个函数来比较正确列举的传入有效内容与当前选择。在更改选项时，需要更新当前选项。

```
	ERadioChoice CurrentChoice; 	... 	ECheckBoxState::Type IsRadioChecked( ERadioChoice ButtonId ) const	{		return (CurrentChoice == ButtonId)			? ECheckBoxState::Checked			: ECheckBoxState::Unchecked;	} 	... 	void OnRadioChanged( ERadioChoice RadioThatChanged, ECheckBoxState::Type NewRadioState )	{		if (NewRadioState == ECheckBoxState::Checked)		{			CurrentChoice = RadioThatChanged;		}	} 
```

## 菜单和工具栏

### 菜单

要创建菜单或工具栏，使用多箱。命令应当使用Slate的UI_COMMAND系统，虽然这可以通过动态生成的按钮/控件完成。

要创建菜单，使用 **FMenuBarBuilder** 和传入的 **FUICommandList**，您可以在菜单栏构建器上调用 **MakeWidget()** 来放置控件。

```
	FMenuBarBuilder MenuBarBuilder( CommandList );	{		MenuBarBuilder.AddPullDownMenu( TEXT("Menu 1"), TEXT("Opens Menu 1"), FNewMenuDelegate::CreateRaw( &FMenus::FillMenu1Entries ) ); 		MenuBarBuilder.AddPullDownMenu( TEXT("Menu 2"), TEXT("Opens Menu 2"), FNewMenuDelegate::CreateRaw( &FMenus::FillMenu2Entries ) );	} 	return MenuBarBuilder.MakeWidget(); 
```

在创建的菜单中，您可以向菜单添加创建的菜单标题、条目、分隔符、子菜单、可编辑文本或自定义控件。

```
	static void FillMenu1Entries( FMenuBuilder& MenuBuilder )	{		MenuBuilder.AddEditableText( TEXT( "Editable Item" ), TEXT( "You can edit this item's text" ), NAME_None, TEXT( "Edit Me!" ) ); 		MenuBuilder.AddMenuEntry( FMultiBoxTestCommandList::Get().EighthCommandInfo ); 		MenuBuilder.AddMenuSeparator(); 		MenuBuilder.AddSubMenu( TEXT("Sub Menu"), TEXT("Opens a submenu"), FNewMenuDelegate::CreateRaw( &FMenus::FillSubMenuEntries ) ); 		MenuBuilder.AddWidget(SNew(SVolumeControl), TEXT("Volume"));	} 
```

### 快捷菜单

要调用其中一个子菜单作为快捷菜单，从 **FMenuBuilder** 生成该控件，并传递给 **PushMenu()** 函数，如下所示。

```
	FSlateApplication::Get().PushMenu(		MenuBuilder.MakeWidget(),		MouseCursorLocation,		FPopupTransitionEffect( FPopupTransitionEffect::ContextMenu )		); 
```

### 工具栏

要创建工具栏，使用 **FToolBarBuilder**。对于子代，您可以添加工具栏按钮、组合框按钮、普通按钮和下拉菜单。

```
	FToolBarBuilder GameToolBarBuilder( InCommandList );	{		GameToolBarBuilder.AddToolBarButton( FLevelEditorCommands::Get().Simulate ); 		GameToolBarBuilder.AddToolBarButton(			FLevelEditorCommands::Get().RepeatLastPlay,			LOCTEXT("RepeatLastPlay", "Play"),			TAttribute< FString >::Create( TAttribute< FString >::FGetter::CreateRaw( &FLevelEditorActionCallbacks::GetRepeatLastPlayToolTip ) ),			TAttribute< const FSlateBrush* >::Create( TAttribute< const FSlateBrush* >::FGetter::CreateRaw( &FLevelEditorActionCallbacks::GetRepeatLastPlayIconSlateBrush ) )			); 		GameToolBarBuilder.AddComboButton(			SpecialPIEOptionsMenuAction,			FOnGetContent::CreateRaw( &FLevelEditorToolBar::GeneratePIEMenuContent, InCommandList ),			FText(),			LOCTEXT("PIEComboToolTip", "Play-In-Editor options") );	} 	return GameToolBarBuilder.MakeWidget(); 
```

## 项目视图

这些视图采用指向某一类数据的共享指针的模板参数。它们根据数据类型由 **TArray** 或 **TSharedPtr** 填充。这些内部控件使用传入的 **OnGenerateRow** 或 **OnGenerateTile** 委托动态填充，针对每个列生成不同的控件。

### 列表视图

列表视图是用于存储一列子控件的控件。他们被设为`SListView<...>`。

```
	SNew( SListView< TSharedPtr<FTestData> > )	.ItemHeight(24)	.ListItemsSource( &Items )	.OnGenerateRow( this, &STableViewTesting::OnGenerateWidgetForList )	.OnContextMenuOpening( this, &STableViewTesting::GetListContextMenu )	.SelectionMode( this, &STableViewTesting::GetSelectionMode )	.HeaderRow	(		SNew(SHeaderRow)		+ SHeaderRow::Column("Name")		[			SNew(SBorder)			.Padding(5)			.Content()			[				SNew(STextBlock)				.Text(TEXT("Name"))			]		]		+ SHeaderRow::Column("Number") .DefaultLabel(TEXT("Number"))		+ SHeaderRow::Column("TextField") .DefaultLabel(TEXT("Text Field"))		+ SHeaderRow::Column("TextBlock") .DefaultLabel(TEXT("Text Block"))		+ SHeaderRow::Column("AddChild") .DefaultLabel(TEXT("Add Child"))	) 
```

### 树状视图

设为`STreeView<...>`的树状视图类似于列表视图，唯一不同的是它们支持将控件设为列表中其他控件的父代。要确定哪些控件是哪些控件的父代，使用 **OnGetChildren** 委托将传入项目的子代传回。

```
	SNew( STreeView< TSharedPtr<FTestData> > )	.ItemHeight(24)	.TreeItemsSource( &Items )	.OnGenerateRow( this, &STableViewTesting::OnGenerateWidgetForTree )	.OnGetChildren( this, &STableViewTesting::OnGetChildrenForTree )	.OnContextMenuOpening( this, &STableViewTesting::GetTreeContextMenu )	.SelectionMode( this, &STableViewTesting::GetSelectionMode )	.HeaderRow	(		SNew(SHeaderRow)		+ SHeaderRow::Column("Name") .DefaultLabel(TEXT("Name"))		+ SHeaderRow::Column("Number") .DefaultLabel(TEXT("Number"))		+ SHeaderRow::Column("TextField") .DefaultLabel(TEXT("Text Field"))		+ SHeaderRow::Column("TextBlock") .DefaultLabel(TEXT("Text Block"))		+ SHeaderRow::Column("AddChild") .DefaultLabel(TEXT("Add Child"))	) 
```

### 平铺视图

设为`STileView<...>`的平铺视图类似于列表视图，唯一不同的是子代控件在网格中布局，而不是列表。因此，它们不支持列或列标题。

```
	SNew( STileView< TSharedPtr<FTestData> > )	.ItemWidth(128)	.ItemHeight(64)	.ListItemsSource( &Items )	.OnGenerateTile( this, &STableViewTesting::OnGenerateWidgetForTileView )	.OnContextMenuOpening( this, &STableViewTesting::GetTileViewContextMenu )	.SelectionMode( this, &STableViewTesting::GetSelectionMode )
```
