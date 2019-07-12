import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsDataProvide>(
        builder: (context,child,val){
          var left = Provide.value<DetailsDataProvide>(context).isleft;
          var right = Provide.value<DetailsDataProvide>(context).isright;
          return Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              children: <Widget>[
                _mytabLeft(context,left),
                _mytabRight(context,right),

              ],
            ),
          );
        },
      
    );
  }
//左侧
  Widget _mytabLeft(BuildContext context,isleft){
    return InkWell(
      onTap: (){
          Provide.value<DetailsDataProvide>(context).changelr('left');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isleft?Colors.pink:Colors.black12
            )
          )
        ),
        child: Text('详情',
          style: TextStyle(
            color: isleft?Colors.pink:Colors.black
          ),
        ),
      ),
    );

  }
  //右侧
  Widget _mytabRight(BuildContext context,isright){
    return InkWell(
      onTap: (){
          Provide.value<DetailsDataProvide>(context).changelr('right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isright?Colors.pink:Colors.black12
            )
          )
        ),
        child: Text('评论',
          style: TextStyle(
            color: isright?Colors.pink:Colors.black
          ),
        ),
      ),
    );

  }
}