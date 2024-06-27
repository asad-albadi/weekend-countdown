import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
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
  // ignore: library_private_types_in_public_api
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late DateTime now;
  late DateTime nextWeekend;
  late Duration countdownDuration;
  late Timer timer;
  int fontSize = 30;

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
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('EEE, MMM d, yyyy HH:mm:ss');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              format.format(now),
              style: TextStyle(color: Colors.white, fontSize: fontSize + 50),
            ),
            const SizedBox(height: 20),
            Text(
              'Weekend starts, in:',
              style: TextStyle(color: Colors.white, fontSize: fontSize + 50),
            ),
            const SizedBox(height: 10),
            Text(
              '${countdownDuration.inDays.toString().padLeft(2, '0')}:${(countdownDuration.inHours % 24).toString().padLeft(2, '0')}:${(countdownDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(countdownDuration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize + 100,
                  fontFamily: 'Digital7Mono'),
            ),
            const SizedBox(height: 20),
            Text(
              'Weekend Starts on, ${format.format(nextWeekend)}',
              style: TextStyle(color: Colors.white, fontSize: fontSize + 50),
            ),
          ],
        ),
      ),
    );
  }
}
