import 'package:flutter/material.dart';
import '../model/category_model.dart';


class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];  //BxMallSubDto是数据模型category_model里的子类
  int childindex = 0;//右侧子类导航高亮索引
  String myid = '4';//大类默认id
  String childId = '';//子类ID
  int page = 1;//上拉加载页数
  String nomoretext = '';//加载没有更多数据的文字

  //改变大类
  getChildCategoryList(List list,id){
    page=1;
    myid = id;//点击大类获取id
    childindex = 0;//点击大类索引变为0
    childCategoryList = list;
    notifyListeners();
  }
  //改变子类
  changechild(index,id){
    childindex = index;
    childId = id;
    notifyListeners();
  }
  //z增加page
  addpage(){
    page++;
  }
  //文字赋值
  noMoretext(text){
    nomoretext = text;
     notifyListeners();
  }

}