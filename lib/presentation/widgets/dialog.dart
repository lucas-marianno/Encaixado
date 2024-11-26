import 'package:flutter/material.dart';

class MessageDialog {
  final BuildContext context;

  MessageDialog(this.context);

  Future show({String? title, required String message}) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title == null ? null : Text(title),
        content: Text(message),
      ),
    );
  }
}
