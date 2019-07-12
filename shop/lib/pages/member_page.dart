import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _top()
        ],
      ),
    );
  }
  Widget _top(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pink,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(//圆形头像
              child: Image.network('http://b-ssl.duitang.com/uploads/item/201510/08/20151008192345_uPC5U.jpeg',
                width: 100,
              ),

            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('js',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Colors.black45),),
          )
        ],
      ),
    );
  }


}