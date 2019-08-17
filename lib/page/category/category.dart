import 'package:flutter/material.dart';
import 'package:kmkshoppinglist/page/category/category-list.dart';
import 'package:kmkshoppinglist/page/layout-base/layout.dart';

class CategoryPage extends StatelessWidget {

  static final tag = 'category-page';

  @override
  Widget build(BuildContext context) {

    final content = CategoryListPage();

    return Layout.getContent(context, content, true, tag);
  }
}