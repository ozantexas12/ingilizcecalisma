import 'package:flutter/material.dart';
import 'package:ingilizcecalisma/database/models/list.dart';
import 'package:ingilizcecalisma/h%C4%B1zl%C4%B1/app_bar.dart';
import 'package:ingilizcecalisma/h%C4%B1zl%C4%B1/color.dart';
import 'package:ingilizcecalisma/database/db/database.dart';
import 'package:ingilizcecalisma/h%C4%B1zl%C4%B1/toast.dart';


import '../database/models/words.dart';

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
    super.initState();

    for (int i = 0; i < 10; ++i) {
      wordTextEditingList.add(TextEditingController());
    }

    for (int i = 0; i < 5; ++i) {
      debugPrint("====>${2 * 1}   ${2 * i + 1}");
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
      appBar: appBar(context,
          left: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
          center: Image.asset("assets/images/logo_text.png"),
          right: Image.asset(
            "assets/images/logo.png",
            height: 30,
            width: 35,
          ),
          leftClick: () => Navigator.pop(context)),
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
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: const Row(
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
                  buttons(addRow, Icons.add),
                  buttons(saveRow, Icons.save),
                  buttons(deleteRow, Icons.remove),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell buttons(
    Function() click,
    IconData icon,
  ) {
    return InkWell(
      onTap: () => click(),
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

  void addRow() {
    wordTextEditingList.add(TextEditingController());
    wordTextEditingList.add(TextEditingController());
    wordListField.add(
      Row(
        children: [
          Expanded(
              child: textFieldBuilder(
                  textEditingController:
                      wordTextEditingList[wordTextEditingList.length - 2])),
          Expanded(
              child: textFieldBuilder(
                  textEditingController:
                      wordTextEditingList[wordTextEditingList.length - 1])),
        ],
      ),
    );
    setState(() {});
  }

  void saveRow() async {
    int counter = 0;
    bool empty = true;

    for (int i = 0; i < wordTextEditingList.length / 2; ++i) {
      String eng = wordTextEditingList[2 * i].text;
      String tr = wordTextEditingList[2 * i + 1].text;

      if (eng.isNotEmpty || tr.isNotEmpty) {
        counter++;
        empty = false;
      }
    }
    if (counter >= 4) {
      if (!empty) {
        Lists addedList = await DB.instance
            .insertList(Lists(name: _listname.text));

        for (int i = 0; i < wordTextEditingList.length / 2; ++i) {
          String eng = wordTextEditingList[2 * i].text;
          String tr = wordTextEditingList[2 * i + 1].text;

          Word word = await DB.instance.insertWord(Word(
              list_id: addedList.id,
              word_eng: eng,
              word_tr: tr,
              status: false));
          debugPrint(
              "${word.id} ${word.list_id} ${word.word_eng} ${word.word_tr} ${word.status}");
        }
        ToastMessage("Liste oluşturuldu.");
        _listname.clear();
        for (var element in wordTextEditingList) {
          element.clear();
        }
      } else {
       ToastMessage("Boş alanları doldurun");
      }
    } else {
      ToastMessage("En az 4 çiftin dolu olması gerekli!!!");
    }
  }


  void deleteRow() {
    if (wordListField.length != 4) {
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);

      wordListField.removeAt(wordListField.length - 1);

      setState(() {});
    } else {
      ToastMessage("Minimum 4 çift gereklidir!!!");
    }
  }

  Container textFieldBuilder(
      {int height = 40,
      required TextEditingController? textEditingController,
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
