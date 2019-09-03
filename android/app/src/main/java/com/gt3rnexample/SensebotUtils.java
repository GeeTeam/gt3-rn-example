package com.gt3rnexample;


import android.util.Log;
import java.util.concurrent.Executors;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import android.content.res.Configuration;
import com.facebook.react.bridge.Promise;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;

import com.geetest.sdk.GT3ConfigBean;
import com.geetest.sdk.GT3ErrorBean;
import com.geetest.sdk.GT3GeetestUtils;
import com.geetest.sdk.GT3Listener;

import org.json.JSONObject;

import java.util.HashMap;

import android.os.Handler;
import android.os.Looper;

public class SensebotUtils extends ReactContextBaseJavaModule {

private static final String TAG="sensebot";
private  String api1;
private  String api2;

    public SensebotUtils(ReactApplicationContext reactContext) {
        super(reactContext);
    }

  private Handler mainHandler= new Handler(Looper.getMainLooper());

    @Override
    public String getName() {
        return "GT3CaptchaManagerModule";
    }

    private GT3GeetestUtils gt3GeetestUtils;
    private GT3ConfigBean gt3ConfigBean = new GT3ConfigBean();

    /**
     * 初始化
     */
    @ReactMethod
    public void initWithAPI( String url1, String url2) {
        gt3GeetestUtils = new GT3GeetestUtils(getCurrentActivity());
        api1 = url1;
        api2 = url2;
    }

     /**
     * 点击执行
     */
        @ReactMethod
        public void startGTCaptcha(Promise promise){
          mainHandler.post(new Runnable() {
                 @Override
                 public void run() {
                 verity(promise);
                 }
             });
        }


        @ReactMethod
        public void disableBackgroundUserInteraction(boolean isCan) {
          gt3ConfigBean.setCanceledOnTouchOutside(isCan);
        }

        @ReactMethod
        public void enableDebug(boolean isDebug) {
          gt3ConfigBean.setDebug(isDebug);
        }

        @ReactMethod
        public void gtViewWithTimeout(int time) {
          gt3ConfigBean.setTimeout(time);
        }

        @ReactMethod
        public void userCloseCaptchaView() {
          gt3GeetestUtils.dismissGeetestDialog();
        }


    public void verity(Promise promise) {
        // 配置bean文件，也可在oncreate初始化
        // gt3ConfigBean = new GT3ConfigBean();
        // 设置验证模式，1：bind，2：unbind
        gt3ConfigBean.setPattern(1);
        // 设置语言，如果为null则使用系统默认语言
        gt3ConfigBean.setLang(null);
        // 设置webview请求超时(用户点选或滑动完成，前端请求后端接口)，单位毫秒，默认10000
        gt3ConfigBean.setWebviewTimeout(10000);
        // 设置加载webview超时时间，单位毫秒，默认10000，仅且webview加载静态文件超时，不包括之前的http请求
        // gt3ConfigBean.setTimeout(10000);
        // 设置点击灰色区域是否消失，默认不消失
        // gt3ConfigBean.setCanceledOnTouchOutside(false);
        // 设置debug模式，TODO 线上版本关闭
        // gt3ConfigBean.setDebug(false);    
        // 设置自定义view
        //gt3ConfigBean.setLoadImageView(new TestLoadingView(this));
        // 设置回调监听
        gt3ConfigBean.setListener(new GT3Listener() {

            /**
             * api1结果回调
             * @param result
             */
            @Override
            public void onApi1Result(String result) {
                Log.e(TAG, "GT3BaseListener-->onApi1Result-->" + result);
            }

            /**
             * 验证码加载完成
             * @param duration 加载时间和版本等信息，为json格式
             */
            @Override
            public void onDialogReady(String duration) {
                Log.e(TAG, "GT3BaseListener-->onDialogReady-->" + duration);
            }

            /**
             * 验证结果
             * @param result
             */
            @Override
            public void onDialogResult(String result) {
                Log.e(TAG, "GT3BaseListener-->onDialogResult-->" + result);
                // 开启api2逻辑
                new RequestAPI2().executeOnExecutor(Executors.newCachedThreadPool(),result);
            }

            /**
             * api2回调
             * @param result
             */
            @Override
            public void onApi2Result(String result) {
                Log.e(TAG, "GT3BaseListener-->onApi2Result-->" + result);
            }

            /**
             * 统计信息，参考接入文档
             * @param result
             */
            @Override
            public void onStatistics(String result) {
                Log.e(TAG, "GT3BaseListener-->onStatistics-->" + result);
            }

            /**
             * 验证码被关闭
             * @param num 1 点击验证码的关闭按钮来关闭验证码, 2 点击屏幕关闭验证码, 3 点击返回键关闭验证码
             */
            @Override
            public void onClosed(int num) {
                Log.e(TAG, "GT3BaseListener-->onClosed-->" + num);
            }

            /**
             * 验证成功回调
             * @param result
             */
            @Override
            public void onSuccess(String result) {
                Log.e(TAG, "GT3BaseListener-->onSuccess-->" + result);
                promise.resolve(result);
            }

            /**
             * 验证失败回调
             * @param errorBean 版本号，错误码，错误描述等信息
             */
            @Override
            public void onFailed(GT3ErrorBean errorBean) {
                Log.e(TAG, "GT3BaseListener-->onFailed-->" + errorBean.toString());
                  promise.reject(errorBean.toString());
            }

            /**
             * api1回调
             */
            @Override
            public void onButtonClick() {
                new RequestAPI1().executeOnExecutor(Executors.newCachedThreadPool());
            }
        });
        gt3GeetestUtils.init(gt3ConfigBean);
        // 开启验证
        gt3GeetestUtils.startCustomFlow();
    }

