# MGMob 接入文档
MGMob 聚合了 激励视频和积分墙任务 四种平台的广告

### 添加 SDK 到工程中
- 添加如下依赖
项目更目录下的build.gradle文件中添加：
```
allprojects {
    repositories {
           maven { url 'https://jitpack.io' }
       }
}
```
app目录下build.gradle文件中添加：
```
dependencies {
    api 'com.android.support.constraint:constraint-layout:1.1.3'
    api 'com.android.support:support-v4:28.0.0'
    api 'com.android.support:appcompat-v7:28.0.0'
    api 'com.android.support:recyclerview-v7:28.0.0'

    api 'com.android.support:multidex:1.0.3'
    api 'com.squareup.retrofit2:retrofit:2.6.0'
    api 'com.squareup.retrofit2:adapter-rxjava2:2.6.0'
    api 'com.squareup.retrofit2:converter-gson:2.6.0'
    api 'com.google.code.gson:gson:2.8.6'//数据解析
    api 'io.reactivex.rxjava2:rxjava:2.2.10'
    api 'io.reactivex.rxjava2:rxandroid:2.1.1'
    api 'org.greenrobot:eventbus:3.2.0'//事件分发
    api 'com.blankj:utilcode:1.29.0'

    api 'com.kk.taurus.playerbase:playerbase:3.3.5'  //视频播放器
    api 'com.just.agentweb:agentweb:4.1.3'//网页加载
    api 'com.download.library:Downloader:4.1.3'//下载
    api 'com.github.bumptech.glide:glide:4.5.0'//图片加载
    api 'com.liulishuo.filedownloader:library:1.7.7'//下载jar
    api 'com.github.mangosdk:Ad_Core:1.0.0'
    api 'com.github.mangosdk:MGMob:1.0.1'
}
```

> 如果之前接入了 广点通、穿山甲等SDK，需要将原来的aar文件删除，因为 MGMob 中包含了这些 SDK

### 调用方法

- 在 Application 的 onCreate 里面初始化

```
    /*
     * 可自行选择自定义穿山甲的配置，不配置就会使用穿山甲的默认值
     */
    //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView
    TogetherAdCsj.INSTANCE.setUseTextureView(false);
    //是否允许sdk展示通知栏提示
    TogetherAdCsj.INSTANCE.setAllowShowNotify(true);
    //是否在锁屏场景支持展示广告落地页
    TogetherAdCsj.INSTANCE.setAllowShowPageWhenScreenLock(true);
    //测试阶段打开，可以通过日志排查问题，上线时去除该调用
    TogetherAdCsj.INSTANCE.setDebug(BuildConfig.DEBUG);
    //允许直接下载的网络状态集合
    TogetherAdCsj.INSTANCE.setDirectDownloadNetworkType(TTAdConstant.NETWORK_STATE_WIFI | TTAdConstant.NETWORK_STATE_4G);
    //自定义网络库，demo中给出了okhttp3版本的样例，其余请自行开发或者咨询工作人员。
    //TogetherAdCsj.INSTANCE.setHttpStack(new MyHttpStack());
    //是否支持多进程，true支持
    TogetherAdCsj.INSTANCE.setSupportMultiProcess(false);
    //标题栏的主题色
    TogetherAdCsj.INSTANCE.setTitleBarTheme(TTAdConstant.TITLE_BAR_THEME_DARK);

    //初始化MGMob
    MGMob mgMob = MGMob.getInstance(this, "ERRRaIIYGq", "efgQRSTZhijKopqr2345");
    //初始化积分墙
    mgMob.initIntegralWallInfo(10006);
    //初始化激励视频
    mgMob.initVideoInfo(10018, "Demo", BuildConfig.DEBUG);
```

- 创建激励广告的实例

