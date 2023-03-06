import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toonflix3/services/api_service.dart';

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {

  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  // Stateful위젯을 사용한 이유는 initState메소드가 필요해서임
  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold로 기본적인 레이아웃과 설정 제공받음
        backgroundColor: Colors.white,
        appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 26,
        //fontWeight: FontWeight.w600,
        ),
      ),
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 50,
            // all(50)도 가능
          ),
          child: Column(
            children: [
              //SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: Offset(10, 10),
                              color: Colors.black.withOpacity(0/5),
                            )
                          ]
                      ),
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          '{$snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return Text('...');
                },
              ),
              const SizedBox(height: 50,),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        for(var episodes in snapshot.data!)
                          Episode(episode: episodes, webtoonId:widget.id)
                      ],
                    );
                  }
                  return Container();
                }
              ),
              const SizedBox(height: 50,),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        for(var episode in snapshot.data!) Text(episode.title)
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

