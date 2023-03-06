import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget{

  final String name, code, amount;
  final IconData icon;
  final bool isInverted;

  // 별도의 프로퍼티로 빼놓음
  // _는 private하게 만들겠다는 뜻
  final _blackColor = const Color(0xFF1F2123);

  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge, // 어떤 아이템이 overflow되었을때 카드같은 Container의 동작을 설정
      decoration: BoxDecoration(
        color: isInverted ? Colors.white : _blackColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        //padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20,),
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: isInverted ? _blackColor : Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      code,
                      style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Transform.scale(
              // Transform - 아이콘의 크기만 변경하면 아이콘 주변의 모든것들은 전부 커지게 됨
              scale: 2.2,
              child: Transform.translate(
                offset: Offset(-5, 12), // x축 , y축
                child: Icon(
                  icon,
                  color: isInverted ? _blackColor : Colors.white,
                  size: 88,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

}