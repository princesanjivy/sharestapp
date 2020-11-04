package com.princeappstudio.sharestapp;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.io.File;
import androidx.core.content.FileProvider;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import android.widget.Toast;

public class MainActivity extends FlutterActivity {
    public static final String CHANNEL = "com.princeappstudio.saveimage";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                String path;

                if (call.method.equals("saveimage")) {
                    path = call.argument("file").toString();
                    result.success(saveImage(path));
                }
                else if (call.method.equals("shareimage")) {
                    path = call.argument("path").toString();
                    result.success(shareImage(path));
                }
                else{
                    result.notImplemented();
                }
            }
        });
    }

    String saveImage(String path) {
        File file = new File(path);
        Uri uri = Uri.fromFile(file);

        Intent mediascanner = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri);
        sendBroadcast(mediascanner);
        Toast.makeText(MainActivity.this, "Image saved!", Toast.LENGTH_SHORT).show();
        return uri.toString();
    }

    String shareImage(String path) {
        File file = new File(getCacheDir(), path);
        Uri fileUri = FileProvider.getUriForFile(MainActivity.this, "com.princeappstudio.sharestapp.provider", file);
        // File file = new File(path);
        // Uri fileUri = Uri.fromFile(file);

        Intent share = new Intent();
        share.setAction(Intent.ACTION_SEND);
        share.putExtra(Intent.EXTRA_STREAM, fileUri);
        share.setType("image/*");
        share.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        share.setPackage("com.whatsapp");

        startActivity(share);
        Toast.makeText(MainActivity.this, "Sharing your image!", Toast.LENGTH_SHORT).show();
        return fileUri.toString();
    }
}
