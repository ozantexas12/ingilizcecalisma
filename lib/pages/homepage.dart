import 'package:flutter/material.dart';
import 'package:ingilizcecalisma/hızlı/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Lang { tr, eng }

class _HomePageState extends State<HomePage> {
  Lang? _chooseLang = Lang.eng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Icon(
                  Icons.drag_handle,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Image.asset("assets/images/logo_text.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ],
          ),
        ),
      ),
      body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                langRadioButton(
                    titleWidget: const Text("Türkçe"),
                    value: Lang.tr,
                    group: _chooseLang),
                langRadioButton(
                    titleWidget: const Text("İngilizce"),
                    value: Lang.eng,
                    group: _chooseLang),
                const SizedBox(height:20,),
                Container(
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
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: "Carter"),
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
          )),
    );
  }

  Container karttikla(BuildContext context,
      {String? startColor, String? endColor, String? title,String? Icon}) {
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
                fontSize: 25, color: Colors.white, fontFamily: "Carter"),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  SizedBox langRadioButton({
    required Widget? titleWidget,
    required Lang value,
    required Lang? group,
  }) {
    return SizedBox(
      width: 155,
      child: ListTile(
        title: titleWidget,
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
