import 'package:flutter/material.dart';

import 'image-return/image-load-return.dart';

class SyncBodyPage extends StatelessWidget {

  final stateCode;
  final List<Map> map;
  SyncBodyPage({this.stateCode, this.map}) : super();

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      
      child: Center(
        child: Container(
          height: 550,
          decoration: returnImage(stateCode)
        ),
      ),
    );  
  }
}