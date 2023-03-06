import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix3/models/webtoon_episode_model.dart';
import 'package:toonflix3/models/webtoon_model.dart';

import '../models/webtoon_detail_model.dart';

class ApiService{
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev/";
  static const String today = "today";

  // API가 반환한 JSON받아오기 https://pub.dev/ get요청 보낼 준비중
  // Future은 미래에 받을 값의 타입을 알려줌. API요청이 처리되서 응답 반환 후 처리예정
  // 비동기 프로그래밍(async). 서버가 응답할때까지 프로그램을 기다리게함
  static Future<List<WebtoonModel>> getTodaysToons() async{
    // JSON으로 웹툰을 만들때마다 아래 리스트에 추가해줌.
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); // await로 기다리라고 명령함
    if(response.statusCode == 200){ // 상태코드가 200인지 체크. 200이 성공
      //print(response.body); // body에는 서버가 보낸 데이터가 있음
      final List<dynamic> webtoons = jsonDecode(response.body);
      for(var webtoon in webtoons){
        //print(webtoon); // 텍스트인 응답 body를 JSON으로 디코딩해줌
        //final toon = WebtoonModel.fromJson(webtoon);
        //print(toon.title);
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async{
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if(response.statusCode == 200){
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJon(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(String id) async{
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if(response.statusCode == 200){
      final episodes = jsonDecode(response.body);
      for(var episode in episodes){
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }

}