import 'package:flutter/material.dart';
import 'package:ingilizcecalisma/pages/homepage.dart';

class TemproryPage extends StatefulWidget {
  const TemproryPage({super.key});

  @override
  State<TemproryPage> createState() => _TemproryPageState();
}

class _TemproryPageState extends State<TemproryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset("assets/images/logo.png"),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "EASY",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Carter",
                            fontSize: 35),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "ÖĞRENMEK İÇİN BURDASIN!!",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Luck", fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
