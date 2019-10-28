import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/org/learn/ui/main_page.dart';
import 'package:flutter_app/org/learn/utils/route.dart';

class LauncherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LauncherState();
  }
}

class LauncherState extends State<StatefulWidget> {
  Timer _timer;
  int _countdownTime = 3;

  @override
  Widget build(BuildContext context) {
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) => {
          if (mounted)
            {
              setState(() {
                if (_countdownTime < 1) {
                  _timer.cancel();
                  RouteUtils.pushAndRemoveUntil(context, MainPage());
                } else {
                  _countdownTime = _countdownTime - 1;
                }
              })
            }
        };
    _timer = Timer.periodic(oneSec, callback);

    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[Text("${_countdownTime.toString()}秒")],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
