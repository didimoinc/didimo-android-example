package com.unity3d.player;

import android.os.Bundle;
import com.unity3d.communication.DidimoUnityInterface;


public abstract class CommunicationActivity extends UnityPlayerActivity {

    DidimoUnityInterface didimoUnityInterface = null;
    abstract protected void showMainActivity(String setToColor);
    static CommunicationActivity _lastInstance;

    public static CommunicationActivity LastInstance() {

        return _lastInstance;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        _lastInstance = this;
    }

    protected DidimoUnityInterface getDidimoUnityInterface() {

        if (didimoUnityInterface == null) {
            didimoUnityInterface = new DidimoUnityInterface();
        }
        return didimoUnityInterface;
    }
}

