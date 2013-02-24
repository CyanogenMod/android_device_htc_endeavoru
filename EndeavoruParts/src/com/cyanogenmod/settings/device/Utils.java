package com.cyanogenmod.settings.device;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class Utils {

    /**
     * Write a string value to the specified file.
     * @param filename      The filename
     * @param value         The value
     */
    public static void writeValue(String filename, String value) {
        try {
            FileOutputStream fos = new FileOutputStream(new File(filename));
            fos.write(value.getBytes());
            fos.flush();
            fos.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Write the "color value" to the specified file. The value is scaled from
     * an integer to an unsigned integer by multiplying by 2.
     * @param filename      The filename
     * @param value         The value of max value Integer.MAX
     */
    public static void writeColor(String filename, int value) {
        writeValue(filename, String.valueOf((long) value * 2));
    }

    /**
     * Write the "gamma value" to the specified file.
     * @param filename      The filename
     * @param value         The value
     */
    public static void writeGamma(String filename, int value) {
        writeValue(filename, String.valueOf(value));
    }

    /**
     * Check if the specified file exists.
     * @param filename      The filename
     * @return              Whether the file exists or not
     */
    public static boolean fileExists(String filename) {
        return new File(filename).exists();
    }

}
