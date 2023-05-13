import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  String? settingId;
   SettingPage({Key? key,this.settingId}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.settingId);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: const Center(
        child: Text("我i是Setting"),
      ),
    );
  }
}
