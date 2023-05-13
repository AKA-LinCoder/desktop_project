import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  String? uid;
   UserPage({Key? key,this.uid}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.uid);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      body: const Center(
        child: Text("我i是User"),
      ),
    );
  }
}
