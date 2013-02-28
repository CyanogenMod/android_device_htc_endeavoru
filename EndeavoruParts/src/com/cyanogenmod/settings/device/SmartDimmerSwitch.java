package com.cyanogenmod.settings.device;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.Preference;
import android.preference.Preference.OnPreferenceChangeListener;
import android.preference.PreferenceManager;
import java.io.File;

public class SmartDimmerSwitch implements OnPreferenceChangeListener {

    private static final String FILE = "/sys/devices/tegradc.0/smartdimmer/enable";

    public static boolean isSupported() {
        return Utils.fileExists(FILE);
    }

    /**
     * Restore smartdimmer switch setting from SharedPreferences. (Write to kernel.)
     * @param context       The context to read the SharedPreferences from
     */
    public static void restore(Context context) {
        if (!isSupported()) {
            return;
        }

        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
        boolean enabled = sharedPrefs.getBoolean(DeviceSettings.KEY_SMARTDIMMERSWITCH, true);
        File blFile = new File(FILE);
        if(enabled) {
            Utils.writeValue(FILE, "1");
        }
        else {
            Utils.writeValue(FILE, "0");
        }
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {
        Boolean enabled = (Boolean) newValue;
        File blFile = new File(FILE);
        if(enabled) {
            Utils.writeValue(FILE, "1");
        }
        else {
            Utils.writeValue(FILE, "0");
        }
        return true;
    }

}
