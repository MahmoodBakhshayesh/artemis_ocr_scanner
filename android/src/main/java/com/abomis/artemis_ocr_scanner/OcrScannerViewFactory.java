package com.abomis.artemis_ocr_scanner;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class OcrScannerViewFactory extends PlatformViewFactory {
    final private ActivityPluginBinding activityPluginBinding;
    final private BinaryMessenger dartExecutor;


    public OcrScannerViewFactory(ActivityPluginBinding activityPluginBinding, BinaryMessenger dartExecutor) {
        super(StandardMessageCodec.INSTANCE);
        this.activityPluginBinding = activityPluginBinding;
        this.dartExecutor = dartExecutor;
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int id, @Nullable Object args) {
        return new OcrScannerView(activityPluginBinding,dartExecutor,id);
    }
}
