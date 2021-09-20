import 'dart:async';

class ManageBloc{

  StreamController _controllerIndex = StreamController();

  Stream get streamIndex => _controllerIndex.stream;
  int selectedIndex = 0;
  void setIndexNavigation(int index) {
    selectedIndex = index;
    _controllerIndex.sink.add(selectedIndex);
  }

  dispose(){
    _controllerIndex.close();
  }
}