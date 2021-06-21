import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassword1 extends StatefulWidget {
  @override
  _ForgetPassword1State createState() => _ForgetPassword1State();
}

class _ForgetPassword1State extends State<ForgetPassword1> {
  String _email;

  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1B262C), //.fromRGBO(27, 38, 44, 1),
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: [
            // logo
            Positioned(
              left: (251 * Width) / 414,
              top: (-66 * Height) / 736,
              child: Container(
                color: Colors.transparent,
                width: (241 * Width) / 414,
                height: (205 * Height) / 736,
                child: Image.asset(
                  "assets/krispacelogo.png",
                  //fit: BoxFit.fill,
                ),
              ),
            ),
            //back button
            Positioned(
              top: (33 * Width) / 414,
              left: (37 * Height) / 736,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 255, 148, 1),
                    shape: BoxShape.circle,
                  ),
                  width: (34 * Width) / 414,
                  height: (34 * Height) / 736,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.arrow_back_rounded),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            //background images
            Positioned(
              top: (44 * Height) / 736,
              left: (24 * Width) / 414,
              child: Container(
                color: Colors.transparent,
                width: (361 * Width) / 414,
                height: (524 * Height) / 736,
                child: Image.asset(
                  "assets/Vector1.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: (570 * Height) / 736,
              left: (14 * Width) / 414,
              child: Container(
                color: Colors.transparent,
                width: (388 * Width) / 414,
                height: (110 * Height) / 736,
                child: Image.asset(
                  "assets/Vector4_CreateAccount.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),

            //forget password
            Positioned(
              top: (74 * Height) / 736,
              left: (37 * Width) / 414,
              child: Container(
                width: (236 * Width) / 414,
                height: (49 * Height) / 736,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.white,
                      fontFamily: "Oswald-Regular",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            //email id
            Positioned(
              top: (188 * Height) / 736,
              left: (37 * Width) / 414,
              child: Container(
                width: (77 * Width) / 414,
                height: (24 * Height) / 736,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Email ID",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: "Oswald-Regular",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            //email input box
            Positioned(
              top: (222 * Height) / 736,
              left: (38 * Width) / 414,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: Color(0xff00FF94))),
                width: (328 * Width) / 414,
                height: (38 * Height) / 736,
                child: TextFormField(
                  onSaved: (value) => this._email = value,
                ),
              ),
            ),
            //verify button
            Positioned(
              top: (542 * Height) / 736,
              left: (34 * Width) / 414,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffFFC857),
                    borderRadius: BorderRadius.circular(5)),
                width: (346 * Width) / 414,
                height: (48 * Height) / 736,
                child: Center(
                  child: TextButton(
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontFamily: "Oswald-Regular",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            //OTP
            Positioned(
              top: (284 * Height) / 736,
              left: (38 * Width) / 414,
              child: Container(
                width: (77 * Width) / 414,
                height: (24 * Height) / 736,
                alignment: Alignment.bottomLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "OTP",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: "Oswald-Regular",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            // underline
            Positioned(
              top: (148 * Height) / 736,
              left: (149 * Width) / 414,
              child: Container(
                width: (100 * Width) / 414,
                height: (4 * Height) / 736,
                decoration: BoxDecoration(
                    color: Color(0xff1B262C),
                    border: Border.all(
                      width: 0.5,
                      color: Color(0xffFFC857),
                    )),
              ),
            ),
            Positioned(
              top: (148 * Height) / 736,
              left: (50 * Width) / 414,
              child: Container(
                width: (100 * Width) / 414,
                height: (4 * Height) / 736,
                decoration: BoxDecoration(
                  color: Color(0xffFFC857),
                ),
              ),
            ),
            Positioned(
              top: (143 * Height) / 736,
              left: (249 * Width) / 414,
              child: Container(
                width: (14 * Width) / 414,
                height: (14 * Height) / 736,
                decoration: BoxDecoration(
                    color: Color(0xff1B262C),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 0.5,
                      color: Color(0xffFFC857),
                    )),
              ),
            ),
            Positioned(
              top: (143 * Height) / 736,
              left: (37 * Width) / 414,
              child: Container(
                width: (14 * Width) / 414,
                height: (14 * Height) / 736,
                decoration: BoxDecoration(
                  color: Color(0xffFFC857),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
