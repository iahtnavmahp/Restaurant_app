import 'dart:async';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/all_order_model.dart';
import 'package:restauant_app/src/model/statistics_of_the_year_model.dart';

class ListInformationBloc {
  DataNetwork _dataNetwork = DataNetwork();

  StreamController _controllerGetAllOrder = StreamController();
  StreamController _controllerAnalysisOrder = StreamController();
  StreamController _controllerAnalysisDay = StreamController();

  Stream get streamGetAllOrder => _controllerGetAllOrder.stream;

  Stream get streamAnalysisOrder => _controllerAnalysisOrder.stream;

  Stream get streamAnalysisDay => _controllerAnalysisDay.stream;

  dispose() {
    _controllerGetAllOrder.close();
    _controllerAnalysisOrder.close();
    _controllerAnalysisDay.close();
  }

  List<double> listChart = [];
  List<DataPoint> listDataPoint = [];

  Future<List<AllOrderModel>> getAllOrders() async {
    List<AllOrderModel> listData = [];
    await _dataNetwork.getAllOrders(dataSuccess: (dataSuccess) {
      listData = dataSuccess;
      _controllerGetAllOrder.sink.add(listData);
      return;
    }, error: (error) {
      return;
    });

    return listData;
  }

  Future<List<StatisticsOfTheYearModel>> getAnalysisOrder() async {
    List<StatisticsOfTheYearModel> listData = [];
    await _dataNetwork.getAnalysisOrder(dataSuccess: (dataSuccess) {
      listData = dataSuccess;
      for (StatisticsOfTheYearModel item in dataSuccess){
        listChart.add(double.parse(item.month));
        listDataPoint.add(DataPoint(
          value: item.totalPrice,
          xAxis: double.parse(item.month)
        ));
      }
      _controllerAnalysisOrder.sink.add(listDataPoint);
      return;
    }, error: (error) {
      return;
    });

    return listData;
  }

  Future<List<StatisticsOfTheYearModel>> getAnalysisOrderByDay() async {
    List<StatisticsOfTheYearModel> listData = [];
    await _dataNetwork.getAnalysisOrderByDay(dataSuccess: (dataSuccess) {
      listData = dataSuccess;
      _controllerAnalysisDay.sink.add(dataSuccess);
      return;
    }, error: (error) {
      return;
    });

    return listData;
  }
}
