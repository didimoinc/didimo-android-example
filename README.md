# didimo-android-example
## _Example integration of DidimoSDK with Android App_

A simple demo Android app and Unity Didimo project, to demonstrate Didimo SDK integration using Unity as a library.

- Unity Didimo SDK example scene
- Unity script to build to the correct project path
- Simple Android app to facilitate Unity as a library

## Features

- Send text to a Unity object from Android app
- Send "Reset Camera" to Didimo SDK from Android app

## Requirements

This project has only been tested with the following development environments: 
- [Android Studio] - Arctic Fox 
- [Unity] - Unity 2020.3.12f1

Please ensure that you can successfully build a basic Android app using Android Studio and that the JDK is installed before importing this project.

## 1. Unity build

1. Open the folder `./didimo-digital-human-unity-project/` with Unity, and choose the Android platform.
2. In build settings check "Export project".
4. Use the Unity top menu to select "Build" → "Build Android" menu option to export to `./NativeAndroidApp/androidBuild`.

## 2. Android Studio build

1. Open the folder `./NativeAndroidApp/` with Android Studio.
2. Ensure local.properties NDK and SDK paths point to the Unity install used earlier.
   1. You can find these paths on Unity through Edit → Preferences → External Tools. Example:
      ```
      sdk.dir=C\:\\Unity\\2020.3.12f1\\Editor\\Data\\PlaybackEngines\\AndroidPlayer\\SDK
      ndk.dir=C\:\\Unity\\2020.3.12f1\\Editor\\Data\\PlaybackEngines\\AndroidPlayer\\NDK
      ```
3. Run a Gradle build.
   1. If you run into an error similar to 
   ```
   [CXX1104] NDK from ndk.dir at NDK_PATH had version [19.0.5232133] which disagrees with android.ndkVersion [23.1.7779620]
    ```
   Open the file `NativeAndroidApp\app\build.gradle`, and update the property ndkVersion, e.g. `ndkVersion '19.0.5232133'`
4. Run Make Project.
5. Deploy to device or ARM64 emulator.

