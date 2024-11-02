import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shope_ease/theme/theme.dart';

class Widgets {
  customAppbar(String title, BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios)),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  widgetLoader() {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: buttonColor,
        size: 30,
      ),
    );
  }

  toastWidget(String message, BuildContext context) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
