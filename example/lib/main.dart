import 'package:flutter/material.dart';
import 'package:lifecycle_listener/lifecycle_listener.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with LifecycleListenerSuscriber{
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    LifecycleListener.register(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    LifecycleListener.unregister(this);
  }

  @override
  void viewCreated() {
    print("View created.");
  }

  @override
  void viewStarted() {
    print("View started.");
  }

  @override
  void viewResumed() {
    print("View resumed.");
  }

  @override
  void viewPaused() {
    print("View paused.");
  }

  @override
  void viewStopped() {
    print("View stopped.");
  }

  @override
  void viewDestroyed() {
    print("View destroyed.");
  }
}
