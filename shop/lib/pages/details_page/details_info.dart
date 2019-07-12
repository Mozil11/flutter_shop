import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';
// import '../../provide/details_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsInfo extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.all(10),
      child: Text(
        '说明：极速送达',
        style: TextStyle(
          color: Colors.pink,
          fontSize: ScreenUtil().setSp(20)
        ),
      ),
    );
  }
}