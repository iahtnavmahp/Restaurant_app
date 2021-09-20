import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/button_custom.dart';
import 'package:restauant_app/src/utils/component/text_field_custom.dart';
import 'package:restauant_app/src/view/login_screen/change_password_screen/change_password_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen> {
  ChangePasswordBloc bloc = ChangePasswordBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("${Constant.titleApp}"),
        backgroundColor: ColorCustom.colorTheem,
        flexibleSpace: gradientCustom(),

      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: size.width / 6),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: size.width / 10),
              child: BaseTextCustom().setText(
                text: Constant.changePassword,
                minFontSize: 17,
                maxFontSize: 20,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            StreamBuilder(
                stream: bloc.streamPassword,

                builder: (context, snapshot) {
              return TextFieldCustom(
                controller: bloc.controllerPassword,
                hintText: Constant.enterChangePasswordHT,
                error: snapshot.data,
                margin: EdgeInsets.only(
                  left: size.width / 15,
                  right: size.width / 15,
                  top: size.width / 8,
                ),
              );
            }),
            StreamBuilder(
                stream: bloc.streamNewPassword,
                builder: (context, snapshot) {
                  return TextFieldCustom(
                    controller: bloc.controllerNewPassword,
                    hintText: Constant.enterChangePasswordM,
                    error: snapshot.data,
                    obscureText: true,
                    margin: EdgeInsets.only(
                      left: size.width / 15,
                      right: size.width / 15,
                      top: size.width / 20,
                    ),
                  );
                }),
            StreamBuilder(
                stream: bloc.streamNewPasswordConfig,
                builder: (context, snapshot) {
                  return TextFieldCustom(
                    controller: bloc.controllerPasswordConfig,
                    hintText: Constant.enterChangePasswordM,
                    error: snapshot.data,
                    obscureText: true,
                    margin: EdgeInsets.only(
                      left: size.width / 15,
                      right: size.width / 15,
                      top: size.width / 20,
                    ),
                  );
                }),
            ButtonCustom(
              title: Constant.changePasswordV2,
              margin: EdgeInsets.only(
                left: size.width / 15,
                right: size.width / 15,
                top: size.width / 10,
              ),
              onClick: () {
                bloc.isCheckLogin();
              },
            ),
            SizedBox(
              height: size.width / 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: BaseTextCustom().setText(
                  text: "Quay lại",
                  minFontSize: 13,
                  maxFontSize: 14,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
