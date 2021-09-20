import 'package:flutter/cupertino.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_let.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/button_custom.dart';
import 'package:restauant_app/src/utils/component/text_field_custom.dart';
import 'package:restauant_app/src/view/login_screen/login_bloc.dart';

import 'change_password_screen/change_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${Constant.titleApp}",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: ColorCustom.colorTheem,
        flexibleSpace: gradientCustom(),

      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: Adaptive.sp(25)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon/ic_logo_v4.png",
                width: Adaptive.w(40),
              ),
              Container(
                margin: EdgeInsets.only(top: Adaptive.sp(20)),
                child: Text(
                  Constant.sigIn,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              StreamBuilder(
                  stream: bloc.streamUsername,
                  builder: (context, snapshot) {
                    return TextFieldCustom(
                      controller: bloc.controllerUsername,
                      hintText: Constant.user,
                      error: snapshot.data,

                      margin: EdgeInsets.only(
                        left: Adaptive.sp(30),
                        right: Adaptive.sp(30),
                        top: Adaptive.sp(40),
                      ),
                    );
                  }),
              StreamBuilder(
                  stream: bloc.streamPassword,
                  builder: (context, snapshot) {
                    return TextFieldCustom(
                      controller: bloc.controllerPassword,
                      hintText: Constant.password,
                      error: snapshot.data,
                      maxLength: 10,
                      obscureText: true,
                      margin: EdgeInsets.only(
                        left: Adaptive.sp(30),
                        right: Adaptive.sp(30),
                        top: Adaptive.sp(20),
                      ),
                    );
                  }),
              ButtonCustom(
                title: Constant.sigIn,
                margin: EdgeInsets.only(
                  left: Adaptive.sp(30),
                  right: Adaptive.sp(30),
                  top: Adaptive.sp(40),
                ),
                onClick: () {
                  bloc.login(context);
                },
              ),
              SizedBox(height: Adaptive.sp(40)),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context, PushScreenSwitchRight(enterPage: ChangePasswordScreen()));
              //   },
              //   child: Container(
              //     child: Text(
              //       Constant.changePasswordV1,
              //       style: TextStyle(
              //         fontWeight: FontWeight.normal,
              //         fontSize: 12,
              //         fontStyle: FontStyle.italic,
              //         decoration: TextDecoration.underline,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
