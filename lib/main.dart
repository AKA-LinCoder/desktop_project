import 'dart:io';

import 'package:desktop_project/tray.dart';
import 'package:desktop_project/win_manager_listener.dart';
import 'package:desktop_project/window_button/window_buttons.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //初始化系统托盘
  await initSystemTray();

  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false, //是否状态栏显示
    titleBarStyle: TitleBarStyle.hidden, //隐藏导航栏，不需要去改原生代码
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
  //设置窗口大小
  // doWhenWindowReady(() {
  //   const initialSize = Size(600, 450);
  //   appWindow.minSize = initialSize;
  //   appWindow.size = initialSize;
  //   appWindow.alignment = Alignment.center;
  //   appWindow.show();
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WinManagerListener(child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        ///自定义拖拽
        // title: WindowTitleBarBox(child: MoveWindow(),),
        title: const DragToMoveArea(
          child: SizedBox(
            height: 40,
            width: double.infinity,
          ),
        ),
        actions:  [
          ///只有在window起作用，macOS不能自定义按钮，只能自定义拖拽
          if(Platform.isWindows==true) const WindowButtons()
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '123',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
