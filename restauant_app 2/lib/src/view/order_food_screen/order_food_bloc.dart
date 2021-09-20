import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restauant_app/src/data_network/data_network.dart';
import 'package:restauant_app/src/model/category_model.dart';
import 'package:restauant_app/src/model/detail_order_model.dart';
import 'package:restauant_app/src/model/food_model.dart';

class OrderFoodBloc {
  DataNetwork _dataNetwork = DataNetwork();
  TextEditingController searchController = TextEditingController();
  StreamController _controllerCategory = StreamController.broadcast();
  StreamController<int> _controllerChoice = StreamController();
  StreamController _controllerIndex = StreamController();
  StreamController _controllerAllFood = StreamController.broadcast();
  StreamController<List<List<FoodModel>>> _sViewTabBar = StreamController.broadcast();

  StreamController _controllerNumberFood = StreamController();
  StreamController _controllerPrice = StreamController();
  StreamController<bool> _controllerStatus = StreamController.broadcast();
  StreamController _getListSearch = StreamController.broadcast();
  StreamController _controllerNumber = StreamController.broadcast();
  StreamController<bool> _controllerStatusAnimated = StreamController.broadcast();

  Stream get streamListCategory => _controllerCategory.stream;

  Stream get sChoiceMenu => _controllerChoice.stream;

  Stream get sChoiceIndex => _controllerIndex.stream;

  Stream get streamListAllFood => _controllerAllFood.stream;

  Stream<List<List<FoodModel>>> get sViewTabBar => _sViewTabBar.stream;

  Stream get streamNumber => _controllerNumber.stream;

  Stream get streamNumberFood => _controllerNumberFood.stream;

  Stream get streamStatus => _controllerStatus.stream;

  Stream get streamPrice => _controllerPrice.stream;

  Stream get streamListSearch => _getListSearch.stream;

  Stream get streamStatusAnimated => _controllerStatusAnimated.stream;

  dispose() {
    _controllerCategory.close();
    _controllerChoice.close();
    _controllerIndex.close();
    _controllerAllFood.close();
    _controllerNumber.close();
    _controllerNumberFood.close();
    _controllerPrice.close();
    _controllerStatus.close();
    _controllerStatusAnimated.close();
    _getListSearch.close();
    _sViewTabBar.close();
  }

  int number = 0;
   int indexSelect = 0;
  List<FoodModel> listDataOrder = [];

  void setStatus({bool status}) => _controllerStatus.sink.add(status);

  setNumberFood({List<FoodModel> listDataOrder}) {
    int number = 0;
    for(FoodModel item in listDataOrder){
      number = number + item.quantity;

    }
    _controllerNumberFood.sink.add(number);
  }

  void isCheckTab(int index) => _controllerChoice.sink.add(index);

  void isCheckIndexTap(int index) => _controllerIndex.sink.add(index);

  void loadTabView(List<List<FoodModel>> list) => _sViewTabBar.sink.add(list);

  void statusView(bool status) => _controllerStatusAnimated.sink.add(status);

  Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> listTab = [];
    List<List<FoodModel>> listData = [];
    await _dataNetwork.getAllCategories(dataSuccess: (data) {
      listTab.addAll(data);
      listData = List.generate(listTab.length, (index) => <FoodModel>[]);

      for (int i = 0; i < listTab.length; i++)
        getFoodId(
          id: listTab[i].id,
        ).then((list) {
          listData[i] = list;
          loadTabView(listData);
        });

      _controllerCategory.sink.add(listTab);

      return;
    }, error: (err) {
      return;
    });
    return listTab;
  }

  setPrice() {
    double price = 0.0;
    for (var i = 0; i < listDataOrder.length; i++) {
      double totalPrice = listDataOrder[i].price * listDataOrder[i].quantity;
      price = price + totalPrice;
    }
    _controllerPrice.sink.add(price);
  }

  Future<List<FoodModel>> getAllFood() async {
    List<FoodModel> listFood = [];
    await _dataNetwork.getAllFood(dataSuccess: (dataSuccess) {
      listFood.addAll(dataSuccess);
      _controllerAllFood.sink.add(listFood);

      return;
    }, error: (err) {
      return;
    });
    return listFood;
  }

  getListSearch(List<FoodModel> list, String keySearch) {
    if (keySearch == null) {
      _getListSearch.sink.add(null);
      return;
    }
    List<FoodModel> listDataSearch = [];

    list.map(
      (data) {
        if (data.name.toLowerCase().contains(keySearch.toLowerCase())) {
          listDataSearch.add(data);
        }
      },
    ).toList();

    _getListSearch.sink.add(listDataSearch);
  }

  Future<List<FoodModel>> getFoodId({int id}) async {
    List<FoodModel> listFood = [];

    await _dataNetwork.getFoodId(
        id: id,
        dataSuccess: (dataSuccess) {
          listFood.addAll(dataSuccess);
          // _controllerFood.sink.add(listFood);

          return;
        },
        error: (err) {
          return;
        });

    return listFood;
  }



  void setNumber({String num}) {
    if (num == "1") {
      number++;
    } else {
      if (number > 0) {
        number--;
      }
    }
    _controllerNumber.sink.add(number);
  }
}
