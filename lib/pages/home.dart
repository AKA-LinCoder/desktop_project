import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("home"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            // context.pushNamed("document");
            // GoRouter.of(context).pushNamed("user",pathParameters: {"uid":"123"});
            GoRouter.of(context).pushNamed("setting",queryParameters: {"settingId":"456"});

          }, child: Text('页面跳转')),
          const Center(
            child: Text("我i是home"),
          ),
        ],
      ),
    );
  }
}
