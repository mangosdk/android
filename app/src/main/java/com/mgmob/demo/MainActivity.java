package com.mgmob.demo;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.ScrollView;
import android.widget.TextView;

import com.ifmvo.togetherad.core.helper.AdHelperReward;
import com.ifmvo.togetherad.core.listener.RewardListener;
import com.mangolm.ad.mango.util.PermissionsUtils;
import com.mangolm.ad.mgmob.MGMob;
import com.mangolm.ad.mgmob.MGMobAlias;


public class MainActivity extends AppCompatActivity {

    private Button btnLoad, btnShow;
    private TextView tvInfo;
    private ScrollView scrollView;

    private AdHelperReward adHelperReward;
    private boolean openPermissions;
    private PermissionsUtils permissionsUtils;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        if ((getIntent().getFlags() & Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT) > 0) {
            /**为了防止重复启动多个闪屏页面**/
            finish();
            return;
        }

//        String s = null;
//        if ((s != null) & (s.length() > 0)) {
//        }
//        if ((s != null) && (s.length() > 0)) {
//        }
//        if ((s == null) | (s.length() == 0)) {
//        }
//        if ((s == null) || (s.length() == 0)) {
//        }

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btnLoad = findViewById(R.id.btnLoad);
        btnShow = findViewById(R.id.btnShow);
        tvInfo = findViewById(R.id.info);
        scrollView = findViewById(R.id.scrollView);

        //开发者请自行根据情况决定：动态申请权限，有助于提高广告的填充率
        permissionsUtils = new PermissionsUtils(this);
        checkPermissions();

        btnLoad.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!openPermissions) {
                    checkPermissions();
                } else {
                    //请求激励广告
                    adHelperReward.load();
                }
            }
        });

        btnShow.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!openPermissions) {
                    checkPermissions();
                } else {
                    //展示激励广告
                    adHelperReward.show();
                }
            }
        });

    }

    private void checkPermissions() {
        openPermissions = permissionsUtils.setPermissions(PermissionsUtils.permissionsREAD);
        if (openPermissions) {
            initSDK();
        }
    }

    private void initSDK() {
        //初始化激励广告
        adHelperReward = new AdHelperReward(MainActivity.this, MGMobAlias.Reward, null, new RewardListener() {
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
                addLog("请求失败: " + providerType + "，" + failedMsg);
            }

            @Override
            public void onAdFailedAll() {
                addLog("全部失败");
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
    }

    private String logStr = "";

    private void addLog(String content) {
        logStr = logStr + content + "\n";
        tvInfo.setText(logStr);

        scrollView.post(new Runnable() {
            @Override
            public void run() {
                scrollView.fullScroll(View.FOCUS_DOWN);
            }
        });
    }

    public void btnIntegerClick(View view) {
        //打开积分页面
        MGMob.openIntegralWall(MainActivity.this, "6f229300-a65a-11eb-b75d-525400b34da4", "6f229307-a65a-11eb-b75d-525400b34da4");
//        MGMob.openIntegralWall(MainActivity.this, "啵啵", "123456");
    }
}
