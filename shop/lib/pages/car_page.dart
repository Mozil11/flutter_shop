import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/cart_provide.dart';
import './cart_pages/cart_item.dart';
import './cart_pages/cart_bottom.dart';
class CarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('购物车'),
          ),
          body: FutureBuilder(
            future: _getinfo(context),
            builder: (context,snapshot){
              if(snapshot.hasData){
                List cartlist = Provide.value<CartProvide>(context).cartlist;
                return Stack(
                  children: <Widget>[
                    Provide<CartProvide>(
                      builder: (context,child,val){
                        //每次构建重新获得carlist
                        cartlist = Provide.value<CartProvide>(context).cartlist;
                        return ListView.builder(
                            itemCount: cartlist.length,
                            itemBuilder: (context,index){
                              return Cartitem(cartlist[index]);
                            },
                        );
                      },
                    ),
                        
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: CartBottom(),
                    )
                  ],
                );
                
              }else{
                return Text('正在加载');
              }
            },
          ),
        );
  }
  Future<String> _getinfo(BuildContext context)async{
    await Provide.value<CartProvide>(context).getgoodsinfo();
    return 'end';
  }


}