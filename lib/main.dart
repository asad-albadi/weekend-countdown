import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:js' as js;

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

String title = "Weekend Countdown";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Digital7Mono'),
          bodyMedium: TextStyle(fontFamily: 'Digital7Mono'),
        ),
      ),
      home: const CountdownPage(),
    );
  }
}

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late DateTime now;
  late DateTime nextWeekend;
  late Duration countdownDuration;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    nextWeekend = _getNextWeekend(now);
    countdownDuration = nextWeekend.difference(now);
    timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  DateTime _getNextWeekend(DateTime currentTime) {
    final nextThursday =
        currentTime.add(Duration(days: (4 - currentTime.weekday + 7) % 7));
    final nextWeekend = DateTime(
        nextThursday.year, nextThursday.month, nextThursday.day, 15, 0, 0);
    if (nextWeekend.isBefore(currentTime)) {
      return nextWeekend.add(const Duration(days: 7));
    }
    return nextWeekend;
  }

  void _updateTime(Timer timer) {
    setState(() {
      now = DateTime.now();
      nextWeekend = _getNextWeekend(now);
      countdownDuration = nextWeekend.difference(now);
      _updateBrowserTabTitle();
    });
  }

  void _updateBrowserTabTitle() {
    final title = ''
        '${countdownDuration.inDays.toString().padLeft(2, '0')}d '
        '${(countdownDuration.inHours % 24).toString().padLeft(2, '0')}h '
        '${(countdownDuration.inMinutes % 60).toString().padLeft(2, '0')}m '
        '${(countdownDuration.inSeconds % 60).toString().padLeft(2, '0')}s';
    if (kIsWeb) {
      setBrowserTabTitle(title);
    }
  }

  void setBrowserTabTitle(String title) {
    // ignore: undefined_prefixed_name
    js.context.callMethod('eval', ['document.title = "$title";']);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  double _getFontSize(double screenWidth) {
    if (screenWidth < 320) {
      return 6; // Extra small devices (e.g., older phones)
    } else if (screenWidth < 480) {
      return 8; // Small devices (e.g., phones)
    } else if (screenWidth < 600) {
      return 16; // Medium-small devices (e.g., large phones)
    } else if (screenWidth < 720) {
      return 18; // Medium devices (e.g., small tablets)
    } else if (screenWidth < 840) {
      return 20; // Medium-large devices (e.g., tablets)
    } else if (screenWidth < 960) {
      return 22; // Large devices (e.g., large tablets)
    } else if (screenWidth < 1080) {
      return 24; // Extra large devices (e.g., small laptops)
    } else if (screenWidth < 1200) {
      return 26; // Extra-extra large devices (e.g., laptops)
    } else if (screenWidth < 1440) {
      return 28; // 2K devices
    } else {
      return 60; // Ultra large devices (e.g., 4K screens and beyond)
    }
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('EEE, MMM d, yyyy HH:mm:ss');
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = _getFontSize(screenWidth);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              format.format(now),
              style: TextStyle(color: Colors.white, fontSize: fontSize + 10),
            ),
            const SizedBox(height: 20),
            Text(
              'Weekend starts, in:',
              style: TextStyle(color: Colors.white, fontSize: fontSize + 10),
            ),
            const SizedBox(height: 10),
            Text(
              '${countdownDuration.inDays.toString().padLeft(2, '0')}:${(countdownDuration.inHours % 24).toString().padLeft(2, '0')}:${(countdownDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(countdownDuration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize + 20,
                  fontFamily: 'Digital7Mono'),
            ),
            const SizedBox(height: 20),
            Text(
              'Weekend Starts on, ${format.format(nextWeekend)}',
              style: TextStyle(color: Colors.white, fontSize: fontSize + 10),
            ),
          ],
        ),
      ),
    );
  }
}
