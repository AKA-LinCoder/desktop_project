import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:system_tray/system_tray.dart';


String getTrayImagePath(String imageName) {
  return Platform.isWindows ? 'assets/$imageName.ico' : 'assets/$imageName.png';
}

String getImagePath(String imageName) {
  return Platform.isWindows ? 'assets/$imageName.bmp' : 'assets/$imageName.png';
}


Future<void> initSystemTray() async {
  String path =
  Platform.isWindows ? 'assets/app_icon.ico' : 'assets/app_icon.png';

  //获取appWindow
  final AppWindow appWindow = AppWindow();
  final SystemTray systemTray = SystemTray();

  // 初始化配置
  await systemTray.initSystemTray(
    title: "系统托盘",
    iconPath: path,
  );

  //系统托盘的右键菜单
  final Menu menu = Menu();
  await menu.buildFrom([
    MenuItemLabel(label: 'Show', onClicked: (menuItem) => appWindow.show()),
    MenuItemLabel(label: 'Hide', onClicked: (menuItem) => appWindow.hide()),
    MenuSeparator(),
    SubMenu(
      label: "Test API",
      image: getImagePath('gift_icon'),
      children: [
        SubMenu(
          label: "setSystemTrayInfo",
          image: getImagePath('darts_icon'),
          children: [
            MenuItemLabel(
              label: 'setTitle',
              image: getImagePath('darts_icon'),
              onClicked: (menuItem) {
                //设置托盘标题,只有mac有效
                systemTray.setTitle("我是托盘标题");
              },
            ),
            MenuItemLabel(
              label: 'setImage',
              image: getImagePath('gift_icon'),
              onClicked: (menuItem) {

                String path = getTrayImagePath("darts_icon");
                //设置托盘图标
                systemTray.setImage(path);
              },
            ),
            MenuItemLabel(
              label: 'setToolTip',
              image: getImagePath('darts_icon'),
              onClicked: (menuItem) {
                //设置鼠标放上去的提示
                systemTray.setToolTip("setToolTip");
              },
            ),
            MenuItemLabel(
              label: 'getTitle',
              image: getImagePath('gift_icon'),
              onClicked: (menuItem) async {
                String title = await systemTray.getTitle();
                debugPrint("click 'getTitle' : $title");
              },
            ),
          ],
        ),
        MenuItemLabel(
            label: 'disabled Item',
            name: 'disableItem',
            image: getImagePath('gift_icon'),
            enabled: false),
      ],
    ),
    MenuSeparator(),
    MenuItemLabel(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
  ]);

  // 设置菜单
  await systemTray.setContextMenu(menu);

  // 监听事件
  systemTray.registerSystemTrayEventHandler((eventName) {
    debugPrint("eventName: $eventName");
    if (eventName == kSystemTrayEventClick) {
      Platform.isWindows ? appWindow.show() : systemTray.popUpContextMenu();
    } else if (eventName == kSystemTrayEventRightClick) {
      Platform.isWindows ? systemTray.popUpContextMenu() : appWindow.show();
    }
  });
}



