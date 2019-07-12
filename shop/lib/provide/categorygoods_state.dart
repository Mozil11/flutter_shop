import 'package:flutter/material.dart';
import '../model/category_goods_model.dart';


class CategoryGoodsDataList with ChangeNotifier{
  List<CategoryGoodsData> categoryGoodsDataList = [];  //要管理CategoryGoodsData的状态   就用CategoryGoodsData的泛类
  List<CategoryGoodsData> getmore = []; 
  getCategoryGoodsDataList(List list){
    categoryGoodsDataList = list;
    notifyListeners();
  }
  getmorelist(morelist){
    getmore.addAll(morelist);
    notifyListeners();
  }

}