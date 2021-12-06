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

## Unity build
- Open the folder didimo-digital-human-unity-project/ with Unity, platform Android.
- In build settings check "Export project" 
- In player settings, disable ARM7 and select minimum API 28
- Use the Build/Build Android menu option to export to the correct project folder

## Android Studio build

- Open the folder NativeAndroidApp/ with Android Studio
- Ensure local.properties NDK and SDK paths point to the Unity install used earlier
- Run a Gradle build
- Run Make Project
- Deploy to device or ARM64 emulator




[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

 
   [Unity]: <https://unity3d.com/get-unity/download/archive>
   [Android Studio]: <https://developer.android.com/studio>
  
