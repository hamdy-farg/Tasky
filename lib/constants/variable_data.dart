import 'package:image_picker/image_picker.dart';
import 'package:tasky/constants/daimentions.dart';

class Data {
  static Daimentions? daimentions;
  static XFile image = XFile("path");
  static List<String> priority = [
    "choose your priority",
    "low",
    "medium",
    "high",
  ];
  static String priority_value = "choose your priority";
  static String priority_holder = "choose your priority";
}
