import 'package:flutter/material.dart';
import 'package:memo/model/memo_model.dart';
import 'package:memo/screen/addmemo_screen.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memo"),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,


          child: Consumer<MemoModel>(builder: (context, a, child){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: a.memos.map((e) => Text(e,style: TextStyle(fontSize: 20),)).toList(),
            );
          },)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddMemoScreen(dateTime: DateTime.now(),)),
          );
        },
        tooltip: '메모추가',
        child: const Icon(Icons.add),
      ),
      );
  }
}
