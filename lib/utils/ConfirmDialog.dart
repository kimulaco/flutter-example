import 'package:flutter/material.dart';

void showConfirmDialog({
  @required BuildContext context,
  @required String message,
  String title = '',
  String cancelText = 'Cancel',
  String allowText = 'OK',
  void Function() onAllow,
  void Function() onCancel,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: title.length > 0 ? Text(title) : null,
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(cancelText),
            onPressed: () {
              Navigator.pop(context);
              if (onCancel != null) onCancel();
            },
          ),
          FlatButton(
            child: Text(allowText),
            onPressed: () {
              Navigator.pop(context);
              if (onAllow != null) onAllow();
            },
          ),
        ],
      );
    },
  );
}