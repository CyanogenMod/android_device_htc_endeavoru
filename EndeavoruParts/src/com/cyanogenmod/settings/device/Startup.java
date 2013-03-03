package com.cyanogenmod.settings.device;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class Startup extends BroadcastReceiver {

    @Override
    public void onReceive(final Context context, final Intent bootintent) {
        Sweep2WakeSwitch.restore(context);
        Sweep2WakeStroke.restore(context);
        Sweep2WakeMinLength.restore(context);
        Fastcharge.restore(context);
        BacklightDisable.restore(context);
        BacklightNotificationSwitch.restore(context);
        SmartDimmerSwitch.restore(context);
    }
}
