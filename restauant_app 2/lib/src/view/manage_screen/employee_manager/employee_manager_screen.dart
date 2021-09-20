import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restauant_app/src/model/user_model.dart';
import 'package:restauant_app/src/model/user_model_v2.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_let.dart';
import 'package:restauant_app/src/utils/animation/push_screen_switch_right.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/item_empolyee.dart';
import 'package:restauant_app/src/view/manage_screen/employee_manager/employee_manager_bloc.dart';

import 'detail_employee_screen/detail_employee_screen.dart';

class EmployeeManagerScreen extends StatefulWidget {
  @override
  _EmployeeManagerScreenState createState() => _EmployeeManagerScreenState();
}

class _EmployeeManagerScreenState extends State<EmployeeManagerScreen> {
  EmployeeManagerBloc bloc = EmployeeManagerBloc();

  @override
  void initState() {
    super.initState();
    bloc.getListUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width,
          child: Container(
            margin: EdgeInsets.only(
              left: size.width / 25,
              right: size.width / 25,
              top: Adaptive.h(2),
            ),
            child: Column(
              children: [
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: Adaptive.sp(15), bottom: Adaptive.sp(15)),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: ColorCustom.GREY)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: size.width / 4,
                          alignment: Alignment.center,
                          child: Text(
                            "Tên",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )),
                      Container(
                        width: size.width / 4,
                        alignment: Alignment.center,
                        child: Text(
                          "Số điện thoại",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 4,
                        alignment: Alignment.center,
                        child: Text(
                          "Hoạt động",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10,top: 15),
                    child: StreamBuilder(
                        stream: bloc.streamListUser,
                        builder: (context, snapshot) {
                          List<UserModelV2> listData = [];
                          if (snapshot.hasData) {
                            listData = snapshot.data;
                            return ListView.builder(
                                itemCount: listData.length,
                                itemBuilder: (context, index) {
                                  UserModelV2 dataModel = listData[index];
                                  return ItemEmpolyee(
                                    name: dataModel.name ?? "null",
                                    phone: dataModel.phoneNumber ?? "null",
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PushScreenSwitchRight(enterPage:  DetailEmpolyeeScreen(
                                            isCheck: false,
                                            dataModel: dataModel,
                                          ),
                                        ),
                                      );
                                      bloc.getListUser();
                                    },
                                  );
                                });
                          } else {
                            return Container(
                              width: size.width,
                              height: size.height,
                              alignment: Alignment.center,
                              child: SpinKitWave(
                                color: ColorCustom.colorTheem,
                                size: 30.0,
                              ),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorCustom.colorTheem,
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [ColorCustom.colorTheem1, ColorCustom.colorTheem2])
          ),
        ),
        onPressed: () async {
          await Navigator.push(
              context,
              PushScreenSwitchRight(enterPage:  DetailEmpolyeeScreen(
                        isCheck: true,
                      )));
          bloc.getListUser();
        },
      ),
    );
  }
}
