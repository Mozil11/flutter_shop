import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';//ios样式
import "home_page.dart";
// import 'test.dart';
import 'member_page.dart';
import 'car_page.dart';
import 'category_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';//适配插件
import 'package:provide/provide.dart';
import '../provide/nav_provide.dart';


class IndexPage extends StatelessWidget {
  List<BottomNavigationBarItem> bottomTabs = [
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.home),
    title: Text('首页')
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.search),
    title: Text('分类')
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.shopping_cart),
    title: Text('购物车')
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.profile_circled),
    title: Text('会员中心')
  ),
];

//定义页面变量
List<Widget> tabPages=[   //indexedstack的children属性接受的是组件,所以用List<Widget> 定义
  HomePage(),
  CategoryPage(),
  CarPage(),
  MemberPage()
];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);//初始化设计尺寸

    return Provide<NavProvide> (
      builder: (context,child,val){
        int currentIndex = Provide.value<NavProvide>(context).currntIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,//多于三个有效果
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index){
              Provide.value<NavProvide>(context).changeNav(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabPages,
          ),
        );
      },
    );
  }
}



//底部导航要用动态组件
// class IndexPage extends StatefulWidget {
//   @override
//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {
// //声明list存放底部导航图标文字
// //<>里面表示数组里的对象的结构
// List<BottomNavigationBarItem> bottomTabs = [
//   BottomNavigationBarItem(
//     icon: Icon(CupertinoIcons.home),
//     title: Text('首页')
//   ),
//   BottomNavigationBarItem(
//     icon: Icon(CupertinoIcons.search),
//     title: Text('分类')
//   ),
//   BottomNavigationBarItem(
//     icon: Icon(CupertinoIcons.shopping_cart),
//     title: Text('购物车')
//   ),
//   BottomNavigationBarItem(
//     icon: Icon(CupertinoIcons.profile_circled),
//     title: Text('会员中心')
//   ),
// ];

// //定义页面变量
// List<Widget> tabPages=[   //indexedstack的children属性接受的是组件,所以用List<Widget> 定义
//   HomePage(),
//   CategoryPage(),
//   CarPage(),
//   MemberPage()
// ];
// //点击索引
// int myIndex = 0;
// var currentPage;

// //初始化 默认页面
// @override
//   void initState() {
//     currentPage = tabPages[myIndex];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //设置屏幕适配标准
//     ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);//初始化设计尺寸
//     print('设备的像素密度：${ScreenUtil.pixelRatio}');
//     print('设备的高：${ScreenUtil.screenHeight}');
//     print('设备的宽：${ScreenUtil.screenWidth}');
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,//多于三个有效果
//         currentIndex: myIndex,
//         items: bottomTabs,
//         onTap: (index){
//           setState(() {//改变状态或样式
//               myIndex = index;
//               currentPage = tabPages[myIndex];
//           });
//         },
//       ),
//       body: IndexedStack(
//         index: myIndex,
//         children: tabPages,
//       ),
//     );
//   }
// }