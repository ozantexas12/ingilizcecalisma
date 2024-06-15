import 'package:flutter/material.dart';
import 'package:ingilizcecalisma/h%C4%B1zl%C4%B1/app_bar.dart';
import 'package:ingilizcecalisma/h%C4%B1zl%C4%B1/color.dart';
import 'package:ingilizcecalisma/pages/create_list.dart';
import 'package:ingilizcecalisma/database/db/database.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  List<Map<String, Object?>> _list = [];
  List<bool> deleteIndexList = [];
  bool pressController = false;

  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    _list = await DB.instance.readListsAll();
    deleteIndexList = List.generate(_list.length, (index) => false); // Initialize deleteIndexList
    setState(() {
      _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        left: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 20,
        ),
        center: Image.asset(
          "assets/images/lists.png",
          alignment: Alignment.centerRight,
        ),
        right: pressController != true
            ? Image.asset(
          "assets/images/logo.png",
          height: 30,
          width: 35,
        )
            : InkWell(
          child: const Icon(
            Icons.delete,
            color: Colors.deepPurpleAccent,
            size: 24,
          ),
          onTap: () {
            // Handle delete action here
            deleteSelectedItems();
          },
        ),
        leftClick: () => {Navigator.pop(context)},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListeOlustur()),
          );
        },
        backgroundColor: Colors.red.withOpacity(0.6),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return listItem(
              _list[index]['list_id'] as int,
              index,
              listname: _list[index]['name'].toString(),
              sumWords: _list[index]['sum_words'].toString(),
              sumUnLearned: _list[index]['sum_unlearned'].toString(),
            );
          },
          itemCount: _list.length,
        ),
      ),
    );
  }

  InkWell listItem(
      int id,
      int index, {
        @required String? listname,
        @required String? sumWords,
        @required String? sumUnLearned,
      }) {
    return InkWell(
      onTap: () {
        debugPrint(id.toString());
      },
      onLongPress: () {
        setState(() {
          pressController = true;
          deleteIndexList[index] = true;
        });
      },
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin:
            const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            color: Color(Ok.HexaColorConverter("#DCD2F3")),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        listname!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "RobotoMedium",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Text(
                        "${sumWords!} terim",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "RobotoRegular",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Text(
                        "${(int.tryParse(sumWords) ?? 0) - (int.tryParse(sumUnLearned ?? '0') ?? 0)} öğrenildi",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "RobotoRegular",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Text(
                        sumUnLearned!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "RobotoRegular",
                        ),
                      ),
                    ),
                  ],
                ),
                if (pressController == true)
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.deepPurple,
                    value: deleteIndexList[index],
                    onChanged: (bool? value) {
                      setState(() {
                        deleteIndexList[index] = value ?? false;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void deleteSelectedItems() {
    List<int> itemsToDelete = [];
    for (int i = 0; i < deleteIndexList.length; i++) {
      if (deleteIndexList[i]) {
        itemsToDelete.add(_list[i]['list_id'] as int);
      }
    }
    setState(() {
      _list.removeWhere((element) => itemsToDelete.contains(element['list_id']));
      deleteIndexList = List.generate(_list.length, (index) => false);
      pressController = false;
    });
  }
}
