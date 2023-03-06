import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // 카운트다운을 시작할 초
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer; // late는 나중에 초기화할것이라는 의미

  // 1500초가 다 지나면 Pomodoros를 한개씩 올려줌
  void onTick(Timer timer){
    if(totalSeconds == 0){
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    }else { // 그게 아니라면 남은 시간을 1만큼 감소시킴
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  // 카운트다운을 시작할 함수. Timer라는 다트의 라이브러리를 사용
  void onStratPressed(){
    timer = Timer.periodic(
      Duration(seconds: 1), // 1초마다 여기있는 함수가 실행될것임
      onTick, // onTick() 처럼 괄호를 넣지 말아야함. 괄호를 넣으면 바로 함수를 실행하겠다는 뜻
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  // 1500초를 깔끔하게 분초로 보이도록
  String format(int seconds){
    var duration = Duration(seconds: seconds);
    //print(duration.toString().split('.').first.substring(2, 7));
    // . 으로 잘라서 [0:24:55, 000000]의 리스트를 얻고 거기에서 또 자름
    //return '$seconds';
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          // Flexible의 역할은 하드코딩되는 값을 만들게 해줌
          // 예를들어 높이 몇, 가로 몇 이게 아니라 비율에 기반해서 더 유연하게 만들어줌
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning ? onPausePressed : onStratPressed,
                icon: Icon(isRunning ? Icons.pause_circle_outline : Icons.play_circle_outline),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pomodoros',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).textTheme.headline1!.color,
                              ),
                            ),
                            Text(
                              '$totalPomodoros',
                              style: TextStyle(
                                fontSize: 58,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).textTheme.headline1!.color,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}

