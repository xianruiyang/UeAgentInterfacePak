# 【UEFN】ORM TextureのパッキングからUEFN上での利用までの流れ【Optimize】

# 【UEFN】ORM TextureのパッキングからUEFN上での利用までの流れ【Optimize】

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/lw94/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 3532 字符。

## 摘要

UEFNにおける最適化の1つとしてTextureをORM Textureとしてパッキングするという物があります。 本チュートリアルでは各マスクTextureをORM Textureにパッキングした上でUEFN上で利用するまでの流れを解説しています。

## 中文整理

### 介绍

UEFNにおける最適化の1つとしてTextureをORM Textureとしてパッキングするという物があります 本チュートリアルでは各マスクTextureをORM Textureにパッキングした上でUEFN上で利用するまでの流れを解説しています

### 確認バージョン

虚幻引擎 5.4 UEFN 30.00

### 什么是 ORM 纹理？

ORM TextureはTextureを定義するRGBの3チャンネルにRはアンビエントオクルージョン、Gにラフネス、Bにメタリックとそれぞれ白黒のマスクテクスチャを入れ込み、1枚のTextureとして書き出した物になります - [参考記事](https://note.com/takumini23/n/n9a648e66985a)

### ORM Textureを利用するメリット

主だったメリットは - 3枚のTextureを1枚にパッキングするため単純計算でTexture 2枚分容量が減る - Epic Base や Fortnite BaseのMaterialを利用しやすくなり、Master Materialの数も削減しやすい

### 打包成 ORM 纹理

Textureのパッキング作業そのものはPhotoshopを始めとした画像編集ソフトで行うことが可能です ただし、今回はUnreal Engine Marketplaceで販売されているEasyTexturePackerを利用します というのも、EasyTexturePackerは価格がお手頃(定価で$4.99)なだけでなく非常に習得が容易で作業手順もシンプルなため、半自動化によるパッキングを初心者でも手軽に行えます - [EasyTexturePacker](https://unrealengine.com/marketplace/ja/product/easy-texture-packer)

### 1, Unreal EngineにEasyTexturePackerを追加する

Marketplace上でEasyTexturePackerを購入するとマイダウンロード欄に表示されます 「プロジェクトに追加する」から実作業を行うUE5のプロジェクトを選択します

![我的下载](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-01.jpg)

### 2, EasyTexturePackerを追加したプロジェクトにパッキングを行いたいMarketplaceアセットをインポートする

EasyTexturePackerと同じく、Marketplaceのアセットをプロジェクトにインポートします 今回はScifi Kitbash Level Builderを利用してみました

![科幻 Kitbash 关卡生成器](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-02.jpg)

### 3, プロジェクトを起動し、LV_ETP_Demo_Roomを開く

EasyTexturePackerフォルダ内に用意されているDemo Levelを開きます

![演示级别](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-03.jpg)

### 4、包纹理

Level上にあるBP_ETPを選択し、必要な設定を行います

![設定箇所](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-04.jpg)

なお、各設定項目の詳細についてはEasyTexturePackerの公式ドキュメントをご覧ください - [EasyTexturePacker ドキュメント](https://omid-ghajar.gitbook.io/easytexturepacker-etp)

### 5, プレビューして出力する

Create Textureを押すことでTextureがプレビューされ、Back Textureを押すことでTextureが指定したファイルパスに出力されます

![创建、烘焙纹理](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-05.jpg)

![烘焙质感](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-06.jpg)

### UEFNへアセットを移行する

アセット移行の流れについては公式ドキュメントに記載されていますので割愛します 今回は関連する「Static Mesh、Texture」を移行しています 移行方法についての詳細は以下をご確認ください - [アセットを UEFN に移行する](https://dev.epicgames.com/documentation/ja-jp/unreal-engine/migrating-assets-from-unreal-engine-to-uefn)

### UEFN上でのMaterialの構築

### 1, 移行したTexture類からMaterialを作成する

EasyTexturePackerでベイクしたORM Texture、Base Texture、Normal Textureの3点を元にMaterialを作成します 今回はM_EpicBase_Parentを使ったMaterial Instanceに必要なTextureをアサインして利用します M_EpicBase_Parentは以下のパスに保存されています /All/Epic/Materials/EpicBase/M_EpicBase_Parent

![M_EpicBase_Parent](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-07.jpg)

M_EpicBase_Parentを右クリックして、Create Material Instanceをクリックすることで保存先を指定する画面が表示され、保存先を指定することでM_EpicBase_Parentを利用したMaterial Instanceを作成できます

![创建材质实例](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-08.jpg)

### 2, 作成したMaterial InstanceにTextureを割り当てる

Material Instanceを開くと、Master MaterialであるM_EpicBase_Parentで公開されているパラメーター郡が表示されます 今回は以下の画像で赤枠をつけているTexture Parameterへの設定のみ行っています - BaseColor_Texture：Base - NormalMap_Texture：Normal Map - TextureAmbientOcclusion_OR_Specular,Roughness,Metallic_Texture：ORM Texture また、必要に応じて各パラメーターを操作して見た目を調整してください

![Material Instanceの中身](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-09.jpg)

- [材质库](https://dev.epicgames.com/documentation/ja-jp/uefn/material-library-in-unreal-editor-for-fortnite)

### 3, 作成したMaterial InstanceをStatic Meshに割り当てる

作成したMaterial InstanceをStatic MeshにアサインすればORM Texture化とUEFN上での利用準備は完了です 以下の画像でUEFN上でMaster Material Epic BaseとORM Textureを利用したパターンとUE5上でのオリジナルデータそれぞれの見え方の差を見てみましょう ▼UEFN上でMaster Material Epic Baseを作成し、Base Texture、ORM Texture、Normal Mapをアサインした場合

![UEFN上でマテリアルの割当](assets/unreal-engine-fortnite-uefn-orm-texture-uefn-optimize/image-10.jpg)

▼UE5上でのオリジナルアセット

### 概括

いかがでしたでしょうか？ 現状、UEFNにおいてTextureはBase Textureでも無い限りMask用は0.5K以下まで落とすといったケースが多いかと思います。しかし、アンビエントオクルージョン、ラフネス、メタリックとそれぞれが分かれているとチリツモでプロジェクトサイズやメモリの負荷に繋がりかねません そういった物をORM Texture化し、Epic BaseやFortnite Baseを継承したMaterial Instanceを利用することで、プロジェクトサイズもメモリも節約になるという点は非常に強いメリットかと思います また、現段階でUEFNユーザーがUnreal Engineを操作するケースの殆どはMarketplaceアセットを移行する場合かと思われますので、移行の際に合わせてTextureをパッキングしておくというワークフローも良いかもしれませんね ただし、UE5上でのオリジナルアセットはそのアセットのためにオリジナルのMaster Materialを用意しているため、Master MaterialであるEpic Baseを使う場合は完璧に同じ見た目でにできるわけではない点は注意点かと思います 一方で見た目の差異が許容できるのであれば、プロジェクトサイズやメモリサイズ削減のために置き換えるというのは最適化の手法の1つになるかと思いますので、対応項目として検討するというのも有用かと考えます 以上です

## 相关链接

- [参考記事](https://note.com/takumini23/n/n9a648e66985a)
- [EasyTexturePacker](https://unrealengine.com/marketplace/ja/product/easy-texture-packer)
- [EasyTexturePacker ドキュメント](https://omid-ghajar.gitbook.io/easytexturepacker-etp)
- [アセットを UEFN に移行する](https://dev.epicgames.com/documentation/ja-jp/unreal-engine/migrating-assets-from-unreal-engine-to-uefn)
- [マテリアル ライブラリ](https://dev.epicgames.com/documentation/ja-jp/uefn/material-library-in-unreal-editor-for-fortnite)

