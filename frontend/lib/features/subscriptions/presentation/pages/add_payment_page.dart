import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';

class AddPaymentPage extends StatelessWidget {
  const AddPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Confirm payment'),
      body: ListView(
        children: [],
      ),
    );
  }
}
