# Android Manifest控制

---
title: "Android Manifest控制"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/how-to-use-android-manifest-control-in-unreal-engine-projects"
breadcrumbs: ["虚幻引擎5.7文档", "移动端开发", "Android支持", "Android开发指南", "Android Manifest控制"]
---

# Android Manifest控制

> 路径：虚幻引擎5.7文档 / 移动端开发 / Android支持 / Android开发指南 / Android Manifest控制

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/how-to-use-android-manifest-control-in-unreal-engine-projects

**AndroidManifest.xml** 文件用于存储在"项目设置（Projects Settings）"的 **Advanced APKPackaging** 部分中设置的各种Android系统权限和设置。在以下文档中，我们将阐述如何输入将添加到AndroidManifest.xml文件中的命令，以满足 **虚幻引擎4**（UE4）项目的需求。

## Android Manifest查找

需要先将项目打包或部署到Android设备才能查找项目的AndroidManifest.xml文件。构建或部署好项目后，可以在 **（项目名称）\Intermediate\Android\APK** 中找到AndroidManifest.xml文件。

![undefined](../../../../../assets/images/4c/4c596ff5afcbf835ebbe4908a205a9bcd1fdb643f32d8beafaa7a40d683ad1e4.jpg)

单击查看大图。

> [!WARNING]
> 在任何情况下都 **绝不能** 编辑AndroidManifest.xml文件。如果AndroidManifest.xml文件需要编辑，应在UE4编辑器的"Advanced APK Packing"部分中进行。

## Android Manifest布局

在典型的AndroidManifest.xml文件中，你将看到以下三个部分：

- Application Definition
- Activity
- **Requirements**

  ```
            <manifest xmlns:android="http://schemas.android.com/apk/res/android"              package="com.yourcompany.project"              android:versionCode="1"              android:versionName="1.0.0">		              <-- Application Definition -->              <application android:label="@string/app_name"          android:icon="@drawable/icon" android:hasCode="true">                  <activity android:name="com.epicgames.ue4.GameActivity"                  </activity>              </application>		               <-- Requirements -->               <uses-sdk android:minSdkVersions="9"/>               <uses-feature android android:glEsVersion="0x00020000"          android:required="true" />               <uses-permission          android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>          </manifest>		
  ```

> [!NOTE]
> 请注意，上面的Android Manifest文件不是有效的清单文件，仅用于参考目的。

## Manifest的额外标签

可以为Manifest添加额外的标签，方法是单击 **加号** 图标来向标签数组中添加新的元素，然后将要使用的一个或多个标签输入到输入框中。在此示例中，使用的是以下标签：**android:sharedUserId="Foo"**。

输入到"Extra Tags for Manifest"部分中的标签将添加到AndroidManifest.xml文件的 **manifest** 部分。

```
	<manifest xmlns:android="http://schemas.android.com/apk/res/android"	package="com.YourCompany.AndroidManifest"	android:sharedUserId="Foo"	android:versionCode="1"	android:versionName="1.0"> 
```

## 应用的额外标签

可以为Application添加额外的标签，方法是单击 **加号** 图标来向应用程序数组中添加新的元素，然后输入要使用的标签。在此示例中，使用的是以下标签：**android:hardwareAccelerated="True"**。

输入到"Extra Tags for Application"部分中的项将添加到AndroidManifest.xml文件的 **Application Definition** 部分。

```
		<application android:label="@string/app_name"	 android:icon="@drawable/icon"	 android:hardwareAccelerated="True"	 android:hasCode="true"> 
```

## 应用的额外设置

可以为应用程序添加额外的设置以供使用，方法是在 **Extra Settings for < application>** 部分中输入要使用的设置。如果要使用多个设置，请添加 **\n** 来分隔每个设置。在此示例中，添加了以下两项：**android:banner="Foo"** 和 **android:vmSafeMode="True"**。

输入到"Extra Settings for <Android:nameapplication>"部分中的项将添加到AndroidManifest.xml文件的 **Activity** 部分。

```
		</activity>		<activity android:name=".DownloaderActivity" android:screenOrientation="landscape" android:configChanges="screenSize|orientation|keyboardHidden|keyboard" android:theme="@style/UE4SplashTheme" />		<meta-data android:name="com.epicgames.ue4.GameActivity.DepthBufferPreference" android:value="0" />		<meta-data android:name="com.epicgames.ue4.GameActivity.bPackageDataInsideApk" android:value="false" />		<meta-data android:name="com.epicgames.ue4.GameActivity.bVerifyOBBOnStartUp" android:value="false" />		<meta-data android:name="com.epicgames.ue4.GameActivity.bShouldHideUI" android:value="false" />		<meta-data android:name="com.epicgames.ue4.GameActivity.ProjectName" android:value="AndroidManifest" />		<meta-data android:name="com.epicgames.ue4.GameActivity.bHasOBBFiles" android:value="true" />		<meta-data android:name="com.epicgames.ue4.GameActivity.bSupportsVulkan" android:value="false" />		<meta-data android:name="com.google.android.gms.games.APP_ID" android:value="@string/app_id" />		<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />		<activity android:name="com.google.android.gms.ads.AdActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize" />			android:banner="Foo"			android:vmSafeMode="True"		<service android:name="OBBDownloaderService" /><receiver android:name="AlarmReceiver" /></application> 
```

## UE4游戏活动的额外标签

可以向 **Extra Tags for UE4.GameActivity node** 部分添加额外的标签，方法是单击 **加号** 图标来向"Extra Tags for UE4.GameActivity node" 数组中添加新的元素并输入要使用的标签。

