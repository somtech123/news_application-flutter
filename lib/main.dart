import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/category.dart';
import 'package:news_app/providers/news.dart';
import 'package:news_app/responsive/mobile_screen_layout.dart';
import 'package:news_app/responsive/responsive_layout.dart';
import 'package:news_app/responsive/web_screen_layout.dart';
import 'package:news_app/screen/login_scrren.dart';

import 'package:news_app/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyADxcfl-uGktVS8GyHcruXBAfRlXXnru1k",
      appId: "1:197832492293:web:4aafd7d82ba887c8d0e36c",
      messagingSenderId: "197832492293",
      projectId: "news-app-5ed5a",
      storageBucket: "news-app-5ed5a.appspot.com",
      authDomain: "news-app-5ed5a.firebaseapp.com",
      measurementId: "G-82V7TKR6Q5",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => News()),
      ],
      child: MaterialApp(
        title: 'Som News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    mobileScreenLayout: MobileSceenLayout(),
                    webScreenLayout: WebScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
