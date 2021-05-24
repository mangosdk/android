# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

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
-keep class  com.mangolm.ad.mgmob.util.** { *;}
-keep class com.mangolm.ad.mgmob.MGMob {
    *;
}
-keep class com.mangolm.ad.mango.other.MLog {
    *;
}
-keep class com.mangolm.ad.mango.util.PermissionsUtils {
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


