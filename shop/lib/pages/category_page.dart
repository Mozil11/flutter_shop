import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/service_url.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/category_goods_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';//适配插件
import 'package:provide/provide.dart';//状态管理
import '../provide/child_state.dart';//状态管理
import '../provide/categorygoods_state.dart';//状态管理
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:toast/toast.dart';//提示插件


class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Row(
        children: <Widget>[
          Leftmenu(),
          Column(
            children: <Widget>[
              RightTopNav(),
              CategoryGoodsList()
            ],
          )

        ],
      ),
    );
  }
}


//左侧大类导航
class Leftmenu extends StatefulWidget {
  @override
  _LeftmenuState createState() => _LeftmenuState();
}

class _LeftmenuState extends State<Leftmenu> {
  List list = [];
  int currntIndex = 0;



  @override
  void initState() { 
    currntIndex = 0;
    _getCategory();
_getgoodslist();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _leftInkWell(index);
        },
      ),
    );
  }
  Widget _leftInkWell(int index){
    bool istap = false;
    istap = (currntIndex == index)?true:false;
    return InkWell(
      onTap: (){
        setState(() {
          currntIndex = index;
         
        });
          var childlist = list[index].bxMallSubDto;
          var id = list[index].mallCategoryId;
           _getgoodslist(id:id);
          Provide.value<ChildCategory>(context).getChildCategoryList(childlist,id);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0,top: 20.0),
        decoration: BoxDecoration(
          color: istap?Color.fromRGBO(236, 236, 236, 1.0):Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1
            )
          )
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }

void _getCategory() async{
  await request('categoryDate').then((val){
    var data = json.decode(val.toString());
    CategoryModel category = CategoryModel.fromJson(data);
    setState(() {
      list = category.data;
    });
    Provide.value<ChildCategory>(context).getChildCategoryList(list[0].bxMallSubDto,list[0].mallCategoryId);

    
  });
}

//
void _getgoodslist({id})async{
    var data = {
        'categoryId':id==null?'4':id,
        'categorySubId':'',
        'page':1
    };
    await request('categoryGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsModel goodslist = CategoryGoodsModel.fromJson(data);
      Provide.value<CategoryGoodsDataList>(context).getCategoryGoodsDataList(goodslist.data);
      
    });
  }

  
}
//右上导航
class RightTopNav extends StatefulWidget {
    @override
    _RightTopNavState createState() => _RightTopNavState();
  }
  
  class _RightTopNavState extends State<RightTopNav> {
    // List list = ['全部','名酒','宝丰'];
    @override
    Widget build(BuildContext context) {
      return Provide<ChildCategory>(
        builder: (context,child,childCategory){
          return Container(
        height: ScreenUtil().setHeight(65),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
          color: Colors.white,

        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: childCategory.childCategoryList.length,
          itemBuilder: (context,index){
            return _itemTap(index,childCategory.childCategoryList[index]);
          },
        ),
        
      );
        },
      );
      
      
    }

    //头部单个点击导航
    Widget _itemTap(index,BxMallSubDto item){
      bool isaction = false;
      isaction = (index==Provide.value<ChildCategory>(context).childindex)?true:false;
      return InkWell(
        onTap: (){
          _getgoodslist(item.mallSubId);
          Provide.value<ChildCategory>(context).changechild(index,item.mallSubId);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          child: Text(item.mallSubName,style: TextStyle(fontSize: ScreenUtil().setSp(28),color: isaction?Colors.pink:Colors.black),),
        ),
      );
      
    }
    void _getgoodslist(id)async{
        var data = {
            'categoryId':Provide.value<ChildCategory>(context).myid,
            'categorySubId':id,
            'page':1
        };
        await request('categoryGoods',formData: data).then((val){
          var data = json.decode(val.toString());
          CategoryGoodsModel goodslist = CategoryGoodsModel.fromJson(data);
          if(goodslist.data==null){
                      Provide.value<CategoryGoodsDataList>(context).getCategoryGoodsDataList([]);

          }else{

          Provide.value<CategoryGoodsDataList>(context).getCategoryGoodsDataList(goodslist.data);
          }
          
        });
      }
  }
//商品列表，可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // List list = [];
GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();//自定义上拉加载的固定key

@override
  


  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsDataList>(
      builder: (context,child,data){
        if(data.categoryGoodsDataList.length>0){

          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              
              child:EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.pink,
                  textColor: Colors.white,
                  moreInfoColor: Colors.white,//加载更多字体颜色
                  showMore: true,//s显示更多
                  noMoreText: Provide.value<ChildCategory>(context).nomoretext,
                  moreInfo: '加载更多',
                  loadReadyText: '上拉加载',
                  
                  loadingText: '加载中...',
                ),
                child: ListView.builder(
                  itemCount: data.categoryGoodsDataList.length,
                  itemBuilder: (context,index){
                    return _listItemWidget(data.categoryGoodsDataList,index);
                  },
                ),
                loadMore: (){
                  print('加载更多');
                 
                  _getgoodslist();
                },
              ),
              
            ),
          );
        }else{
          return Text('无商品');
        }
          
      },
    );
  }
  

  Widget _goodsImage(list,index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }
  Widget _goodsName(list,index){
    return Container(
      padding: EdgeInsets.only(left:5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines:2,
        overflow:TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }
  Widget _goodsPrice(list,index){
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text('价格：￥${list[index].presentPrice}',
            style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.pink),
          ),
          Text('￥${list[index].oriPrice}',style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),),
        ],
      ),
    );
  }
  Widget _listItemWidget(list,index){
    return InkWell(
      onTap: (){},
      child: 
      Container(
        padding: EdgeInsets.only(top:5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(list,index),
            Column(
              children: <Widget>[
                _goodsName(list,index),
                _goodsPrice(list,index)
              ],
            )
          ],
        ),
      ),
    );
  }
  void _getgoodslist()async{
               Toast.show("没有更多", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.pink,textColor: Colors.white,backgroundRadius: 5);
        var data = {
            'categoryId':Provide.value<ChildCategory>(context).myid,
            'categorySubId':Provide.value<ChildCategory>(context).childId,
            'page':Provide.value<ChildCategory>(context).page
        };
        await request('categoryGoods',formData: data).then((val){
          var data = json.decode(val.toString());
          CategoryGoodsModel goodslist = CategoryGoodsModel.fromJson(data);
          if(goodslist.data==null){
           
                      Provide.value<ChildCategory>(context).noMoretext('没有更多');

          }else{
             Provide.value<ChildCategory>(context).addpage();
          Provide.value<CategoryGoodsDataList>(context).getmorelist(goodslist.data);
          }
          
        });
      }
}