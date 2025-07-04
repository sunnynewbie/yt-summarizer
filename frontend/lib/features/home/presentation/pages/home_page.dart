import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:frontend/features/home/presentation/bloc/home_event.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formKey = GlobalKey<FormState>();
  var urlCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summarize')),
      body: Form(
        key: formKey,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 876
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: urlCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter URL';
                    }
                    return null;
                  },
                ),
                Gap(20),
                FilledButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      HomeBloc().add(SubmitForm(urlCtrl.text));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
