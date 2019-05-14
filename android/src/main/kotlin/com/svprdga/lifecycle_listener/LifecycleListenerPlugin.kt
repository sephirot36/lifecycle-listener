package com.svprdga.lifecycle_listener

import android.app.Activity
import android.app.Application.ActivityLifecycleCallbacks
import android.os.Bundle
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

const val NATIVE_EVENT_CREATE = "nat_event_create"
const val NATIVE_EVENT_START = "nat_event_start"
const val NATIVE_EVENT_RESUME = "nat_event_resume"
const val NATIVE_EVENT_PAUSE = "nat_event_pause"
const val NATIVE_EVENT_STOP = "nat_event_stop"
const val NATIVE_EVENT_DESTROY = "nat_event_destroy"

class LifecycleListenerPlugin : MethodCallHandler, ActivityLifecycleCallbacks {

    companion object {

        var channel: MethodChannel? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            channel = MethodChannel(registrar.messenger(), "lifecycle_listener")
            channel.setMethodCallHandler(LifecycleListenerPlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        result.notImplemented()
    }

    override fun onActivitySaveInstanceState(activity: Activity?, outState: Bundle?) {}

    override fun onActivityCreated(activity: Activity, bundle: Bundle) {
        LifecycleListenerPlugin.Companion.channel?.invokeMethod(NATIVE_EVENT_CREATE)
    }

    override fun onActivityStarted(activity: Activity) {
        LifecycleListenerPlugin.Companion.channel?.invokeMethod(NATIVE_EVENT_START)
    }

    override fun onActivityResumed(activity: Activity) {
        LifecycleListenerPlugin.Companion.channel?.invokeMethod(NATIVE_EVENT_RESUME)
    }

    override fun onActivityPaused(activity: Activity) {
        LifecycleListenerPlugin.Companion.channel?.invokeMethod(NATIVE_EVENT_PAUSE)
    }

    override fun onActivityStopped(activity: Activity) {
        LifecycleListenerPlugin.Companion.channel?.invokeMethod(NATIVE_EVENT_STOP)
    }

    override fun onActivityDestroyed(activity: Activity) {
        LifecycleListenerPlugin.Companion.channel?.invokeMethod(NATIVE_EVENT_DESTROY)
    }
}
