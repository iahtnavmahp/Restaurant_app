import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/view/manage_screen/manage_bloc.dart';
import 'package:restauant_app/src/view/splash_screen/splash_bloc.dart';

import 'employee_manager/employee_manager_screen.dart';
import 'get_booking_screen/get_booking_screen.dart';
import 'list_information_screen/list_information_screen.dart';

class ManageScreen extends StatefulWidget {
  @override
  ManageScreenState createState() => ManageScreenState();
}

class ManageScreenState extends State<ManageScreen> {
  ManageBloc bloc = ManageBloc();
  SplashBloc splashBloc = SplashBloc();
  final widgetOptions = [
    EmployeeManagerScreen(),
    // GetBookingScreen(),
    ListInformationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.streamIndex,
        builder: (context, snapshot) {
          int index = snapshot.hasData ? snapshot.data : 0;
          return Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              backgroundColor: ColorCustom.colorTheem,
              title: Text(Constant.manager),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      splashBloc.logOut(context: context);
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/icon/ic_logout.png",
                      color: ColorCustom.WHITE,
                      width: 17,
                    ),
                  ),
                ),
              ],
              flexibleSpace: gradientCustom(),

            ),
            body: Center(
              child: widgetOptions.elementAt(index),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.account_box), title: Text('Nhân viên')),
                // BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('Đặt bàn')),
                BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), title: Text('Thông kê')),
              ],
              currentIndex: bloc.selectedIndex,
              fixedColor: ColorCustom.colorTheem,
              unselectedItemColor: ColorCustom.GREY,
              onTap: onItemTapped,
              showUnselectedLabels: true,
              showSelectedLabels: true,
            ),
          );
        });
  }

  void onItemTapped(int index) {
    bloc.setIndexNavigation(index);
  }
}
