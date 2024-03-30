import 'package:flutter/material.dart';
import 'package:ingilizcecalisma/h%C4%B1zl%C4%B1/color.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
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
                onTap: () {},
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Image.asset("assets/images/lists.png"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red.withOpacity(0.6),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  color: Color(Ok.HexaColorConverter("#DCD2F3")),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "Liste Adı",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "RobotoMedium"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: const Text(
                          "200 Terim ",
                          style: TextStyle(color: Colors.black, fontSize: 14,fontFamily: "RobotoRegular"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30,),
                        child: const Text(
                          "100 Öğrenildi",
                          style: TextStyle(color: Colors.black, fontSize: 14,fontFamily: "RobotoRegular"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left:30),
                        child: const Text(
                          "100 Öğrenilmedi",
                          style: TextStyle(color: Colors.black, fontSize: 14,fontFamily: "RobotoRegular"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}