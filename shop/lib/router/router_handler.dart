import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';//引入路由
import '../pages/details_page.dart';//要跳到详情 所以引入页面



//DetailPage详情页的路由配置
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,dynamic> params){
    String goodid = params['id'].first;//params传递的参数
    print('======${goodid}');
    return DetailPage(goodid);
  }
);