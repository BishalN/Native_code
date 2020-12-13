import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _batteryLevel;

  Future<void> _getBatterylLevel() async {
    const platform = MethodChannel('dev.native-code.flutter/battery');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (error) {
      setState(() {
        _batteryLevel = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatterylLevel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Native-Code'),
        ),
        body: Center(
          child: Text('Battery Level $_batteryLevel'),
        ),
      ),
    );
  }
}