```
    AdHelperReward adHelperReward = new AdHelperReward(MainActivity.this, MGMobAlias.Reward, null, new RewardListener() {
        @Override
        public void onAdStartRequest(@NonNull String providerType) {
            addLog("\n开始请求: " + providerType);
        }

        @Override
        public void onAdLoaded(@NonNull String providerType) {
            addLog("请求到了: " + providerType);
        }

        @Override
        public void onAdFailed(@NonNull String providerType, String failedMsg) {
            addLog("请求失败: " + providerType);
        }

        @Override
        public void onAdFailedAll(@Nullable String failedMsg) {
            addLog("全部失败: " + failedMsg);
        }

        @Override
        public void onAdClicked(@NonNull String providerType) {
            addLog("点击了: " + providerType);
        }

        @Override
        public void onAdShow(@NonNull String providerType) {
            addLog("展示了: " + providerType);
        }

        @Override
        public void onAdExpose(@NonNull String providerType) {
            addLog("曝光了: " + providerType);
        }

        @Override
        public void onAdVideoComplete(@NonNull String providerType) {
            addLog("视频播放完成: " + providerType);
        }

        @Override
        public void onAdVideoCached(@NonNull String providerType) {
            addLog("视频已缓存: " + providerType);
        }

        @Override
        public void onAdRewardVerify(@NonNull String providerType) {
            addLog("激励验证: " + providerType);
        }

        @Override
        public void onAdClose(@NonNull String providerType) {
            addLog("关闭了: " + providerType);
        }
    });
```

- 请求激励广告

```
adHelperReward.load();
```

- 展示激励广告

```
adHelperReward.show();
```

> 注意：load、show方法要求必须在 UI 线程执行

### 权限
- 开发者需要添加必要权限
```
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<!--可选权限-->
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<uses-permission android:name="android.permission.GET_TASKS" />

<!--可选，穿山甲提供“获取地理位置权限”和“不给予地理位置权限，开发者传入地理位置参数”两种方式上报用户位置，两种方式均可不选，添加位置权限或参数将帮助投放定位广告-->
<!--请注意：无论通过何种方式提供给穿山甲用户地理位置，均需向用户声明地理位置权限将应用于穿山甲广告投放，穿山甲不强制获取地理位置信息-->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

<!-- 如果有视频相关的广告且使用textureView播放，请务必添加，否则黑屏 -->
<uses-permission android:name="android.permission.WAKE_LOCK" />
```
- 动态申请权限：开发者请自行根据情况决定是否动态申请该权限（ 有助于提高广告的填充率 ）

```
Manifest.permission.READ_PHONE_STATE
```

