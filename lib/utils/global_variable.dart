import 'package:flutter/cupertino.dart';
import 'package:news_app/screen/feeds_screen.dart';
import 'package:news_app/screen/profile_screen.dart';
import 'package:news_app/screen/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const SearchScreen(),
  const ProfileScreen()
];
