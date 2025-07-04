import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('Summery of the video'),),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1240),
        child: Text(''),
      ),
    );
  }
}