    /**
     * 请求api1
     */
    class RequestAPI1 extends AsyncTask<Void, Void, JSONObject> {

        @Override
        protected JSONObject doInBackground(Void... params) {
            String string = HttpUtils.requestGet(api1);
            Log.e(TAG, "doInBackground: " + string);
            JSONObject jsonObject = null;
            try {
                jsonObject = new JSONObject(string);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return jsonObject;
        }

        @Override
        protected void onPostExecute(JSONObject parmas) {
            // 继续验证
            Log.i(TAG, "RequestAPI1-->onPostExecute: " + parmas);
            // SDK可识别格式为
            // {"success":1,"challenge":"06fbb267def3c3c9530d62aa2d56d018","gt":"019924a82c70bb123aae90d483087f94"}
            // TODO 设置返回api1数据，即使为null也要设置，SDK内部已处理
            gt3ConfigBean.setApi1Json(parmas);
            // 继续api验证
            gt3GeetestUtils.getGeetest();
        }
    }

    /**
     * 请求api2
     */
    class RequestAPI2 extends AsyncTask<String, Void, String> {

        @Override
        protected String doInBackground(String... params) {
            if (!TextUtils.isEmpty(params[0])) {
                return HttpUtils.requestPost(api2, params[0]);
            } else {
                return null;
            }
        }

        @Override
        protected void onPostExecute(String result) {
            Log.i(TAG, "RequestAPI2-->onPostExecute: " + result);
            if (!TextUtils.isEmpty(result)) {
                try {
                    JSONObject jsonObject = new JSONObject(result);
                    String status = jsonObject.getString("status");
                    if ("success".equals(status)) {
                        gt3GeetestUtils.showSuccessDialog();
                    } else {
                        gt3GeetestUtils.showFailedDialog();
                    }
                } catch (Exception e) {
                    gt3GeetestUtils.showFailedDialog();
                    e.printStackTrace();
                }
            } else {
                gt3GeetestUtils.showFailedDialog();
            }
        }
    }

    /**
     * 关闭执行
     */
    @ReactMethod
    public void closeSensebot() {
        gt3GeetestUtils.destory();
    }

    @Override
    public boolean canOverrideExistingModule() {
        return true;
    }

    /**
     * 横竖屏切换执行
     */
    @ReactMethod
    public void onConfigurationChanged() {
        gt3GeetestUtils.changeDialogLayout();
    }



}
