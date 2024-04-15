import 'package:flutter/material.dart';
import 'package:ingilizcecalisma/h%C4%B1zl%C4%B1/color.dart';

class ListeOlustur extends StatefulWidget {
  const ListeOlustur({super.key});

  @override
  State<ListeOlustur> createState() => _ListeOlusturState();
}

class _ListeOlusturState extends State<ListeOlustur> {
  final _listname = TextEditingController();

  List<TextEditingController> wordTextEditingList = [];
  List<Row> wordListField = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 10; ++i)
      wordTextEditingList.add(TextEditingController());

    for (int i = 0; i < 5; ++i) {
      debugPrint("====>" + (2 * 1).toString() + "   " + (2 * i + 1).toString());
      wordListField.add(
        Row(
          children: [
            Expanded(
                child: textFieldBuilder(
                    textEditingController: wordTextEditingList[2 * i])),
            Expanded(
                child: textFieldBuilder(
                    textEditingController: wordTextEditingList[2 * i + 1])),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.05,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Image.asset("assets/images/logo_text.png"),
            ),
            Container(
              alignment: Alignment.centerRight,
              height: MediaQuery.of(context).size.height * 0.03,
              child: Image.asset(
                "assets/images/logo.png",
                height: 30,
                width: 35,
              ), //
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              textFieldBuilder(
                  icon: const Icon(
                    Icons.list,
                    size: 18,
                  ),
                  hintText: "List Adı",
                  textEditingController: _listname,
                  textAlign: TextAlign.left),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "İngilizce",
                      style:
                          TextStyle(fontSize: 18, fontFamily: "RobotoMedium"),
                    ),
                    Text(
                      "Türkçe",
                      style:
                          TextStyle(fontSize: 18, fontFamily: "RobotoMedium"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: wordListField,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttons(addRow,Icons.add),
                  buttons(saveRow,Icons.save),
                  buttons(deleteRow,Icons.remove),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell buttons(Function() click,IconData icon,) {
    return InkWell(
      onTap: ()=>click(),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Color(Ok.HexaColorConverter("#DCD2FF")),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 28,
        ),
      ),
    );
  }

  void addRow(){

  }
  void saveRow(){

  }
  void deleteRow(){

  }


  Container textFieldBuilder(
      {int height = 40,
      @required TextEditingController? textEditingController,
      Icon? icon,
      String? hintText,
      TextAlign textAlign = TextAlign.center}) {
    return Container(
      height: height.toDouble(),
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.withOpacity(0.25),
      ),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
      child: TextField(
        keyboardType: TextInputType.name,
        maxLines: 1,
        textAlign: textAlign,
        controller: textEditingController,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "RobotoLight",
          decoration: TextDecoration.none,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hintText,
          fillColor: Colors.transparent,
          isDense: true,
        ),
      ),
    );
  }
}
