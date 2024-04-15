import 'package:flutter/material.dart';

class ListeOlustur extends StatefulWidget {
  const ListeOlustur({super.key});

  @override
  State<ListeOlustur> createState() => _ListeOlusturState();
}

class _ListeOlusturState extends State<ListeOlustur> {
  final _listname = TextEditingController();

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
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
              child: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.arrow_back,
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
            Container(
              alignment: Alignment.centerRight,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
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
              Container(
                height: 40,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.withOpacity(0.25),
                ),
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
                child: TextField(
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  controller: _listname,
                  style:const TextStyle(
                    color: Colors.black,
                    fontFamily: "RobotoLight",
                    decoration: TextDecoration.none,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.list),
                      border: InputBorder.none,
                      hintText: "Liste Adı",
                      fillColor: Colors.transparent,
                      isDense:true,
                  ),
                ), //Yazı ve metin alanı için kullanılır
              ),
            ],
          ),
        ),
      ),
    );
  }
}
