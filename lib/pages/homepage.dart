import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ingilizcecalisma/hızlı/color.dart';
import 'package:ingilizcecalisma/pages/listpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Lang { tr, eng }

class _HomePageState extends State<HomePage> {
  Lang? _chooseLang = Lang.eng;

  final GlobalKey<ScaffoldState> _scaffoldKey= GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: MediaQuery.of(context).size.width*0.5,
        color: Colors.white,
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
                height: MediaQuery.of(context).size.height * 0.05,
                child: InkWell(
                  onTap:(){
                    _scaffoldKey.currentState!.openDrawer();
                  } ,
                  child: const FaIcon(
                    FontAwesomeIcons.bars,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                child: Image.asset("assets/images/logo_text.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
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
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ListsPage(),));
                },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.8,
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
                  width: MediaQuery.of(context).size.width * 0.8,
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
