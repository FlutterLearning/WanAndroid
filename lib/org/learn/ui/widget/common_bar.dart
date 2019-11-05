import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/org/learn/utils/route.dart';

class CommonBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String channel;

  CommonBar(this.title, this.channel, {Key key}) : super(key: key);

  void _finish(BuildContext context) {
    RouteUtils.finish(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Image.asset("assets/images/3.0x/icon_white_back.png", width: 25, height: 25),
                        onPressed: () {
                          _finish(context);
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 25, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
