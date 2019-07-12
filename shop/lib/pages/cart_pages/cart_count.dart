import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cart_goods.dart';
import 'package:provide/provide.dart';
import '../../provide/cart_provide.dart';


class CartCount extends StatelessWidget {
  Cartgoods item;
  CartCount(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(165),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black12
          )
        ),
        child: Row(
          children: <Widget>[
            delButton(context,item),
            count(item),
            addButton(context,item)
          ],
        ),
    );
  }
//减
  Widget delButton(context,item){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).changecount(item,'-');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              color: Colors.black12
            )
          )
        ),
        child: Text('-'),
      ),
    );
  }
  //加
Widget addButton(context,item){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).changecount(item,'+');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              color: Colors.black12
            )
          )
        ),
        child: Text('+'),
      ),
    );
  }
  //数量显示
  Widget count(item){
    return Container(
      width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        color: Colors.white,
        child: Text('${item.count}'),
    );
  }
}