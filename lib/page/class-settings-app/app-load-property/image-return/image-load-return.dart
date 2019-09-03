import 'package:flutter/material.dart';

BoxDecoration returnImage(stateCode) {

  BoxDecoration imgUrl;

  switch (stateCode) {
    case 200:
      imgUrl = BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/google_concluido_1.png"), fit: BoxFit.cover));
      break;
    case 201:
      imgUrl = BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/google_concluido_1.png"), fit: BoxFit.cover));
      break;
    case 400:
      imgUrl = BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/400.png "), fit: BoxFit.cover));
      break;
    case 401:
      imgUrl = BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/401.png"), fit: BoxFit.cover));
      break;
    case 403:
      imgUrl = BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/403.png"), fit: BoxFit.cover));
      break;
    case 404:
      imgUrl = BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/404.png"), fit: BoxFit.cover));
      break;
    case 500:
      imgUrl = BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/500.png"), fit: BoxFit.cover));
      break;
    case 503:
      imgUrl = BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/503.png"), fit: BoxFit.cover));
      break;
    default:
  }

  return imgUrl;
}