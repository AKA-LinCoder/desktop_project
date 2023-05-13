import 'dart:convert';
import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:desktop_project/contextual_menu_utils.dart';
import 'package:desktop_project/mode.dart';
import 'package:desktop_project/tray.dart';
import 'package:desktop_project/win_manager_listener.dart';
import 'package:desktop_project/window_button/window_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/realm.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  //热加载时取消快捷键注册
  await hotKeyManager.unregisterAll();
  //配置本地通知
  await localNotifier.setup(appName: "app名称",
    //只对windows起作用
    shortcutPolicy: ShortcutPolicy.requireCreate
  );
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
      home: WinManagerListener(
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? base64Image;
  late Realm realm;

  @override
  void initState() {
    //配置连接数据库,如果修改了表里字段，则更新版本即可
    var config = Configuration.local([People.schema],schemaVersion: 2);
    realm = Realm(config);
    //插入数据库
    People p1 = People("tom", 12);
    realm.write((){
      realm.add(p1);
    });
    //读取数据
    //全部数据
    var res = realm.all<People>();
    for (var element in res) {
      print(element.name);
    }
    //根据条件读取数据
    var res1 = realm.all<People>().query("name='tom'");
    for (var element in res1) {
      print(element.age);
    }
    //修改数据
    //注意，修改的时候，没法修改条件，比如我搜索条件是名字是tom，我就不能修改名字
    realm.write((){
      res1[0].age = 200;
      // //删除满足条件的所有数据
      // realm.deleteMany(res1);
      // //删除一条数据
      // realm.delete(res1[0]);
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ContextualMenuArea(
      child: Scaffold(
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
          actions: [
            ///只有在window起作用，macOS不能自定义按钮，只能自定义拖拽
            if (Platform.isWindows == true) const WindowButtons()
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: ()async{
                  final url = Uri.parse("https://www.baidu.com");
                  if(await canLaunchUrl(url)){
                    await launchUrl(url);
                  }else{
                    print("无法打开");
                  }
                }, child: const Text("打开网页")),
                SizedBox(height: 40,),
                ElevatedButton(onPressed: ()async{
                  //windows下默认就有截图权限，但是mac下必须判断权限
                  bool allowed = await ScreenCapturer.instance.isAccessAllowed();
                  if(!allowed){
                    //申请权限
                     await ScreenCapturer.instance.requestAccess();
                  }

                  //配置图片保存路径
                  var dir = await getApplicationDocumentsDirectory();
                  String imageName = "Screenshot${DateTime.now().millisecondsSinceEpoch}.png";
                  String imagePath = "${dir.path}/screen_capturer/$imageName";
                  print(imagePath);
                  var capuuredData = await ScreenCapturer.instance.capture(
                    imagePath: imagePath,
                    mode: CaptureMode.region
                  );
                  print("截图完成${capuuredData?.imagePath}");
                  setState(() {
                      base64Image = capuuredData?.base64Image;
                  });
                }, child: Text("截图")),
                ElevatedButton(onPressed: (){
                  LocalNotification notic = LocalNotification(
                      title: "提示",body: "哈哈哈哈",
                    actions: [
                      LocalNotificationAction(text: "是"),
                      LocalNotificationAction(text: "否")
                    ]
                  );
                  notic.onClickAction = (text){
                    print("点击了$text");
                  };
                  notic.show();
                }, child: Text(
                  "本地通知"
                )),
                ElevatedButton(onPressed: ()async{
                  // ⌥ + Q
                  HotKey _hotKey = HotKey(
                    KeyCode.keyQ,
                    modifiers: [KeyModifier.alt],
                    // Set hotkey scope (default is HotKeyScope.system)
                    scope: HotKeyScope.inapp, // Set as inapp-wide hotkey.
                  );
                  await hotKeyManager.register(
                    _hotKey,
                    keyDownHandler: (hotKey) {
                      print('onKeyDown+${hotKey.toJson()}');
                    },
                    // Only works on macOS.
                    keyUpHandler: (hotKey){
                      print('onKeyUp+${hotKey.toJson()}');
                    } ,
                  );

                }, child: Text("注册快捷键")),
                ContextMenuArea(
                  width: 120,
                  child: Container(
                    width: 300,
                    height: 400,
                    color: Colors.red,
                    child: base64Image==null?Container():Image.memory(base64Decode(base64Image!)),
                  ),
                  builder: (context) {
                    return [
                      const ListTile(
                        title: Text('复制'),
                      ),
                      const ListTile(
                        title: Text('粘贴'),
                      )
                    ];
                  },
                ),
                InkWell(
                  onTap: ()async{
                    await FlutterClipboard.copy("我是复制出来的");
                  },
                  child: const Tooltip(
                    message: "惦记我进行复制",
                    child: Text("惦记我复制"),
                  ),
                ),
                //会和自定义右键菜单冲突，所以配置右键菜单应该避免全局配置
                const SelectableText("这段话是可以直接复制的"),
                ElevatedButton(onPressed: ()async{
                  await FlutterClipboard.copy("惦记我复制");
                }, child: const Text('惦记我复制')),
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
        ),
// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }


  //正常注册快捷键应该是一进来就注册initState
  @override
  void dispose() async{
    //取消注册
    await hotKeyManager.unregisterAll();
    // TODO: implement dispose
    super.dispose();
  }

}
