import 'package:flutter/material.dart';

class AppbarCard extends StatelessWidget {
  const AppbarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Som',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        Text(
          'News',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
