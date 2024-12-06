import 'package:flutter/cupertino.dart';

class ListMapProvider extends ChangeNotifier{
  List<Map<String, dynamic>> _mdata = [];

  void addData(Map<String, dynamic> data) {
    _mdata.add(data);
    notifyListeners();
  }

  void updateData(Map<String, dynamic> updatedData, int index) {
    _mdata[index] = updatedData;
    notifyListeners();
  }

  void deleteData(int index) {
    _mdata.removeAt(index);
    notifyListeners();
  }

  List<Map<String, dynamic>> getData() => _mdata;
}