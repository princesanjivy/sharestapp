package com.princeappstudio.sharestapp;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.FileProvider;

import com.google.android.gms.ads.MobileAds;
import com.google.android.gms.ads.initialization.InitializationStatus;
import com.google.android.gms.ads.initialization.OnInitializationCompleteListener;

import java.io.File;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

//import com.google.android.gms.ads.InterstitialAd;

public class MainActivity extends FlutterActivity {
    public static final String CHANNEL = "com.princeappstudio.saveimage";
    public static final String CHANNEL1 = "com.princeappstudio.ad";
//    private InterstitialAd interstitialAd;

    @Override
    protected void attachBaseContext(Context newBase) {
        super.attachBaseContext(newBase);
    }

    @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
              GeneratedPluginRegistrant.registerWith(flutterEngine);
                new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                               .setMethodCallHandler(
                                 (call, result) -> {
                                     String path;
                                     String text;

                                     if (call.method.equals("saveimage")) {
                                         path = call.argument("file").toString();
                                         result.success(saveImage(path));
                                     } else if (call.method.equals("shareimage")) {
                                         path = call.argument("path").toString();
                                         result.success(shareImage(path));
                                     } else if (call.method.equals("sharetext")) {
                                         text = call.argument("text").toString();
                                         result.success(shareText(text));
                                     } else {
                                         result.notImplemented();
                                     }
                                           }
                              );
           }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

//        MobileAds.initialize(this, new OnInitializationCompleteListener() {
//            @Override
//            public void onInitializationComplete(InitializationStatus initializationStatus) {
////                Toast.makeText(MainActivity.this, "Initialized", Toast.LENGTH_SHORT).show();
//            }
//        });

//        interstitialAd = new InterstitialAd(this);
//        interstitialAd.setAdUnitId("ca-app-pub-5164932036098856/4141348422");
//        interstitialAd.loadAd(new AdRequest.Builder().build());

//        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
//            @Override
//            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
//                String path;
//                String text;
//
//                if (call.method.equals("saveimage")) {
//                    path = call.argument("file").toString();
//                    result.success(saveImage(path));
//                } else if (call.method.equals("shareimage")) {
//                    path = call.argument("path").toString();
//                    result.success(shareImage(path));
//                } else if (call.method.equals("sharetext")) {
//                    text = call.argument("text").toString();
//                    result.success(shareText(text));
//                } else {
//                    result.notImplemented();
//                }
//            }
//        });
//
//        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL1).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
//            @Override
//            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
//                String path;
//
//                if (call.method.equals("showad")) {
//                    showAd();
////                    result.success("Ad is showing");
//                } else {
//                    result.notImplemented();
//                }
//            }
//        });

//        interstitialAd.setAdListener(new AdListener() {
//            @Override
//            public void onAdClosed() {
//                super.onAdClosed();
//
//                interstitialAd.loadAd(new AdRequest.Builder().build());
//            }
//        });
    }

    String shareText(String text) {
        Intent share = new Intent();
        share.setAction(Intent.ACTION_SEND);
        share.putExtra(Intent.EXTRA_TEXT, text);
        share.setType("text/plain");
        startActivity(Intent.createChooser(share, "Check out Sharestapp"));

        return "shared text";
    }

    String saveImage(String path) {
        File file = new File(path);
        Uri uri = Uri.fromFile(file);

        Intent mediascanner = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri);
        sendBroadcast(mediascanner);
        if (path.endsWith(".mp4"))
            Toast.makeText(MainActivity.this, "Video saved!", Toast.LENGTH_SHORT).show();
        else
            Toast.makeText(MainActivity.this, "Image saved!", Toast.LENGTH_SHORT).show();
        return uri.toString();
    }

    String shareImage(String path) {
        File file = new File(getCacheDir(), path);
        Uri fileUri = FileProvider.getUriForFile(MainActivity.this, "com.princeappstudio.sharestapp.provider", file);
        // File file = new File(path)
        // Uri fileUri = Uri.fromFile(file);

        Intent share = new Intent();
        share.setAction(Intent.ACTION_SEND);
        share.putExtra(Intent.EXTRA_STREAM, fileUri);
        share.putExtra(Intent.EXTRA_TEXT, "\"Shared using Sharestapp\"");
        share.setType("image/*");
        share.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        // share.setPackage("com.whatsapp");

        startActivity(Intent.createChooser(share, "Share contents to.."));
        if (path.endsWith(".mp4"))
            Toast.makeText(MainActivity.this, "Sharing your video!", Toast.LENGTH_SHORT).show();
        else
            Toast.makeText(MainActivity.this, "Sharing your image!", Toast.LENGTH_SHORT).show();
        return fileUri.toString();
    }

//    void showAd() {
//        if (interstitialAd.isLoaded()) {
////            Toast.makeText(this, "Ad is now showing up", Toast.LENGTH_SHORT).show();
//            interstitialAd.show();
//        } else {
//            Toast.makeText(this, "Ad not loaded yet", Toast.LENGTH_SHORT).show();
//        }
//    }
}
