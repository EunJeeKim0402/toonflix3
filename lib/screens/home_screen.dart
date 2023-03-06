import 'package:flutter/material.dart';
import 'package:toonflix3/services/api_service.dart';
import 'package:toonflix3/widgets/webtoon_widget.dart';
import 'dart:async';

import '../models/webtoon_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    // FutureBuilder
    return Scaffold( // Scaffold로 기본적인 레이아웃과 설정 제공받음
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 26,
            //fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        // FutureBuilder는 미래의 값을 기다리고 데이터가 존재하는지 알려줌.
        // FutureBuilder는 builder라는 매개변수가 필요함.
        // Builder는 UI를 그려주는 함수
        future: webtoons,
        builder: (context, snapshot){
          // snapshot을 이용하면 Future의 상태를 알 수 있음
          if(snapshot.hasData){
            return Column(
              children: [
                SizedBox(height: 50,),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>>snapshot){
    return ListView.separated(
      // ListView.builder는 좀 더 최적화된 ListView
      // 사용자가 보고있는 아이템만 데이터에 넣을 것임.
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index){
        var webtoon = snapshot.data![index];
        return Webtoon(title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id,);
      },
      separatorBuilder: (context, index) => SizedBox(width: 40),
    );
  }

}