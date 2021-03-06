#if UNITY_IOS || UNITY_ANDROID
using System;
using System.Runtime.InteropServices;
using AOT;
using UnityEngine;

namespace Didimo.Mobile.Scripts
{
    public class SetEyeColor : BiDirectionalNativeInterface
    {
#if UNITY_ANDROID
        private class MessageInterface : AndroidJavaProxy
        {
            public MessageInterface() : base("com.unity3d.communication.DidimoUnityInterface$SetEyeColorInterface") { }

            public void sendToUnity(string didimoKey, int colorIdx, AndroidJavaObject response)
            {
                CbMessage(IntPtr.Zero,
                    didimoKey,
                    colorIdx,
                    obj =>
                    {
                        CallOnSuccess(response);
                    },
                    (obj, message) =>
                    {
                        CallOnError(response, message);
                    });
            }
        }

        protected override void RegisterNativeCall(AndroidJavaObject didimoUnityInterface) { didimoUnityInterface.Call("RegisterForCommunication", new MessageInterface()); }

#elif UNITY_IOS
        protected override void RegisterNativeCall() { registerSetEyeColor(CbMessage); }

        public delegate void InputDelegate(IntPtr obj, string didimoKey, int colorIdx, SuccessDelegate successDelegate, ErrorDelegate errorDelegate);

        [DllImport("__Internal", CallingConvention = CallingConvention.Cdecl)]
        private static extern void registerSetEyeColor(InputDelegate cb);

        [MonoPInvokeCallback(typeof(InputDelegate))]
#endif
        private static void CbMessage(IntPtr obj, string didimoKey, int eyeColorIdx, SuccessDelegate successDelegate, ErrorDelegate errorDelegate)
        {
            ThreadingUtility.WhenMainThread(() =>
            {
                try
                {
                    if (DidimoCache.TryFindDidimo(didimoKey, out DidimoComponents didimo))
                    {
                        //didimo.IrisController.SetPreset(eyeColorIdx);
                    }
                    else
                    {
                        throw new Exception($"Unable to find didimo with id {didimoKey}");
                    }

                    successDelegate(obj);
                }
                catch (Exception e)
                {
                    errorDelegate(obj, e.Message + e.StackTrace);
                }
            });
        }
    }
}
#endif