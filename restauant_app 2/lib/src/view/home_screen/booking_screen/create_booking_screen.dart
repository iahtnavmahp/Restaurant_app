import 'package:restauant_app/src/model/tables_model.dart';
import 'package:restauant_app/src/utils/base/base_import.dart';
import 'package:restauant_app/src/utils/component/button_custom.dart';
import 'package:restauant_app/src/utils/component/text_field_custom.dart';

import 'create_booking_bloc.dart';

class CreateBookingScreen extends StatefulWidget {
  CreateBookingScreen({this.dataModel});

  final TablesModel dataModel;

  @override
  _CreateBookingScreenState createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  CreateBookingBloc bloc = CreateBookingBloc();

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
        title: Text(
          "${Constant.titleApp}",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: ColorCustom.colorTheem,
        flexibleSpace: gradientCustom(),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: size.width / 15,
          right: size.width / 15,
          top: size.width / 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: size.width / 20,
                    ),
                    child: BaseTextCustom().setText(
                      text: Constant.customerName.toUpperCase(),
                      minFontSize: 12,
                      maxFontSize: 14,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                    ),
                  ),
                  StreamBuilder(
                      stream: bloc.streamName,
                      builder: (context, snapshot) {
                        return TextFieldCustom(
                          controller: bloc.controllerCustomerName,
                          error: snapshot.data,
                          margin: EdgeInsets.only(
                            top: size.width / 40,
                          ),
                        );
                      }),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.width / 20,
                    ),
                    child: BaseTextCustom().setText(
                      text: Constant.customerPhone.toUpperCase(),
                      minFontSize: 12,
                      maxFontSize: 14,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                    ),
                  ),
                  StreamBuilder(
                      stream: bloc.streamPhone,
                      builder: (context, snapshot) {
                        return TextFieldCustom(
                          controller: bloc.controllerPhone,
                          error: snapshot.data,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          margin: EdgeInsets.only(
                            top: size.width / 40,
                          ),
                        );
                      }),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.width / 20,
                    ),
                    child: BaseTextCustom().setText(
                      text: Constant.amountOfPeople.toUpperCase(),
                      minFontSize: 12,
                      maxFontSize: 14,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                    ),
                  ),
                  StreamBuilder(
                      stream: bloc.streamAmountOfPeople,
                      builder: (context, snapshot) {
                        return TextFieldCustom(
                          controller: bloc.controllerAmountOfPeople,
                          error: snapshot.data,
                          keyboardType: TextInputType.number,
                          margin: EdgeInsets.only(
                            top: size.width / 40,
                          ),
                        );
                      }),
                  Container(
                    margin: EdgeInsets.only(
                      top: size.width / 20,
                    ),
                    child: BaseTextCustom().setText(
                      text: Constant.note.toUpperCase(),
                      minFontSize: 12,
                      maxFontSize: 14,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: ColorCustom.BLACK),
                    ),
                  ),
                  TextFieldCustom(
                    controller: bloc.controllerNote,
                    margin: EdgeInsets.only(
                      top: size.width / 40,
                    ),
                  ),
                ],
              ),
              SafeArea(
                child: ButtonCustom(
                  title: Constant.config.toUpperCase(),
                  margin: EdgeInsets.only(
                    top: size.width / 10,
                    bottom: size.width / 30,
                  ),
                  onClick: () async {
                    if (bloc.isCheckForm(seating: widget.dataModel.seating)) {
                      await bloc.createBooking(context: context, dataModel: widget.dataModel);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
