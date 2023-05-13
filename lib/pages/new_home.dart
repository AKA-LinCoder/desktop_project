import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewHomePage extends StatefulWidget {
  Widget child;
  NewHomePage({Key? key,required this.child}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("NewHome"),
      ),
      body:Row(
        children: [
          Container(
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              border: Border(
                right: BorderSide(width: 1,color: Colors.black)
              )
            ),
            child: ListView(
              children: [
                ListTile(title: Text("文档"),
                onTap: (){
                  //替换路由
                  context.goNamed("document");
                },),
                ListTile(title: Text("设置"),
                  onTap: (){
                    context.goNamed("setting",queryParameters: {"settingId":"456"});
                  },),
                ListTile(title: Text("用户"),
                  onTap: (){
                    context.goNamed("user",pathParameters: {"uid":"123"});
                  },),
              ],
            ),
          ),
          Expanded(child: Container(
            height: double.infinity,
            color: Colors.red,
            child: widget.child,
          )),
        ],
      ),
    );
  }
}
