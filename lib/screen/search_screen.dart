import 'package:flutter/material.dart';
import 'package:news_app/utils/colors.dart';

import 'package:provider/provider.dart';
import '../providers/news.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShow = false;
  bool _isLoading = false;
  var _isInt = true;

  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInt) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<News>(context)
          .searchNews(searchController.text)
          .then((value) {
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
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search',
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShow = true;
            });
          },
        ),
      ),
      body: isShow
          ? Text(searchController.text)
          : const Center(
              child: Text('Oops nothing found '),
            ),
    );
  }
}