### 代码混淆
如果您需要使用proguard混淆代码，需确保不要混淆SDK的代码。 请在proguard.cfg文件(或其他混淆文件)尾部添加如下配置:
```
    -keepattributes Exceptions, Signature, InnerClasses, SourceFile, LineNumberTable
    # 忽略警告
    -ignorewarning
    # 指定代码的压缩级别
    -optimizationpasses 5
    # 包名不混合大小写
    -dontusemixedcaseclassnames
    # 不去忽略非公共的库类
    -dontskipnonpubliclibraryclasses
    # 优化 不优化输入的类文件
    -dontoptimize
    # 预校验
    -dontpreverify
    # 混淆时是否记录日志
    -verbose
    # 混淆时所采用的算法
    -optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

    # 避免混淆泛型
    -keepattributes Singature
    # 保护注解
    -keepattributes *Annotation*

    #####################记录生成的日志数据,gradle build时在本项目根目录输出################
    #apk 包内所有 class 的内部结构
    -dump class_files.txt
    # 未混淆的类和成员
    -printseeds seeds.txt
    # 列出从 apk 中删除的代码
    -printusage unused.txt
    # 混淆前后的映射
    -printmapping mapping.txt

    ##=================基础=================#
    -keep public class * extends android.app.Fragment
    -keep public class * extends android.app.Activity
    -keep public class * extends android.app.Application
    -keep public class * extends android.app.Service
    -keep public class * extends android.content.BroadcastReceiver
    -keep public class * extends android.content.ContentProvider
    -keep public class * extends android.support.v4.app.Fragment
    -keep public class * extends android.widget.PopupWindow
    -keep public class * extends android.preference.Preference
    -keep public class com.android.vending.licensing.ILicensingService
    # 如果引用了v4或者v7包
    -dontwarn android.support.**
    -keep class android.support.v7.** { *; }
    -keep class android.support.v4.** { *; }
    -keep interface android.support.v4.app.** { *; }

    -keep class android.net.http.SslError
    -keep class android.webkit.**{*;}
    -keep class cn.sharesdk.**{*;}
    -keep class m.framework.**{*;}

    ##=================kotlin=================#
    -keep class kotlin.** { *; }
    -keep class kotlin.Metadata { *; }
    -dontwarn kotlin.**
    -keepclassmembers class **$WhenMappings {
        <fields>;
    }
    -keepclassmembers class kotlin.Metadata {
        public <methods>;
    }
    -assumenosideeffects class kotlin.jvm.internal.Intrinsics {
        static void checkParameterIsNotNull(java.lang.Object, java.lang.String);
    }

    -keepclasseswithmembernames class * {
        native <methods>;
    }

    -keepclassmembers class * extends android.app.Activity {
       public void *(android.view.View);
    }
    -keepclassmembers class * implements android.os.Parcelable {
      public static final android.os.Parcelable$Creator *;
    }
    -keep class **.R$* {*;}
    -keepclassmembers enum * { *;}

    ############混淆保护自己项目的部分代码以及引用的第三方jar包library-end##################
    -keep public class * extends android.view.View {
        public <init>(android.content.Context);
        public <init>(android.content.Context, android.util.AttributeSet);
        public <init>(android.content.Context, android.util.AttributeSet, int);
        public void set*(...);
        public void get*(...);
    }
    # 保持 native 方法不被混淆
    -keepclasseswithmembernames class * {
        native <methods>;
    }
    # 保持自定义控件类不被混淆
    -keepclasseswithmembers class * {
        public <init>(android.content.Context, android.util.AttributeSet);
    }
    # 保持自定义控件类不被混淆
    -keepclasseswithmembers class * {
        public <init>(android.content.Context, android.util.AttributeSet, int);
    }
    # 保持自定义控件类不被混淆
    -keepclassmembers class * extends android.app.Activity {
       public void *(android.view.View);
    }

    -keepclassmembers class * {
       public <init>(org.json.JSONObject);
    }

    # 保持 Parcelable 不被混淆
    -keep class * implements android.os.Parcelable {*;}
    # 保持 Serializable 不被混淆
    -keepnames class * implements java.io.Serializable
    # 保持 Serializable 不被混淆并且enum 类也不被混淆
    -keepclassmembers class * implements java.io.Serializable {
        static final long serialVersionUID;
        private static final java.io.ObjectStreamField[] serialPersistentFields;
        !static !transient <fields>;
        !private <fields>;
        !private <methods>;
        private void writeObject(java.io.ObjectOutputStream);
        private void readObject(java.io.ObjectInputStream);
        java.lang.Object writeReplace();
        java.lang.Object readResolve();
    }

    # 保持枚举 enum 类不被混淆 如果混淆报错，建议直接使用上面的 -keepclassmembers class * implements java.io.Serializable即可
    -keepclassmembers class * {
        public void *ButtonClicked(android.view.View);
    }
    # 不混淆资源类
    -keepclassmembers class **.R$* {
        public static <fields>;
    }

    # webview + js
    -keepattributes *JavascriptInterface*
    -keep class com.just.agentweb.** {
        *;
    }
    -dontwarn com.just.agentweb.**

    ################RxPermissions#################
    -keep class com.tbruyelle.rxpermissions2.** { *; }
    -keep interface com.tbruyelle.rxpermissions2.** { *; }

    ##Glide
    -dontwarn com.bumptech.glide.**
    -keep class com.bumptech.glide.**{*;}
    -keep public class * implements com.bumptech.glide.module.GlideModule
    -keep public class * extends com.bumptech.glide.AppGlideModule
    -keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
      **[] $VALUES;
      public *;
    }

    ##---------------Begin: proguard configuration for Gson  ----------
    # Gson uses generic type information stored in a class file when working with fields. Proguard
    # removes such information by default, so configure it to keep all of it.
    -keepattributes Signature

    # For using GSON @Expose annotation
    -keepattributes *Annotation*

    # Gson specific classes
    -dontwarn sun.misc.**
    #-keep class com.google.gson.stream.** { *; }

    # Application classes that will be serialized/deserialized over Gson
    -keep class com.google.gson.examples.android.model.** { <fields>; }

    # Prevent proguard from stripping interface information from TypeAdapterFactory,
    # JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
    -keep class * implements com.google.gson.TypeAdapterFactory
    -keep class * implements com.google.gson.JsonSerializer
    -keep class * implements com.google.gson.JsonDeserializer

    # Prevent R8 from leaving Data object members always null
    -keepclassmembers,allowobfuscation class * {
      @com.google.gson.annotations.SerializedName <fields>;
    }

    ##---------------End: proguard configuration for Gson  ----------

    #EventBus
    -keepattributes *Annotation*
    -keepclassmembers class ** {
        @org.greenrobot.eventbus.Subscribe <methods>;
    }
    -keep enum org.greenrobot.eventbus.ThreadMode { *; }

    # Only required if you use AsyncExecutor
    -keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
        <init>(java.lang.Throwable);
    }


    #=================OkHttp3====================
    -keep class com.squareup.okhttp3.** { *;}
    -keep class okhttp3.** { *;}
    -keep class okhttp3.internal.**{*;}
    -keep class okio.** { *;}
    -dontwarn okhttp3.logging.**
    -dontwarn com.squareup.okhttp3.**
    -dontwarn okio.**
    -dontwarn okhttp3.**
    -dontwarn javax.annotation.**
    -dontwarn javax.inject.**

    #=================Okio=================
    -dontwarn com.squareup.**
    -dontwarn okio.**
    -keep public class org.codehaus.* { *; }
    -keep public class java.nio.* { *; }

    #=================Retrofit====================
    -dontwarn retrofit2.**
    -keep class retrofit2.** { *; }
    -keepattributes Signature
    -keepattributes Exceptions
    -dontwarn javax.annotation.**

    #=================Retrolambda=================
    -dontwarn java.lang.invoke.*

    #=================RxJava RxAndroid====================
    -dontwarn sun.misc.**
    -keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
        long producerIndex;
        long consumerIndex;
    }
    -keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
        rx.internal.util.atomic.LinkedQueueNode producerNode;
    }
    -keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
        rx.internal.util.atomic.LinkedQueueNode consumerNode;
    }
    -dontnote rx.internal.util.PlatformDependent
    -keep class com.hwangjr.rxbus.** { *; }
    -keep class timber.log.**{ *; }
    #=================baidu====================
    -keep class com.baidu.mobads.** { *; }
    -keep class com.baidu.mobad.** { *; }
    -keep class com.bun.miitmdid.core.** {*;}
    #=================穿山甲====================
    -keep class com.bytedance.sdk.openadsdk.** { *; }
    -keep public interface com.bytedance.sdk.openadsdk.downloadnew.** {*;}
    -keep class com.pgl.sys.ces.* {*;}
    #=================gdt====================
    -keep class com.ifmvo.togetherad.gdt.** { *; }
    -keep class com.qq.e.** { *; }
    #=================第三方库====================
    -keep class  com.blankj.** { *;}
    -keep class  com.blankj.utilcode.util.** { *;}
    -keep class  com.liulishuo.filedownloader.** { *;}
    -keep class  com.kk.taurus.playerbase.** { *;}
    -keep class  com.download.library.** { *;}
    -keep class io.reactivex.Observer.**{ *; }
    #=================bean====================
    -dontwarn    com.mangolm.ad.mango.bean.**
    -keep class  com.mangolm.ad.mango.bean.** { *;}
    -dontwarn    com.ifmvo.togetherad.core.entity.**
    -keep class  com.ifmvo.togetherad.core.entity.** { *;}
    -keep class  com.mangolm.ad.mgmob.oaid.** { *;}
    -keep class com.mangolm.ad.mgmob.MGMob {
        *;
    }
    -keep class com.mangolm.ad.mango.other.MLog {
        *;
    }
    -keep class com.ifmvo.togetherad.core.SpKit {
        *;
    }
    -keep class com.mangolm.ad.mgmob.MGMobAlias {
        *;
    }
    -keep class com.mangolm.ad.mgmob.TogetherAdMango {
        *;
    }
    -keep class com.mangolm.ad.mgmob.MangoProvider {
        *;
    }
    -keep class com.ifmvo.togetherad.core.net.BaseObserveListener {
        *;
    }
    -keep class com.ifmvo.togetherad.core.net.RetrofitUtil {
        *;
    }
    -keep class com.mangolm.ad.mango.net.Api {
        *;
    }
    -keep interface com.mangolm.ad.mango.net.ApiService { *; }

    -keep class com.ifmvo.togetherad.core.net.SdkApi {
        *;
    }
    -keep interface com.ifmvo.togetherad.core.net.SdkService { *; }

```

