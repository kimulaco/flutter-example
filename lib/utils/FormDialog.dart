import 'package:flutter/material.dart';

void showFormDialog({
  @required BuildContext context,
  String title = '',
  String cancelText = 'Cancel',
  String hintText = '',
  String allowText = 'OK',
  void Function(String) onAllow,
  void Function() onCancel,
}) {
  final _inputController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: title.length > 0 ? Text(title) : null,
        content: TextField(
          controller: _inputController,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          autofocus: true,
        ),
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
              if (onAllow != null) onAllow(_inputController.text);
            },
          ),
        ],
      );
    },
  );
}