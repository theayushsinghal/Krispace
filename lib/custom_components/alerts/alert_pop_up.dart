import 'dart:ui';
import 'package:flutter/material.dart';

import 'choose_subscription.dart';

//add this on onTap() for calling subscription aleart
// Navigator.of(context).push(
// PageRouteBuilder(
// pageBuilder: (context, _, __) => Create_Profile_Popup(),
// opaque: false),
// );

class Alert_PopUp extends StatelessWidget {
  const Alert_PopUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
    double Height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    Width /= 414;
    Height /= 736;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.transparent, //Color(0xff1B262C),
        contentPadding: EdgeInsets.zero,
        content: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff1B262C),
                    border: Border.all(
                      width: 2,
                      color: Color(0xff00FF94),
                    )),
                width: 320 * Width,
                height: 205 * Height,
              ),
            ),
            Positioned(
              left: 25 * Width,
              top: 74 * Height,
              child: Container(
                width: 269 * Width,
                height: 48 * Height,
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'This is a premium content. You need\n a subscription to view this content.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Arial-Regular'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 26 * Height,
              left: 145 * Width,
              child: Container(
                height: 40 * Height,
                width: 40 * Width,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xffFFC857),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (147 * Height),
              left: (70 * Width),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        pageBuilder: (context, _, __) => Choose_Subscription(),
                        opaque: false),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1B262C),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2,
                      color: Color(0xffFFC857),
                    ),
                  ),
                  width: (180 * Width),
                  height: (32 * Height),
                  child: Center(
                    child: Text(
                      "Choose Subscription",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xffFFC857),
                        fontFamily: "Arial-normal",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 290 * Width,
              top: 11 * Height,
              child: Opacity(
                opacity: .8,
                child: Container(
                  width: 20 * Width,
                  height: 20 * Height,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20 * Height,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
