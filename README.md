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

1. Open the folder ./didimo-digital-human-unity-project/ with Unity, and choose the Android platform.
2. Open the Test scene, and click to install the TextMeshPro Required files
3. In build settings check "Export project".
4. In player settings, disable ARM7 and select minimum API 28.
5. Use the Unity top menu to select "Build" -> "Build Android" menu option to export to the correct project folder.

## 2. Android Studio build

1. Open the folder ./NativeAndroidApp/ with Android Studio.
2. Ensure local.properties NDK and SDK paths point to the Unity install used earlier.
3. Run a Gradle build.
4. Run Make Project.
5. Deploy to device or ARM64 emulator.

