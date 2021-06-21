import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//add this on onTap() for calling subscription aleart
// Navigator.of(context).push(
// PageRouteBuilder(
// pageBuilder: (context, _, __) => Alert_Pop_Up(),
// opaque: false),
// );

class Choose_Subscription extends StatefulWidget {
  @override
  _Choose_SubscriptionState createState() => _Choose_SubscriptionState();
}

class _Choose_SubscriptionState extends State<Choose_Subscription> {
  String _subscription, _monthly, _yearly;
  bool offyearly = true, offmonthly = true;
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
                height: 427 * Height,
              ),
            ),
            Positioned(
              left: 25 * Width,
              top: 83 * Height,
              child: Container(
                width: 269 * Width,
                height: 24 * Height,
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Choose a Subscription',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Arial-Regular'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (371 * Height),
              left: (70 * Width),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFFC857),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: (180 * Width),
                  height: (32 * Height),
                  child: Center(
                    child: Text(
                      "Pay Now",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 181 * Height,
              left: 183 * Width,
              child: Container(
                width: 95 * Width,
                height: 30 * Height,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Rs 295\nper annum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffFFC857),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 181 * Height,
              left: 44 * Width,
              child: Container(
                width: 95 * Width,
                height: 30 * Height,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Rs 30\nper month',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffFFC857),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 240 * Height,
              left: 44 * Width,
              child: Container(
                width: 90 * Width,
                height: 20 * Height,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'No Discount',
                    style: TextStyle(
                      color: Color(0xff00FF94),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 240 * Height,
              left: 186 * Width,
              child: Container(
                width: 90 * Width,
                height: 20 * Height,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '18% Discount',
                    style: TextStyle(
                      color: Color(0xff00FF94),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 268 * Height,
              left: 44 * Width,
              child: Container(
                width: 90 * Width,
                height: 20 * Height,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Billed monthly',
                    style: TextStyle(
                      color: Color(0xff00FF94),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 268 * Height,
              left: 186 * Width,
              child: Container(
                width: 90 * Width,
                height: 20 * Height,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Billed annually',
                    style: TextStyle(
                      color: Color(0xff00FF94),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 306 * Height,
              left: 81 * Width,
              child: Container(
                width: 16 * Width,
                height: 16 * Height,
                child: Container(
                  width: 16 * Width,
                  height: 16 * Height,
                  child: offmonthly
                      ? Icon(
                          Icons.radio_button_off_rounded,
                          color: Color(0xff00FF94),
                        )
                      : Icon(
                          Icons.radio_button_on_rounded,
                          color: Color(0xff00FF94),
                        ),
                ),
              ),
            ),
            Positioned(
              top: 306 * Height,
              left: 223 * Width,
              child: Container(
                width: 16 * Width,
                height: 16 * Height,
                child: offyearly
                    ? Icon(
                        Icons.radio_button_off_rounded,
                        color: Color(0xff00FF94),
                      )
                    : Icon(
                        Icons.radio_button_on_rounded,
                        color: Color(0xff00FF94),
                      ),
              ),
            ),
            Positioned(
              top: 26 * Height,
              left: 137 * Width,
              child: Container(
                height: 46 * Height,
                width: 46 * Width,
                child: Image.asset('assets/renew1.png'),
              ),
            ),
            Positioned(
              left: 169 * Width,
              top: 136 * Height,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (offyearly) {
                      offyearly = false;
                      offmonthly = true;
                      _subscription = _yearly;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //color: Color(0xff1B262C),
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      )),
                  width: 124 * Width,
                  height: 200 * Height,
                ),
              ),
            ),
            Positioned(
              left: 27 * Width,
              top: 136 * Height,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (offmonthly) {
                      offyearly = true;
                      offmonthly = false;
                      _subscription = _monthly;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //color: Color(0xff1B262C),
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      )),
                  width: 124 * Width,
                  height: 200 * Height,
                ),
              ),
            ),
            Positioned(
              top: (126 * Height),
              left: (44 * Width),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff00FF94),
                  borderRadius: BorderRadius.circular(2),
                ),
                width: (90 * Width),
                height: (30 * Height),
                child: Center(
                  child: Text(
                    "Monthly",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                      fontFamily: "Oswald-Regular",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (126 * Height),
              left: (186 * Width),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff00FF94),
                  borderRadius: BorderRadius.circular(2),
                ),
                width: (90 * Width),
                height: (30 * Height),
                child: Center(
                  child: Text(
                    "Annually",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                      fontFamily: "Oswald-Regular",
                      fontWeight: FontWeight.w500,
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 20 * Width,
                    height: 20 * Height,
                    alignment: Alignment.center,
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
