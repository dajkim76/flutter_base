import 'package:flutter/material.dart';

import 'base/utils.dart';
import 'generated/i18n.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: S.of(context).email),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: S.of(context).password),
            obscureText: true,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: Text(S.of(context).login),
                onPressed: () =>
                    showAlertDialog(context, "Login", emailController.text + "\n" + passwordController.text),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).loginPageTitle),
      actions: <Widget>[
        GestureDetector(
          onTap: _showJoinDialog,
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Text(S.of(context).join),
            alignment: Alignment.center,
          ),
        ),
        PopupMenuButton(
          itemBuilder: (_) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              child: Text(S.of(context).resetPassword),
              value: "",
            )
          ],
          onSelected: (id) => _showResetDialog(),
        )
      ],
    );
  }

  _showJoinDialog() {
    String _email, _password1, _password2;

    _onJoin() {
      Navigator.pop(context);
      showAlertDialog(context, "Join", "$_email\n$_password1");
    }

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: S.of(context).email),
                  onChanged: (value) => _email = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: S.of(context).password),
                  onChanged: (value) => _password1 = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: S.of(context).confirmPassword),
                  onChanged: (value) => _password2 = value,
                ),
              ],
            ),
            actions: <Widget>[FlatButton(child: Text(S.of(context).join), onPressed: _onJoin)],
          );
        });
  }

  _showResetDialog() {
    String _email;

    _onReset() {
      Navigator.pop(context);
      showAlertDialog(context, "Reset", "$_email");
    }

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            content: TextField(
              decoration: InputDecoration(labelText: S.of(context).email),
              onChanged: (value) => _email = value,
            ),
            actions: <Widget>[FlatButton(child: Text(S.of(context).resetPassword), onPressed: _onReset)],
          );
        });
  }
}
