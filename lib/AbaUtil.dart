// ignore: file_names
import 'dart:convert';

class Aba{
  static String CH_A = "阿";
  static String CH_B = "巴";
  static String CH_DIV = " ";

  static Map<String , String> chMap = <String,String>{};

  static init(){
    chMap["xx"] = CH_A;
  }

  static bool isOnlyAba(String input){
    if(input.isEmpty){
      return false;
    }

    for(var i = 0 ; i < input.length ; i = i+1){
      var ch = input[i];
      if(ch != CH_A && ch != CH_B && ch != CH_DIV){
        return false;
      }
    }
    return true;
  }

  static String encode(String input){
    if(input.isEmpty){
      return "";
    }

    String result= "";
    for(var i = 0 ; i < input.length ; i = i+1){
      String ch = input[i];
      var encodeList = utf8.encode(ch);
      String chEncode = "";
      for (int byte in encodeList) {
        String byteBinary = byte.toRadixString(2).padLeft(8, '0');
        for(var j =0 ; j < byteBinary.length ;j++){
          String c = byteBinary[j];
          if(c == "0"){
            chEncode += CH_A;
          }else if(c== "1"){
            chEncode += CH_B;
          }
        }
      }
      result += chEncode;
      result += CH_DIV;
    }
    return result;
  }

  static String decode(String input){
    var abaList = <String>[];
    String subStr = "";
    for(var i = 0 ; i < input.length ; i = i+1){
      var ch = input[i];
      if(ch != CH_DIV){
        subStr += ch;
      }else{
        abaList.add(subStr);
        subStr ="";
      }
    }
    if(subStr.isNotEmpty){
      abaList.add(subStr);
    }

    String result = "";
    for(String str in abaList){
      List<String> binStrList = _convertAbaStrToBinaryStrList(str);
      List<int> byteList = [];
      for(String s in binStrList){
        int? numValue = int.tryParse(s, radix: 2);
        print("numValue = $numValue");
        byteList.add(numValue??0);
      }
      String chStr = utf8.decode(byteList);
      print("chStr = $chStr");
      result += chStr;
    }//end for each
    return result;
  }

  static List<String> _convertAbaStrToBinaryStrList(String abaStr){
    String retStr = "";
    List<String> list = <String>[];
    int count = 0;
    for(int i = 0 ; i < abaStr.length ; i++){
      String ch = abaStr[i];
      if(ch == CH_A){
        retStr += "0";
      }else if(ch == CH_B){
        retStr += "1";
      }
      count++;
      if(count >= 8){
        list.add(retStr);
        retStr = "";
        count = 0;
      }
    }//end for i

    if(retStr.isNotEmpty){
      list.add(retStr);
    }
    return list;
  }
}




