import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_dependency_testing/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'second_controller.dart';

class SecondScreen extends GetView<SecondController> {

  SharedPreferences _prefs = Get.find();
  RxString _textInPrefs = "".obs;

  @override
  Widget build(BuildContext context) {
    controller.fetchData();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (controller.state.value is Loading) {
                return CircularProgressIndicator();
              } else if (controller.state.value is Error) {
                return Text("Error");
              } else if (controller.state.value is Fetched) {
                String data =
                    ((controller.state.value as Fetched).data as Model).title;
                return Text(data);
              } else {
                return SizedBox();
              }
            }),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  _textInPrefs.value = _prefs.getString('name')!;
                },
                child: Text('Click to see text in preferences')),
            SizedBox(height: 8),
            Obx(() {
              if(_textInPrefs.value == "")
                return SizedBox();
              else
                return Text('Text in preferences is: ${_textInPrefs.value}');
            }),
          ],
        ),
      ),
    );
  }
}
