import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsDataProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;//定义一个DetailsModel模型的变量
  var isleft = true;
  var isright = false;
  //tabBar切换方法
  changelr(state){
    if(state=='left'){
      isleft= true;
      isright = false;
    }else{
      isleft= false;
      isright = true;
    }
     notifyListeners();
  }



  //从后台获取数据
  getGoodsInfo(String id) async{
    var formData = {
      'goodId':id
    };
    await request('details',formData:formData ).then((val){
      var data = json.decode(val.toString());
      print(data);
      goodsInfo = DetailsModel.fromJson(data);//使data变为DetailsModel对象
      notifyListeners();
    });
  }

}