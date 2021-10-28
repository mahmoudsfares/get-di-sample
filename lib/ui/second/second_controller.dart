
import 'package:get/get.dart';
import 'package:get_dependency_testing/model/model.dart';

import 'second_service.dart';


class SecondController extends GetxController{

  Rx<FetchState> state = FetchState().obs;
  SecondService _service = Get.find<SecondService>();

  void fetchData() async {
    state.value = Loading();
    try {
      Model data = await _service.fetchData();
      state.value = Fetched(data);
    }
    catch (e){
      if(e is Exception) state.value = Error(e);
    }
  }
}