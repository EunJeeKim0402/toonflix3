import 'package:flutter/material.dart';

// Button 위젯. 다른 곳에서도 사용 가능
class Button extends StatelessWidget{
  // 내 Button이 가지는 프로퍼티를 작성. ex) text는 프로퍼티를 가질 수 있음
  final String text; // text 프로퍼티
  final Color bgColor; // backgroundColor 프로퍼티
  final Color textColor; // textColor 프로퍼티

  // 생성자 함수 생성(constructor)
  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15, horizontal: 40,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

}
