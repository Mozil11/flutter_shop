import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';//html插件
class Detailsweb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var goodsde = Provide.value<DetailsDataProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Provide<DetailsDataProvide>(
      builder: (context,child,val){
        var isleft =  Provide.value<DetailsDataProvide>(context).isleft;
        if(isleft){
          return Container(
            child: HtmlWidget(
                goodsde
              ),
          );
          
        }else{
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text('暂无评论'),
          );
        }

      },
    );
  }
}