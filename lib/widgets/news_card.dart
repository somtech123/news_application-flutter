import 'package:flutter/material.dart';
import 'package:news_app/providers/news.dart';
import 'package:news_app/widgets/news_tile.dart';
import 'package:provider/provider.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final newsList = Provider.of<News>(context);
    if (newsList.news.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Expanded(
      child: Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: newsList.news.length,
          itemBuilder: ((context, index) => NewsTile(
                imgUrl: newsList.news[index].urlToImage,
                title: newsList.news[index].title,
                desc: newsList.news[index].description,
                content: newsList.news[index].content,
                posturl: newsList.news[index].articleUrl,
              )),
        ),
      ),
    );
  }
}
