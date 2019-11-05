import 'package:flutter/cupertino.dart';

class RouteUtils {
  static push(BuildContext context, Widget widget) {
    Navigator.push(context, new CupertinoPageRoute<void>(builder: (ctx) => widget));
  }

  static pushAndRemoveUntil(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      new CupertinoPageRoute(builder: (context) => widget),
      (route) => route == null,
    );
  }

  static finish(BuildContext context) {
    Navigator.pop(context);
  }
}
