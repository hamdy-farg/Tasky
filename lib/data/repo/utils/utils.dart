import 'package:flutter/material.dart';

class Utils {
  Future<String> selectedData(
    BuildContext context,
  ) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    return picked.toString().split(" ")[0];
  }
}

// date_controller!.text =