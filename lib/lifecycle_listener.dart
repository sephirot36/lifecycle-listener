import 'package:flutter/services.dart';

abstract class LifecycleListenerSuscriber {

  /// Called when the view is created for the first time.
  ///
  /// Equivalent to onCreate() in Android.
  /// Equivalent to viewDidLoad() in iOS.
  ///
  /// Take into account that Flutter renders all of its widgets in a single
  /// native view, hence; it is normal that this method is called only once
  /// per the entire session.
  void viewCreated() {}

  /// Called after the view is created; and when returning from the background.
  ///
  /// Equivalent to onStart() in Android.
  /// Equivalent to viewWillAppear() in iOS.
  void viewStarted() {}

  /// Called when the view is directly interacting with the user.
  ///
  /// Equivalent to onResume() in Android.
  /// Equivalent to viewDidAppear() in iOS.
  void viewResumed() {}

  /// Called when the view is not longer interacting with the user, but
  /// it might be in a foreground state.
  ///
  /// Equivalent to onPause() in Android.
  /// Equivalent to viewWillDissappear() in iOS.
  void viewPaused() {}

  /// Called when the view is not longer visibile (going into background).
  /// Also called before the view is destroyed.
  ///
  /// Equivalent to onStop() in Android.
  /// Equivalent to viewDidDissappear() in iOS.
  void viewStopped() {}

  /// Called when the view is being destroyed and its resources are released.
  ///
  /// Equivalent to onDestroy() in Android.
  /// Equivalent to deinit() in iOS.
  void viewDestroyed() {}

}

class LifecycleListener {

  static const NATIVE_EVENT_CREATE = "nat_event_create";
  static const NATIVE_EVENT_START = "nat_event_start";
  static const NATIVE_EVENT_RESUME = "nat_event_resume";
  static const NATIVE_EVENT_PAUSE = "nat_event_pause";
  static const NATIVE_EVENT_STOP = "nat_event_stop";
  static const NATIVE_EVENT_DESTROY = "nat_event_destroy";

  static const MethodChannel _channel =
  const MethodChannel('lifecycle_listener');
  static List<LifecycleListenerSuscriber> _subscribers = List();

  /// Register the given [subscriber] to start receiving lifecycle events.
  static register(LifecycleListenerSuscriber subscriber) {
    _subscribers.add(subscriber);
  }

  /// Unregister the given [subscriber] to stop receiving lifecycle events.
  static unregister(LifecycleListenerSuscriber subscriber) {
    _subscribers.remove(subscriber);
  }

  LifecycleListener() {
    _channel.setMethodCallHandler((MethodCall call) async {
      switch(call.method) {
        case NATIVE_EVENT_CREATE:
          _notifyCreate();
          break;
        case NATIVE_EVENT_START:
          _notifyStart();
          break;
        case NATIVE_EVENT_RESUME:
          _notifyResume();
          break;
        case NATIVE_EVENT_PAUSE:
          _notifyPause();
          break;
        case NATIVE_EVENT_STOP:
          _notifyStop();
          break;
        case NATIVE_EVENT_DESTROY:
          _notifyDestroy();
          break;
      }
    });
  }

  _notifyCreate() {
    for (LifecycleListenerSuscriber subscriber in _subscribers) {
      subscriber.viewCreated();
    }
  }

  _notifyStart() {
    for (LifecycleListenerSuscriber subscriber in _subscribers) {
      subscriber.viewStarted();
    }
  }

  _notifyResume() {
    for (LifecycleListenerSuscriber subscriber in _subscribers) {
      subscriber.viewResumed();
    }
  }

  _notifyPause() {
    for (LifecycleListenerSuscriber subscriber in _subscribers) {
      subscriber.viewPaused();
    }
  }

  _notifyStop() {
    for (LifecycleListenerSuscriber subscriber in _subscribers) {
      subscriber.viewStopped();
    }
  }

  _notifyDestroy() {
    for (LifecycleListenerSuscriber subscriber in _subscribers) {
      subscriber.viewDestroyed();
    }
  }
}
