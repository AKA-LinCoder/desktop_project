import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:contextual_menu/contextual_menu.dart';

class ContextualMenuArea extends StatefulWidget {
  Widget child;
  ContextualMenuArea({super.key, required this.child});

  @override
  State<ContextualMenuArea> createState() => _ContextualMenuAreaState();
}

class _ContextualMenuAreaState extends State<ContextualMenuArea> {
  bool _shouldReact = false; //判断是否是右键
  Offset? _position;
  //自定义一个方法
  _handleClickPopUp() {
    Menu menu = Menu(
      items: [
        MenuItem(
          label: 'Copy',
          onClick: (_) {
            print('Clicked Copy');
          },
        ),
        MenuItem(
          label: 'Disabled item',
          disabled: true,
        ),
        MenuItem.separator(),
        MenuItem.submenu(
          label: 'Font',
          onClick: (e) {},
          submenu: Menu(
            items: [
              MenuItem(
                label: 'Item 3',
                onClick: (e) {
                  print("Item 3");
                },
                onHighlight: (e) {
                  print("Item 3 onHighlight");
                },
                onLoseHighlight: (e) {
                  print("Item 3 onLoseHighlight");
                },
                checked: false,
              ),
              MenuItem(
                label: 'Item 4',
                onClick: (e) {
                  print("Item 4");
                },
                onHighlight: (e) {
                  print("Item 4 onHighlight");
                },
                onLoseHighlight: (e) {
                  print("Item 4 onLoseHighlight");
                },
                checked: false,
              ),
              MenuItem(
                label: 'Item 5',
                onClick: (e) {
                  print("Item 5");
                },
                onHighlight: (e) {
                  print("Item 5 onHighlight");
                },
                onLoseHighlight: (e) {
                  print("Item 5 onLoseHighlight");
                },
                checked: false,
              ),
            ],
          ),
        ),
        MenuItem.checkbox(
          key: 'checkbox1',
          label: 'Checkbox1',
          checked: true,
          onClick: (menuItem) {
            print('Clicked Checkbox1');
            menuItem.checked = !(menuItem.checked == true);
          },
        ),
        MenuItem.separator(),
      ],
    );

    popUpContextualMenu(
      menu,
      position: _position,
      placement: Placement.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (event) {
          _shouldReact = event.kind == PointerDeviceKind.mouse &&
              event.buttons == kSecondaryMouseButton;
        },
        onPointerUp: (event) {
          if (!_shouldReact) return;
          //获取鼠标的位置
          _position = Offset(
            event.position.dx,
            event.position.dy,
          );

          _handleClickPopUp();
        },
        child: widget.child);
  }
}
