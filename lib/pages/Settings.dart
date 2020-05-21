import 'package:flutter/material.dart';
import '../utils/ConfirmDialog.dart';
import '../utils/User.dart';
import '../utils/FormDialog.dart';
import '../utils/ChatDB.dart';

class SettingsButton {
  final String title;
  final void Function() onTap;

  SettingsButton({
    this.title,
    this.onTap,
  });
}

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final User user = User();
  String userName;

  Future _setUser() async {
    await user.sync();
    setState(() {
      userName = user.name;
    });
  }

  Widget _createSettingButton(SettingsButton setting) {
    return ListTile(
      title: Text(
        setting.title,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setting.onTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<SettingsButton> settings = [
      SettingsButton(
        title: 'User Name: $userName',
        onTap: () {
          showFormDialog(
            context: context,
            title: '新しいユーザー名を設定',
            onAllow: (String value) async {
              await user.update({ 'name': value });
              setState(() {
                userName = value;
              });
            }
          );
        }
      ),
      SettingsButton(
        title: 'Clear cache',
        onTap: () {
          showConfirmDialog(
            context: context,
            title: '確認',
            message: 'キャッシュをクリアするとメッセージが全て削除されますがよろしいですか？',
            onAllow: () async {
              final chatDB = ChatDB();
              await chatDB.delete();
            }
          );
        }
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: (settings.length * 2),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _createSettingButton(settings[i ~/ 2]);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setUser();
  }
}
