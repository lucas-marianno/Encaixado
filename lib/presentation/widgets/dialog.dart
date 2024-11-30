import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageDialog {
  final BuildContext context;
  MessageDialog(this.context);

  Future show({String? title, required Widget content}) async {
    return await showDialog(
      context: context,
      builder: (context) => KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKeyEvent: (value) {
          if (value is! KeyDownEvent) return;
          final keyLabel = value.logicalKey.keyLabel.toLowerCase();

          if (keyLabel == 'backspace' ||
              keyLabel == 'escape' ||
              keyLabel == 'enter' ||
              keyLabel == ' ') {
            Navigator.of(context).pop();
          }
        },
        child: AlertDialog(
          title: title == null ? null : Text(title),
          content: content,
        ),
      ),
    );
  }
}
