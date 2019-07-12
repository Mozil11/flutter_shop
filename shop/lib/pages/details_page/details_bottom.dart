import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/cart_provide.dart';
import '../../provide/nav_provide.dart';

class DetailsBottom extends StatelessWidget {



  @override
  Widget build(BuildContext context) {


  //获取商品信息
  var goodsInfo = Provide.value<DetailsDataProvide>(context).goodsInfo.data.goodInfo;
  var goodsId = goodsInfo.goodsId;
  var goodsName = goodsInfo.goodsName;
  var count = 1;
  var price = goodsInfo.oriPrice;
  var images = goodsInfo.image1;


    return Container(
        width: ScreenUtil().setWidth(750),
        color: Colors.white,
        height: ScreenUtil().setHeight(80),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Provide.value<NavProvide>(context).changeNav(2);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(110),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 35,
                      color: Colors.pink,
                    ),
                  ),
                ),
                Provide<CartProvide>(
                  builder: (context,child,val){
                    int allcount = Provide.value<CartProvide>(context).allcount;
                    return Positioned(
                      top: 0,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          border: Border.all(width: 2,color: Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text('${allcount}',style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(20)),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            
            InkWell(
              onTap: ()async{
                await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
              },
              child: Container(
                width: ScreenUtil().setWidth(320),
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(80),
                color: Colors.green,
                child: Text('加入购物车',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28)
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: ()async{
                await Provide.value<CartProvide>(context).remove();
              },
              child: Container(
                width: ScreenUtil().setWidth(320),
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(80),
                color: Colors.pink,
                child: Text('购买',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28)
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}