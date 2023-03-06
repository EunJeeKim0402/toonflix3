import 'package:flutter/material.dart';
import 'package:toonflix3/screens/home_screen.dart';
import 'package:toonflix3/services/api_service.dart';
import 'package:toonflix3/widgets/button.dart';
import 'package:toonflix3/widgets/currency_card.dart';

void main() {
  //ApiService().getTodaysToons(); 콘솔로 API 잘잡히나 확인
  runApp(const App());
}

class App extends StatelessWidget{
  // 이 위젯의 key를 stateless widget이라는 슈퍼클래스에 보낸 것
  // 위젯은 ID같은 식별자 역할을 하는 key가 있다는 것임
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
