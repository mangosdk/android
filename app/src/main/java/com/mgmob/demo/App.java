package com.mgmob.demo;

import android.app.Application;
import android.content.Context;
import android.support.multidex.MultiDex;

import com.mangolm.ad.mgmob.MGMob;

/**
 *
 */
public class App extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
//        MGMob mgMob = MGMob.getInstance(this, "ERRRaIIYGq", "efgQRSTZhijKopqr2345");
        MGMob mgMob = MGMob.getInstance(this, "nESSGYkpEp", "efgQRSTZhijKopqr2345");
        //初始化积分墙
        mgMob.initIntegralWallInfo(10158);//10158,10006
        //初始化激励视频
        mgMob.initVideoInfo(10018, "Demo", BuildConfig.DEBUG);
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
