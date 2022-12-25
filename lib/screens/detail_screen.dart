import 'package:flutter/material.dart';
import 'package:flutter_toonflix/models/webtoon_detail_model.dart';
import 'package:flutter_toonflix/models/webtoon_episode_model.dart';
import 'package:flutter_toonflix/models/webtoon_model.dart';
import 'package:flutter_toonflix/services/api_service.dart';
import 'package:flutter_toonflix/widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoon;

  const DetailScreen(
    this.webtoon, {
    super.key,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.webtoon.id);
    episodes = ApiService.getLatestEpisodesById(widget.webtoon.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.webtoon.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.webtoon,
                  child: Container(
                    width: 250,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: const Offset(5, 5),
                              color: Colors.black.withOpacity(0.5))
                        ]),
                    child: Image.network(widget.webtoon.thumb),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder(
              future: webtoon,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '${snapshot.data!.genre} / ${snapshot.data!.age}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(height: 25),
            FutureBuilder(
              future: episodes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (var episode in snapshot.data!)
                        Episode(episode: episode, webtoonId: widget.webtoon.id)
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ]),
        ),
      ),
    );
  }
}
