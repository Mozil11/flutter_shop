import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';//可是使用decode
import 'package:flutter_screenutil/flutter_screenutil.dart';//适配插件
import 'package:url_launcher/url_launcher.dart';//拨打电话
import 'package:flutter_easyrefresh/easy_refresh.dart';//上拉下拉加载
import '../router/application.dart';//引入路由静态资源

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{//混入保持页面状态  三个条件(1.混入AutomaticKeepAliveClientMixin   2.index_page页面使用indexedstack组件  3.homepage是动态组件)

@override

get wantKeepAlive => true;


GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();//自定义上拉加载的固定key

GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();//自定义下拉刷新key
  String homePageContent = '正在获取数据';
  // 初始化数据
  @override
  void initState() {
    request('homePageContent',formData:{'lon':'115.02932','lat':'35.76189'}).then((val){//formData为可选要加上formData：。。。。
      setState(() {
        homePageContent = val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('百姓生活家'),),

      body: 
      FutureBuilder(//异步加载页面
        future: request('homePageContent',formData:{'lon':'115.02932','lat':'35.76189'}),//调用后台接口获取数据

        builder: (context,snapshot){
          if(snapshot.hasData){//判断数据是否存在
            var data = jsonDecode(snapshot.data.toString());
            //传递给轮播组件是一个list 定义一个数组swiper，
            List<Map> swiper = (data['data']['slides'] as List).cast();
            //顶部菜单数组
            List<Map> navList = (data['data']['category'] as List).cast();
            //banner数据
            String pic = data['data']['ad'];
            //电话图片,电话
            String phonepic = data['data'];
            String phonenumber = data['data'];
            //商品推荐
            List<Map> showshoplist = (data['data']['category'] as List).cast();

            String pic_url = data['data']['ad'];
            List<Map> floorcontentlist = (data['data']['category'] as List).cast();

            return Column(//
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper,),//传入swiper
                TopNavigator(navigatorList: navList,),
                  CallPhone(phone: phonenumber,phonePic: phonepic,),
                  ShowThing(shopList: showshoplist,),
                   FloorTitle(pic_url: pic_url,),
                FloorContent(floorcontentlist: floorcontentlist,)
              ],
            );
          }else{
             List<Map> swiper = [
               {'image':'http://pic33.nipic.com/20130924/9822353_015119969000_2.jpg'},
               {'image':'http://n.sinaimg.cn/sports/20161220/H4Uw-fxytqax6757480.jpg'},
               {'image':'http://hbimg.b0.upaiyun.com/6f4132940988c009ed5b02af106830626fb7ccc8dc8b-WIrvkD_fw658'},
             ];
             List<Map> navList = [
               {
                 'image':'images/bing.png',
                 'shopname':'饼干'
               },
               {
                 'image':'images/bi.png',
                 'shopname':'碧根果'
               },
               {
                 'image':'images/bu.png',
                 'shopname':'布丁'
               },
               {
                 'image':'images/cao.png',
                 'shopname':'草莓'
               },
               {
                 'image':'images/tian.png',
                 'shopname':'甜甜圈'
               },
               {
                 'image':'images/niu.png',
                 'shopname':'牛油果'
               }
             ];
             //商品展示
             List<Map> showshoplist = [
               {
                 'image':'http://pic22.nipic.com/20120622/10305018_153841644160_2.jpg',
                 'malprice':10,
                 'price':20

               },
               {
                 'image':'http://pic31.nipic.com/20130705/3743087_010045945368_2.jpg',
                 'malprice':30,
                 'price':40

               },
               {
                 'image':'http://pic24.nipic.com/20121023/6792599_172305759102_2.jpg',
                 'malprice':50,
                 'price':60

               },{
                 'image':'http://pic41.nipic.com/20140512/8709082_121845132000_2.jpg',
                 'malprice':40,
                 'price':50

               },{
                 'image':'http://pic45.nipic.com/20140804/15196511_171944400000_2.jpg',
                 'malprice':110,
                 'price':220

               }
             ];
              //banner数据
            String pic = 'http://pic37.nipic.com/20140115/7430301_100825571157_2.jpg';
             //电话图片
            String phonepic = 'http://pic31.nipic.com/20130705/9527735_231540074000_2.jpg';
             String phonenumber = '13820019666';
             //楼层商品数据
             List<Map> floorcontentlist = [
               {
                 'image':'http://pic39.nipic.com/20140319/10944729_103257651139_2.jpg'
               },
               {
                 'image':'http://img4.cache.netease.com/photo/0001/2006-07-14/2M0RCN0D00J60001.jpg'
               },
               {
                 'image':'http://pic26.nipic.com/20121219/2457331_085744965000_2.jpg'
               },
               {
                 'image':'http://pic15.nipic.com/20110709/5252423_124720792532_2.jpg'
               },
               {
                 'image':'http://img.9ku.com/geshoutuji/singertuji/7/7183/7183_7.jpg'
               },
             ];
             String pic_url = 'http://pic41.nipic.com/20140513/9179121_111522012377_2.jpg';
            return EasyRefresh(//上拉加载下拉刷新组件   child必须是listview或ScrollView
              
              refreshFooter: ClassicsFooter(//自定义footer
              key: _footerKey,
                bgColor: Colors.pink,
                textColor: Colors.white,
                moreInfoColor: Colors.white,//加载更多字体颜色
                showMore: true,//s显示更多
                noMoreText: '加载完成',
                moreInfo: '加载更多',
                loadReadyText: '上拉加载',
                
                loadingText: '加载中...',
                
              ),
              refreshHeader: ClassicsHeader(
                key: _headerKey,
                bgColor: Colors.pink,
                textColor: Colors.white,
                moreInfoColor: Colors.white,
                moreInfo: '刷新',
                refreshReadyText: '下拉刷新',
                refreshedText: '刷新完成',
                refreshingText: '正在刷新...',
                showMore: true,
                
                
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiper,),//传入swiper
                  TopNavigator(navigatorList: navList,),
                  AdBanner(pic: pic,),
                  CallPhone(phone: phonenumber,phonePic: phonepic,),
                  ShowThing(shopList: showshoplist,),
                  FloorTitle(pic_url: pic_url,),
                  FloorContent(floorcontentlist: floorcontentlist,)
                ],
              ),
              loadMore: () async{  //上拉加载
                print('加载中');
              },
              onRefresh:() async{//下拉刷新
                print('刷新');
              }
            );
            
          }
        },
      ),
      
    );
  }
}


