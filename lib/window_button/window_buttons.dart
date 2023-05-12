import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {

  final buttonColors = WindowButtonColors(
    iconNormal: Colors.grey[600], //普通颜色
    mouseOver: Colors.grey[400], //鼠标放上去
    mouseDown: Colors.grey[400], //鼠标按下
    iconMouseOver: Colors.grey[600], //鼠标移动到按钮图标时
    iconMouseDown: Colors.grey[600] //鼠标按下按钮图标时的颜色
  );


  maximizeOrRestore(){
    appWindow.maximizeOrRestore();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //当鼠标放上去的手型
         MouseRegion(
           cursor: SystemMouseCursors.click,
           child: MinimizeWindowButton(
             colors: buttonColors,
           ),
         ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: appWindow.isMaximized?
          RestoreWindowButton(
            colors: buttonColors,
            onPressed: maximizeOrRestore,
          ):
          MaximizeWindowButton(
            colors: buttonColors,
            onPressed: maximizeOrRestore,
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: CloseWindowButton(
            colors: buttonColors,
          ),
        )
      ],
    );
  }
}

