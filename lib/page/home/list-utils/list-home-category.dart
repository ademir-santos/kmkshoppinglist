import 'package:flutter/material.dart';

class HomeListCategoryPage extends StatefulWidget {

  final List<Map> shoppListCategory;

  HomeListCategoryPage({this.shoppListCategory}): super();

  @override
  HomeListCategoryPageState createState() => HomeListCategoryPageState();
}

class HomeListCategoryPageState extends State<HomeListCategoryPage> {

  @override
  Widget build(BuildContext context){
    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(230, 230, 230, 0.5),
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Pesquisar produto',
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                    onChanged: (text) {
                      setState(() {
                        //filterText = text;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}