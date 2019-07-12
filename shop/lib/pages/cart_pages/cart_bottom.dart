import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart_provide.dart';
class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        color: Colors.white,
        child:Provide<CartProvide>(
          builder: (context,child,val){
            return
            Row(
              children: <Widget>[
                selectall(context),
                info(context),
                buy(context)
              ],
            );
          },
        )
    );
  }
  Widget selectall(context){
    bool allcheck = Provide.value<CartProvide>(context).allcheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: allcheck,
            activeColor: Colors.pink,
            onChanged: (v){
              Provide.value<CartProvide>(context).actionAll(v);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget info(context){
    double allprice = Provide.value<CartProvide>(context).allprice;
    return Container(
      width: ScreenUtil().setWidth(430),
      
      child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    width: ScreenUtil().setWidth(280),
                    child: Text('合计',style: TextStyle(fontSize: ScreenUtil().setSp(36)),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(150),
                    child: Text(
                      '￥${allprice}',
                      style:TextStyle(color: Colors.pink)
                      ),
                  )
                ],
              ),
              Container(
                width: ScreenUtil().setWidth(430),
                alignment: Alignment.centerRight,
                child: Text('满十元免配送',style: TextStyle(color: Colors.black38,fontSize: ScreenUtil().setSp(22)),),
              )
            ],
          ),
       
    );
  }
  Widget buy(context){
        int allcount = Provide.value<CartProvide>(context).allcount;

    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: (){},
        child: 
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text('结算(${allcount})',style:TextStyle(color: Colors.white)),
              ),
         
      ),
    );
  }
}