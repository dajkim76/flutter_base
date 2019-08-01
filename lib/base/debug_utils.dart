import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'noti_manager.dart';

class DebugUtils {
  static exception(String tag, String message, dynamic ex) {
    if (kReleaseMode) {
      // TODO send to firebase
    } else {
      Log.e(tag, message, ex: ex);
      NotiManager.instance.createDebugNoti(tag, message, ex.toString());
      toast(tag, "$message\n${ex.toString()}");
    }
  }

  static failed(String tag, String message) {
    if (kReleaseMode) {
      // TODO send to firebase
    } else {
      Log.e(tag, message);
      NotiManager.instance.createDebugNoti(tag, message, currentStackTrace());
      toast(tag, message);
    }
  }

  static toast(String tag, String message) {
    if (!kReleaseMode) {
      Fluttertoast.showToast(msg: "[$tag]\n$message");
    }
  }

  static alert(BuildContext context, String tag, String message) {
    if (kReleaseMode) {
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(tag),
            content: Text(message + "\n\n" + currentStackTrace()),
            actions: <Widget>[FlatButton(child: Text("CANCEL"), onPressed: () => Navigator.pop(context))],
          );
        });
  }

  static void checkNotNull(Object o, {String message}) {
    if (!kReleaseMode && o == null) {
      NotiManager.instance.createDebugNoti("checkNotNull!!", message, currentStackTrace());
      toast("checkNotNull!!", "$message\n\n${currentStackTrace()}");
    }
  }

  static void checkState(bool state, {String message}) {
    if (!kReleaseMode && state == false) {
      NotiManager.instance.createDebugNoti("checkState!!", message, currentStackTrace());
      toast("checkState!!", "$message\n\n${currentStackTrace()}");
    }
  }

  static void notify(String tag, String message) {
    if (!kReleaseMode) {
      NotiManager.instance.createDebugNoti(tag, message, currentStackTrace());
    }
  }

  static String currentStackTrace() => StackTrace.current.toString();
}

class Log {
  static initialize() {
    if (!kReleaseMode) {
      Fimber.plantTree(DebugTree());
    }
  }

  static d(String tag, String message, {dynamic ex}) {
    if (!kReleaseMode) {
      Fimber.log("D", message, tag: tag, ex: ex);
    }
  }

  static w(String tag, String message, {dynamic ex}) {
    if (!kReleaseMode) {
      Fimber.log("W", message, tag: tag, ex: ex);
    }
  }

  static e(String tag, String message, {dynamic ex}) {
    if (!kReleaseMode) {
      Fimber.log("E", message, tag: tag, ex: ex);
    }
  }
}
