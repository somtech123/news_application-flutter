import 'package:flutter/material.dart';

import 'package:news_app/providers/category.dart';
import 'package:news_app/providers/news.dart';

import 'package:news_app/widgets/appbar_card.dart';
import 'package:news_app/widgets/category_card.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  var _isInt = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInt) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<News>(context).getNews().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInt = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const AppbarCard(),
        // bottom: TabBar(
        //   controller: _controller,
        //   tabs: tabs,
        // )),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 70,
              child: Consumer<CategoryProvider>(
                builder: (context, value, child) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.category.length,
                  itemBuilder: ((context, index) => CategoryCard(
                        categoryName: value.category[index].categoryName,
                        imageAssetUrl: value.category[index].imageAsset,
                      )),
                ),
              ),
            ),
            // TabBarView(children: [
            //   NewsCard(),
            // ]),
            const NewsCard(),
          ],
        ),
      ),
    );
  }
}
