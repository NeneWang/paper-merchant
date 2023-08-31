import 'package:get/get.dart';

class ColorChangeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var isChange1 = false.obs;
  var isChange = false.obs;
  var isChange2 = false.obs;
  var isChange3 = false.obs;
  var isChange4 = false.obs;
  var isChange5 = false.obs;
  var isChange6 = false.obs;
  var isChange7 = false.obs;
  var isChange8 = false.obs;
  var isChange9 = false.obs;
  var isChange10 = false.obs;
  var isChange11 = false.obs;
  var lights = false.obs;
  var lights1 = false.obs;
  var isCheck = [
    false,
    false,
    false,
    false,
  ].obs;
  var selectionListToggle = [
    true,
    false,
  ].obs;
  var buttonCheck1 = false.obs;
  var buttonCheck2 = false.obs;
  var graphLine = true.obs;
  var graphCandle = false.obs;
}

condition() {
  ColorChangeController colorChangeController = Get.find();

  if (colorChangeController.isChange1.isTrue ||
      colorChangeController.isChange.isTrue ||
      colorChangeController.isChange2.isTrue ||
      colorChangeController.isChange3.isTrue ||
      colorChangeController.isChange4.isTrue ||
      colorChangeController.isChange5.isTrue ||
      colorChangeController.isChange6.isTrue ||
      colorChangeController.isChange7.isTrue ||
      colorChangeController.isChange8.isTrue ||
      colorChangeController.isChange9.isTrue ||
      colorChangeController.isChange10.isTrue ||
      colorChangeController.isChange11.isTrue) {
    print("############");
    colorChangeController.isChange1(false);
    colorChangeController.isChange(false);
    colorChangeController.isChange2(false);
    colorChangeController.isChange3(false);
    colorChangeController.isChange4(false);
    colorChangeController.isChange5(false);
    colorChangeController.isChange6(false);
    colorChangeController.isChange7(false);
    colorChangeController.isChange8(false);
    colorChangeController.isChange9(false);
    colorChangeController.isChange10(false);
    colorChangeController.isChange11(false);
  }
}
