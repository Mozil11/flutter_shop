import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsDataProvide>(
        builder: (context,child,val){
          
          var goodsinfo = Provide.value<DetailsDataProvide>(context).goodsInfo.data.goodInfo;
          if(Provide.value<DetailsDataProvide>(context).goodsInfo !=null){
            return Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _getImage(goodsinfo.image1),
                  _getname(goodsinfo.goodsName),
                  _getgoodsnumber(goodsinfo.goodsSerialNumber)
                ],
              ),
            );
          }else{
            return Text('正在加载');
          }
        },
    );
  }
  //商品图片
  Widget _getImage(src){
    return Image.network(
      src,
      width: ScreenUtil().setWidth(740),
    );
  }
  //商品名称
  Widget _getname(name){
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }
  //商品编号
  Widget _getgoodsnumber(number){
    return Container(
      width: ScreenUtil().setWidth(740),
      child: Text(
        '编号：${number}',
        style: TextStyle(
          color: Colors.black12 
        ),

      ),
    );
  }

}