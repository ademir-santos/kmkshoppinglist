
import 'package:flutter/material.dart';

class CategoryListPage extends StatefulWidget {

  static List<Widget> category = List<Widget>();

  @override
  CategoryListPageState createState() => CategoryListPageState();         
}

class CategoryListPageState extends State<CategoryListPage> {

  @override
  Widget build(BuildContext context){

    List<Widget> value = List<Widget>();

    if(CategoryListPage.category.length == 0){
      value.add(
        ListTile(
          leading: Icon(Icons.pages),
          title: Text('Nenhuma categoria cadastrada ainda...'),
        )
      );
    }

    return ListView (
      shrinkWrap: true,
      children: (CategoryListPage.category.length == 0)? value : CategoryListPage.category
    );
  }
}