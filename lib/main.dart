import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController valueController = TextEditingController();
  String currentValue = 'no value Saved';
  static const valueKey = 'valueKey';
  //Fuction to store value in the SharedPreferences
  void setValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(valueKey, value);
  }
 //Function to get value from the SharedPrefrences
  void getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentValue = prefs.getString(valueKey) ?? currentValue;
    });
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: valueController,
            decoration: InputDecoration(
              //enabledBorder value
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
              //FocusedBorder Value
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          //Save Button
          ElevatedButton(
            onPressed: () {
              setValue(valueController.text);
              getValue();
            },
            child: const Text('save'),
          ),
          const SizedBox(
            height: 11,
          ),
          Text(currentValue),
        ],
      ),
    );
  }
}
