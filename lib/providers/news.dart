import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:news_app/models/article.dart';
import 'package:http/http.dart' as http;

class News with ChangeNotifier {
  List<Article> _news = [];
  List<Article> get news {
    return [..._news];
  }

// get all news headline in with country ng (Nigeria) from newsapi.org
  Future<void> getNews() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=ng&apiKey=2d915f1a42ab488b8a1604154e3cc139');
    try {
      var response = await http.get(url);
      final jsonData = json.decode(response.body);
      final List<Article> list = [];
      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['description'] != null && element['urlToImage'] != null) {
            list.add(Article.fromJson(element));
            _news = list;

            notifyListeners();
          }
        });
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> searchNews(String word) async {
    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$word&apiKey=2d915f1a42ab488b8a1604154e3cc139');
    try {
      var response = await http.get(url);
      final jsonData = json.decode(response.body);
      final List<Article> list = [];
      if (jsonData['status'] == 'ok') {
        jsonData['articles'].forEach((element) {
          if (element['description'] != null && element['urlToImage'] != null) {
            list.add(Article.fromJson(element));
            _news = list;

            notifyListeners();
          }
        });
        //  print(_news);
      }
    } catch (e) {
      e.toString();
      // print(e.toString());
    }
  }
}
