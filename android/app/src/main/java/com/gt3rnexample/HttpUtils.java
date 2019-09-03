package com.gt3rnexample;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Created by chensongsong on 2018/7/12.
 */

public class HttpUtils {

    private static OkHttpClient okHttpClient = new OkHttpClient();

    public static String requestPost(String urlString, String postParam){
        okHttpClient.followRedirects();
        okHttpClient.followSslRedirects();
        MediaType mediaType = MediaType.parse("application/json");
        RequestBody requestBody = RequestBody.create(mediaType,postParam);
        Request request = new Request
                .Builder()
                .post(requestBody)
                .url(urlString)
                .build();
        try {
            Response response = okHttpClient.newCall(request).execute();
            return response.body().string();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String requestGet(String urlString){
        okHttpClient.followRedirects();
        okHttpClient.followSslRedirects();
        Request request = new Request.Builder().url(urlString).build();
        try {
            Response response = okHttpClient.newCall(request).execute();
            return response.body().string();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
