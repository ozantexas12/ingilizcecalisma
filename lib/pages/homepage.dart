import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ingilizcecalisma/hızlı/color.dart';
import 'package:ingilizcecalisma/pages/listpage.dart';
import 'package:package_info_plus/package_info_plus.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Lang { tr, eng }

class _HomePageState extends State<HomePage> {
  Lang? _chooseLang = Lang.eng;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PackageInfo ?packageInfo;
  String version="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packageInfoInit();
  }


  void packageInfoInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version=packageInfo!.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.5,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset("assets/images/logo.png", height: 80,),
                  const Text(
                    "Easy",
                    style: TextStyle(fontSize: 25, fontFamily: "RobotoRegular"),
                  ),
                  const Text(
                    "İstediğini öğren",
                    style: TextStyle(fontSize: 16, fontFamily: "RobotoRegular"),
                  ),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.30,
                    child: Divider(),
                  ),
                  Container(margin: EdgeInsets.only(top: 50, left: 8, right: 8),
                    child: const Text(
                      "Burası dolucak.",
                      style: TextStyle(
                          fontSize: 16, fontFamily: "RobotoRegular"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Tıkla",
                      style: TextStyle(fontSize: 16,
                          fontFamily: "RobotoRegular",
                          color: Color(Ok.HexaColorConverter("#0A588D"))),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "v"+version+"\ndeneme@gmail.com",
                  style: TextStyle(fontSize: 16,
                      fontFamily: "RobotoRegular",
                      color: Color(Ok.HexaColorConverter("#0A588D"))),
                  textAlign: TextAlign.center,
                ),
              ),

            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
                child: InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.bars,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.10,
                child: Image.asset("assets/images/logo_text.png"),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.15,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                langRadioButton(
                    text: "Türkçe-İngilizce",
                    value: Lang.tr,
                    group: _chooseLang),
                langRadioButton(
                    text: "İngilizce-Türkçe",
                    value: Lang.eng,
                    group: _chooseLang),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListsPage(),
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    height: 55,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(Ok.HexaColorConverter("#7D2046")),
                          Color(Ok.HexaColorConverter("#481175"))
                        ],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    child: const Text(
                      "Listelerim",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: "Carter"),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      karttikla(context,
                          startColor: "#1DAC20",
                          endColor: "#0C33B3",
                          title: "Kelime\nKartları"),
                      karttikla(context,
                          title: "Çoktan\nSeçmeli",
                          startColor: "#FF3340",
                          endColor: "#FF2356"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container karttikla(BuildContext context,
      {String? startColor, String? endColor, String? title}) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: 140,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(Ok.HexaColorConverter(startColor!)),
            Color(Ok.HexaColorConverter(endColor!))
          ],
          tileMode: TileMode.repeated,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title!,
            style: const TextStyle(
                fontSize: 28, color: Colors.white, fontFamily: "Carter"),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  SizedBox langRadioButton({
    required String? text,
    required Lang value,
    required Lang? group,
  }) {
    return SizedBox(
      width: 270,
      height: 60,
      child: ListTile(
        title: Text(
          text!,
          style: const TextStyle(fontFamily: "Carter", fontSize: 15),
        ),
        leading: Radio<Lang>(
          value: value,
          groupValue: group,
          onChanged: (Lang? value) {
            setState(() {
              _chooseLang = value;
            });
          },
        ),
      ),
    );
  }
}