//首页轮播组件

class SwiperDiy extends StatelessWidget {
  List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList});//定义构造函数和参数
  @override
  Widget build(BuildContext context) {



    


    return Container(

      //使用ScreenUtil
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network('${swiperDataList[index]['image']}',fit: BoxFit.cover,);//从网络获取图片
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),//是否有下方的点
        autoplay: true,
      ),
    );
  }
}



//顶部导航菜单组件
class TopNavigator extends StatelessWidget {
  List navigatorList;
  TopNavigator({Key key,this.navigatorList});

  //返回一个部件
  Widget _gridViewItemUi(BuildContext context,item){
    return InkWell(
      onTap: (){
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[

          // Image.network(item['image'],width: ScreenUtil().setWidth(95),),
          Image.asset(item['image'],width: ScreenUtil().setWidth(90),),
          Text(item['shopname'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),//禁止滚动
        crossAxisCount: 3,//设置每行多少个
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){//遍历navigatorList数组。调用_gridViewItemUi方法返回组件，最后tolist组成数组
          return _gridViewItemUi(context, item);
        }).toList(),
      ),
    );
  }
}



//广告
class AdBanner extends StatelessWidget {
  String pic;
  AdBanner({Key key,this.pic});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Image.network(pic),
        onTap: (){
          Application.router.navigateTo(context, '/detail?id=1');
        },
      ),
      
    );
  }
}



//拨打电话
class CallPhone extends StatelessWidget {
  String phone;
  String phonePic;
  CallPhone({Key key,this.phone,this.phonePic});

  


  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _call,
        child:  Image.network(phonePic),
      ),
      
    );
  }


  //利用url_launcher插件拨打电话,定义一个内部方法
  void _call() async{

    String numb = 'http://baidu.com';
    // String numb = 'tel:13682027255';
    print(numb);
    print(canLaunch(numb).toString());
    if(await canLaunch(numb)){//canLaunch判断定义的numb值是否有效
      await launch(numb);
    }else{
      throw '不能访问';
    }
  }

}


//精品展示
class ShowThing extends StatelessWidget {
  List shopList;
  ShowThing({Key key,this.shopList});
//标题方法
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0,5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12),
          ),
      ),
      child: Text('商品推荐',style: TextStyle(color: Colors.pink),),
    );
  }
//商品
Widget _item(context,index){
  return InkWell(
    onTap: (){
        Application.router.navigateTo(context, '/detail?id=${index}');
    },
    child: Container(
      height: ScreenUtil().setHeight(330),
      width: ScreenUtil().setWidth(250),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(width: 0.5,color: Colors.black12)
        ),
      ),
      child: Column(
        children: <Widget>[
          Image.network(shopList[index]['image']),
          Text('￥${shopList[index]['malprice']}'),
          Text('￥${shopList[index]['price']}',style: TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough
          ),)
        ],
      ),
    ),
  );
}


//商品横向排列列表
Widget _itemList(context){
  return Container(
    height: ScreenUtil().setHeight(330),
    
    child: ListView.builder(//动态排列列表用ListView.builder
      scrollDirection: Axis.horizontal,//scrollDirection设置方向
      itemCount: shopList.length,//设置个数
      itemBuilder: (context,index){
        return _item(context,index);
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _itemList(context)
        ],
      ),
    );
  }
}


//楼层标题
class FloorTitle extends StatelessWidget {
  String pic_url;

  FloorTitle({Key key,this.pic_url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pic_url),
    );
  }
}
//楼层商品
class FloorContent extends StatelessWidget {
  List floorcontentlist;
  FloorContent({Key key,this.floorcontentlist});


  Widget _getFloorItem(Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){   
},
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _getFloorItem(floorcontentlist[0]),
        Column(
          children: <Widget>[
            _getFloorItem(floorcontentlist[1]),
            _getFloorItem(floorcontentlist[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(){
    return Row(
      children: <Widget>[
        _getFloorItem(floorcontentlist[3]),
        _getFloorItem(floorcontentlist[4]),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
    );
  }
}


//上拉加载

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  var page = 1;
  List hotGoodsList;

@override
  void initState() {

    super.initState();
    request('homePageBable',formData:1).then((val){
      var data = json.decode(val.toString());
     
       hotGoodsList = (data['data'] as List).cast();
    });
  }

void _getNewGoods(){
  var formData = {'page':page};
  request('homePageBable',formData:page).then((val){
    var data = json.decode(val.toString());
    var newList = (data['data'] as List).cast();
    setState(() {
      hotGoodsList.addAll(newList);
      page++;
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

