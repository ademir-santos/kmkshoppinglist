
String url(typeUrl, link) {
  switch(typeUrl){
    case "Login":
      if(link == 1)
        return "http://192.168.25.20:5000/api/Login";
      else
        return "http://kmkconsultoria.ddns.net:64020/api/Login";
      break;
    case "Users":
      if(link == 1)
        return "http://192.168.25.20:5000/api/Users/";
      else
        return "http://kmkconsultoria.ddns.net:64020/api/Users/";
      break;
    case "Category":
      if(link == 1)
        return "http://192.168.25.20:5000/api/Category";
      else
        return "http://kmkconsultoria.ddns.net:64020/api/Category";
      break;
    case "Product":
      if(link == 1)
        return "http://192.168.25.20:5000/api/Product";
      else
        return "http://kmkconsultoria.ddns.net:64020/api/Product";
      break;
    case "TablePrice":
      if(link == 1)
        return "http://192.168.25.20:5000/api/TablePrice";
      else
        return "http://kmkconsultoria.ddns.net:64020/api/TablePrice";
      break;
    case "UserShopplist":
      if(link == 1)
        return "1http://192.168.25.20:5000/api/UserShopplist";
      else
        return "http://kmkconsultoria.ddns.net:64020/api/UserShopplist";
      break;
    case "ShopplistCategory":
      if(link == 1)  
        return "http://192.168.25.20:5000/api/ShopplistCategory";
      else
        return "http://kmkconsultoria.ddns.net:64020/api/ShopplistCategory";
      break;
    case "ShopplistCategoryProduct":
      if(link == 1)
        return "http://192.168.25.20:5000/api/ShopplistCategoryProduct";
      else
        return "http://kmkconsultoria.ddns.net:64020/api/ShopplistCategoryProduct";
      break;
  }

  return "Empty";
}

String contentType() {
  return "application/json";
}

String authorization(key) {
  return "Bearer " + key;
}
