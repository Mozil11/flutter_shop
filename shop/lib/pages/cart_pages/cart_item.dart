import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart_provide.dart';
import '../../model/cart_goods.dart';
import './cart_count.dart';

class Cartitem extends StatelessWidget {
  final Cartgoods item;
  Cartitem(this.item);


  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
      margin: EdgeInsets.fromLTRB(5,2,5,2),
      padding: EdgeInsets.fromLTRB(5,10,5,10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        ),
      ),
      child: Row(
        children: <Widget>[
          _cartActionButton(context,item),
          _goodImage(item),
          _goodsName(item),
          _goodprice(context,item)
        ],
      ),
    );
  }
//选中按钮
  Widget _cartActionButton(context,item){
    return Container(
      child: Checkbox(
        value: item.isAction,
        activeColor: Colors.pink,
        onChanged: (val){
          item.isAction = val;
          Provide.value<CartProvide>(context).changeAction(item);
        },
      ),
    );
  }
  //商品图片
  Widget _goodImage(item){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }
//商品名称
Widget _goodsName(item){
  return Container(
    width: ScreenUtil().setWidth(300),
    padding: EdgeInsets.all(10),
    alignment: Alignment.topLeft,
    child: Column(
      children: <Widget>[
        Text(item.goodsName),
        CartCount(item)
      ],
    ),
  );
}

//商品价格
Widget _goodprice(context,item){
  return Container(
    width: ScreenUtil().setWidth(150),
    alignment: Alignment.centerRight,
    child: Column(
      children: <Widget>[
        Text('￥${item.price}'),
        Container(
          child: InkWell(
            child: Icon(Icons.delete,color: Colors.black26,size: 30,),
            onTap: (){
              Provide.value<CartProvide>(context).delgoods(item.goodsId);
            },
          ),
        )
      ],
    ),
  );
}


}