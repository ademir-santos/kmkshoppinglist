import 'package:flutter/material.dart';

class SyncBodyPage extends StatelessWidget {

  final stateCode;
  final List<Map> map;
  SyncBodyPage({this.stateCode, this.map}) : super();

  @override
  Widget build(BuildContext context) {

    //Scaffold.of(context).showSnackBar(getSnackBarLoad(codeMessage200(), SynchronizeCategoryCircularProgress.tag));
    
    return SingleChildScrollView(
      
      child: Center(
        child: Container(
          height: 550,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/google_concluido_1.png"), fit: BoxFit.cover),
          ),
        ),
      ),
    );  
  }
}