import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StopWatch(),
    );
  }
}

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _stopwatchState();
}

class _stopwatchState extends State<StopWatch> {

  Timer _timer = Timer(Duration.zero, () {});
  final Stopwatch _stopwatch = Stopwatch();
  String _time = "00:00:000";

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
        setState(() {
          final Duration elapsed = _stopwatch.elapsed;
          final String minute = elapsed.inMinutes.toString();
          final String sec = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
          final String milliSec = (elapsed.inMilliseconds % 1000).toString().padLeft(3, '0');
          _time = '$minute:$sec:$milliSec';
        });
      });
    }
  }

  void _stopTimer(){
    if (_stopwatch.isRunning){
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  void _resetTimer(){
    _stopwatch.reset();
    _time = "00:00:000";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ストップウォッチ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('経過時間'),
            Text('$_time',style:Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _startTimer, child: const Text('スタート')),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _stopTimer, child: const Text('ストップ')),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _resetTimer, child: const Text('リセット')),
              ],
            )
          ],
        ),

      ),
    );
  }
}