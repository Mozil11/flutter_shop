import 'package:flutter/material.dart';


//定义provide类
class NavProvide with ChangeNotifier{
  int currntIndex= 0;
  changeNav(index){
    currntIndex = index;
    notifyListeners();
  }
}