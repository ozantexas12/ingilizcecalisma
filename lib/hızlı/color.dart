class Ok implements HexaColorConvertColor {


  static int HexaColorConverter(String colorHexa) {
    return int.parse(colorHexa.replaceAll("#", "0xff"));
  }
}

class HexaColorConvertColor{
  static int  ?HexaColorConverter(String colorHexa){
    return null;
  }
}
