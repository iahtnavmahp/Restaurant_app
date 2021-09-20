import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:restauant_app/src/model/user_model_v2.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/button_custom.dart';
import 'package:restauant_app/src/utils/component/dialog_custom/dialog_loading.dart';
import 'package:restauant_app/src/utils/component/text_field_custom.dart';

import 'detail_empolyee_bloc.dart';

class DetailEmpolyeeScreen extends StatefulWidget {
  DetailEmpolyeeScreen({this.dataModel, this.isCheck});

  final UserModelV2 dataModel;
  final bool isCheck;

  @override
  _DetailEmpolyeeScreenState createState() => _DetailEmpolyeeScreenState();
}

class _DetailEmpolyeeScreenState extends State<DetailEmpolyeeScreen> {
  DetailEmpolyeeBloc bloc = DetailEmpolyeeBloc();

  @override
  void initState() {
    super.initState();
    bloc.setDataUser(dataModel: widget.dataModel);
    bloc.isCheckRadioButton(widget.dataModel != null && widget.dataModel.roles.length > 0 ? widget.dataModel.roles[0].name : "ROLE_USER");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: Adaptive.sp(20),
            )),
        backgroundColor: ColorCustom.colorTheem,
        title: Text(Constant.manager),
        flexibleSpace: gradientCustom(),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: size.width / 15,
          right: size.width / 15,
          top: size.width / 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseTextCustom().setText(
                    text: Constant.nameEmp.toUpperCase(),
                    minFontSize: 12,
                    maxFontSize: 14,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                  ),
                  StreamBuilder(
                    stream: bloc.streamCreateName,
                    builder: (context, snapshot) {
                      return TextFieldCustom(
                        controller: bloc.controllerName,
                        error: snapshot.data,
                        margin: EdgeInsets.only(
                          top: size.width / 40,
                        ),
                      );
                    }
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.width / 20,
                    ),
                    child: BaseTextCustom().setText(
                      text: Constant.username_v2.toUpperCase(),
                      minFontSize: 12,
                      maxFontSize: 14,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                    ),
                  ),
                  StreamBuilder(
                    stream: bloc.streamCreateUsername,
                    builder: (context, snapshot) {
                      return TextFieldCustom(
                        controller: bloc.controllerUsername,
                        error: snapshot.data,
                        margin: EdgeInsets.only(
                          top: size.width / 40,
                        ),
                      );
                    }
                  ),
                  widget.isCheck != false
                      ? Container(
                          margin: EdgeInsets.only(
                            top: size.width / 20,
                          ),
                          child: BaseTextCustom().setText(
                            text: Constant.password_v2.toUpperCase(),
                            minFontSize: 12,
                            maxFontSize: 14,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                          ),
                        )
                      : SizedBox(),
                  widget.isCheck != false
                      ? StreamBuilder(
                          stream: bloc.streamCreatePassword,
                          builder: (context, snapshot) {
                            return TextFieldCustom(
                              controller: bloc.controllerPassword,
                              error: snapshot.data,
                              margin: EdgeInsets.only(
                                top: size.width / 40,
                              ),
                            );
                          })
                      : SizedBox(),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.width / 20,
                    ),
                    child: BaseTextCustom().setText(
                      text: Constant.phone.toUpperCase(),
                      minFontSize: 12,
                      maxFontSize: 14,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                    ),
                  ),
                  StreamBuilder(
                    stream: bloc.streamCreatePhone,
                    builder: (context, snapshot) {
                      return TextFieldCustom(
                        controller: bloc.controllerPhone,
                        keyboardType: TextInputType.phone,
                        error: snapshot.data,
                        maxLength: 10,
                        margin: EdgeInsets.only(
                          top: size.width / 40,
                        ),
                      );
                    }
                  ),
                  widget.isCheck == false
                      ? Container(
                          margin: EdgeInsets.only(
                            top: size.width / 20,
                          ),
                          child: BaseTextCustom().setText(
                            text: Constant.address.toUpperCase(),
                            minFontSize: 12,
                            maxFontSize: 14,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                          ),
                        )
                      : SizedBox(),
                  widget.isCheck == false
                      ? TextFieldCustom(
                          controller: bloc.controllerAddress,
                          margin: EdgeInsets.only(
                            top: size.width / 40,
                          ),
                        )
                      : SizedBox(),
                  widget.isCheck == false
                      ? Container(
                          margin: EdgeInsets.only(
                            top: size.width / 20,
                          ),
                          child: BaseTextCustom().setText(
                            text: Constant.birthday.toUpperCase(),
                            minFontSize: 12,
                            maxFontSize: 14,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                          ),
                        )
                      : SizedBox(),
                  widget.isCheck == false
                      ? Theme(
                          data: Theme.of(context).copyWith(
                            primaryColor: ColorCustom.colorTheem,
                          ),
                          child: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: TextFieldCustom(
                              controller: bloc.controllerDate,
                              enabled: false,
                              hintText: "Chọn ngày sinh",
                              margin: EdgeInsets.only(
                                top: size.width / 40,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.width / 20,
                    ),
                    child: BaseTextCustom().setText(
                      text: Constant.roles.toUpperCase(),
                      minFontSize: 12,
                      maxFontSize: 14,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                    ),
                  ),
                  StreamBuilder(
                      stream: bloc.streamRoles,
                      builder: (context, snapshot) {
                        String data = snapshot.hasData ? snapshot.data : "ROLE_USER";
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                activeColor: ColorCustom.colorTheem,
                                groupValue: data,
                                title: Text('USER'),
                                value: "ROLE_USER",
                                onChanged: (val) {
                                  bloc.isCheckRadioButton(val);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                activeColor: ColorCustom.colorTheem,
                                groupValue: data,
                                title: Text('ADMIN'),
                                value: 'ROLE_ADMIN',
                                onChanged: (val) {
                                  bloc.isCheckRadioButton(val);
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
              SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      ButtonCustom(
                        title: widget.isCheck == false ? Constant.updateEm.toUpperCase() : Constant.addEm.toUpperCase(),
                        margin: EdgeInsets.only(
                          top: size.width / 20,
                        ),
                        onClick: () async {
                          DialogLoading.showLoading(context);

                          if (widget.isCheck == false) {
                            await bloc.editUser(userModel: widget.dataModel).then((value){
                              if(value != null){
                                Navigator.pop(context, true);

                              }
                            });
                          } else {
                            await bloc.createUser().then((value) {
                              if(value == true){
                                Navigator.pop(context, true);

                              }
                            });
                          }
                          DialogLoading.hiddenLoading(context);

                        },
                      ),
                      widget.isCheck == false
                          ? ButtonCustom(
                              title: Constant.deleteEm.toUpperCase(),
                              color: ColorCustom.RED,
                              margin: EdgeInsets.only(top: size.width / 50, bottom: 50),
                              onClick: () async {
                                DialogLoading.showLoading(context);

                                await bloc.deleteUser(id: widget.dataModel.id).then((value) => value == true
                                    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        backgroundColor: ColorCustom.RED,
                                        content: Text("Xoá thành công tài khoản: ${widget.dataModel.name}"),
                                      ))
                                    : SizedBox());
                                DialogLoading.hiddenLoading(context);

                                Navigator.pop(context, true);
                              },
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked =
        await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectedDate = picked;
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    bloc.controllerDate.text = formattedDate;
  }
}
