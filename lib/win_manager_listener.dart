import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WinManagerListener extends StatefulWidget {
  Widget child;
  WinManagerListener({Key? key,required this.child}) : super(key: key);

  @override
  State<WinManagerListener> createState() => _WinManagerListenerState();
}

class _WinManagerListenerState extends State<WinManagerListener>  with WindowListener{
  @override
  void onWindowClose() async{
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      //ignore： use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title:const Text('确定退出?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: ()async {
                  Navigator.of(context).pop();
                  //退出
                  // await windowManager.destroy();
                  //隐藏到系统托盘
                  await windowManager.hide();
                },
              ),
            ],
          );
        },
      );
    }
  }


  //固定
  @override
  void initState() {
    //注册监听
    windowManager.addListener(this);
    _init();
    super.initState();
  }
//固定
  @override
  void dispose() {
    //删除监听
    windowManager.removeListener(this);
    super.dispose();
  }
//固定
  void _init() async {
    // 阻止默认关闭事件
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  widget.child;
  }
}
