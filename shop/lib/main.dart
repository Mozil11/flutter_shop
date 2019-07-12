import 'package:flutter/material.dart';
import 'pages/index_page.dart';
// import 'pages/home_page.dart';
import 'package:provide/provide.dart';//状态管理
import './provide/child_state.dart';//状态管理
import './provide/categorygoods_state.dart';//状态管理
import 'package:fluro/fluro.dart';//路由插件
import './router/main_routers.dart';//引入路由
import './router/application.dart';//引入静态配置
import './provide/details_provide.dart';
import './provide/cart_provide.dart';
import './provide/nav_provide.dart';

import 'package:flutter/services.dart';//极光推送
import 'package:jpush_flutter/jpush_flutter.dart';//极光推送

void main(){

  //状态管理变量
  var childCategory = ChildCategory();
  var categoryGoodsDataList = CategoryGoodsDataList();
  var detailsDataProvide = DetailsDataProvide();
  var cartProvide = CartProvide();
  var navProvide = NavProvide();
  var providers = Providers();
  providers
  ..provide(Provider<CategoryGoodsDataList>.value(categoryGoodsDataList))//注册
  ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<NavProvide>.value(navProvide))

  ..provide(Provider<ChildCategory>.value(childCategory))
  ..provide(Provider<DetailsDataProvide>.value(detailsDataProvide));

  



  runApp(ProviderNode(child: MyApp(),providers: providers,));




  }

// class MyApp extends StatelessWidget {

// //极光推送
//   String msg = 'unknow';
//   final JPush jpush = new JPush();

// //初始化推送
//   Future initPlatformState()async{
//     String platformVersion;//异常信息
//     try{
//       jpush.addEventHandler(
//         // 接收通知回调方法。
//         onReceiveNotification: (Map<String, dynamic> message) async {
//           print("》》》》》》》》》flutter 接收到信息: $message");
//         },
//       );
//     }on PlatformException{
//       platformVersion = '获取失败';
//     }
//     // 延时 3 秒后触发本地通知。
//     var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 3000);
//     var localNotification = LocalNotification(
//       id: 234,
//       title: 'notification title',
//       buildId: 1,
//       content: 'notification content',
//       fireTime: fireDate,
//       subtitle: 'notification subtitle', // 该参数只有在 iOS 有效
//       badge: 5, // 该参数只有在 iOS 有效
//       // extras: {"fa": "0"} // 设置 extras ，extras 需要是 Map<String, String>
//       );
//     jpush.sendLocalNotification(localNotification).then((res) {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     //定义一个路由
//   final router = Router();
//   //注册
//   Routes.congfigRoutes(router);
//   Application.router = router;

// initPlatformState();



//     return Container(
//       child: MaterialApp(
//         title: 'flutter 商城',
//         onGenerateRoute: Application.router.generator,//app中引入路由
//         debugShowCheckedModeBanner: false,//除去debug
//         theme: ThemeData(
//           primarySwatch: Colors.pink
//         ),
//         home: IndexPage(),
//       ),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //极光推送
  String msg = 'unknow';
  final JPush jpush = new JPush();
 @override
  void initState() {
    super.initState();
    initPlatformState();
  }
//初始化推送
  Future initPlatformState()async{
    String platformVersion;//异常信息
    try{
      jpush.addEventHandler(
        // 接收通知回调方法。
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("》》》》》》》》》flutter 接收到信息: $message");
          setState(() {
            msg = "flutter onReceiveNotification: $message";
          });
        },
      );
    }on PlatformException{
      platformVersion = '获取失败';
    }
     // 三秒后出发本地推送
    var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 3000);
    var localNotification = LocalNotification(
        id: 234,
        title: 'fadsfa',
        buildId: 1,
        content: 'fdas',
        fireTime: fireDate,
        subtitle: 'fasf',
        badge: 5,
        extras: {"fa": "0"}
      );
    jpush.sendLocalNotification(localNotification).then((res) {
      setState(() {
          msg = res;
        });
    }); 
    if (!mounted) return;

    
  }



  @override
  Widget build(BuildContext context) {
     //定义一个路由
  final router = Router();
//   //注册
  Routes.congfigRoutes(router);
  Application.router = router;

  
    return Container(
      child: MaterialApp(
        title: 'flutter 商城',
        onGenerateRoute: Application.router.generator,//app中引入路由
        debugShowCheckedModeBanner: false,//除去debug
        theme: ThemeData(
          primarySwatch: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}