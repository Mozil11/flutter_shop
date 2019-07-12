import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_provide.dart';
import './details_page/details_head.dart';
import './details_page/details_info.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_web.dart';
import './details_page/details_bottom.dart';
class DetailPage extends StatelessWidget {
  String goodid;
  DetailPage(this.goodid);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(//返回事件和图标
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细'),
      ),
      body: FutureBuilder(//异步加载
        future: _getgoods(context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Stack(
              children: <Widget>[

                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailHead(),
                      DetailsInfo(),
                      DetailsTab(),
                      Detailsweb()
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: DetailsBottom(),
                )
              ],
            );
            
          }else{
            return Container(child: Center(child: Text('加载中'),),);
          }
        },
      ),
    );
  }
  Future _getgoods(BuildContext context) async{
    await Provide.value<DetailsDataProvide>(context).getGoodsInfo(goodid);
    return 'wwwwwww';
  }


}