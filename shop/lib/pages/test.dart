import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/http_header.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有请求数据';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('请求远程数据'),),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('请求'),
                onPressed: _geek,
              ),
              Text(showText)
            ],
          ),
        ),
      ),
    );
  }
  void _geek(){
    print('start');
    getHttp().then((val){
      setState(() {
        showText = val['data'].toString();
      });
    });
  }


  //伪造请求头获取数据
  Future getHttp() async{
    try{
      Response response;
      Dio dio = Dio();
      dio.options.headers = httpHeaders;
      response = await dio.get('https://time.geekbang.org/serv/v1/column/topList');
      print(response);
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}