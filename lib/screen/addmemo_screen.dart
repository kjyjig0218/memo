import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memo/model/memo_model.dart';
import 'package:provider/provider.dart';

import '../model/event_model.dart';
import '../vo/event.dart';
import 'table_events_example.dart';


class AddMemoScreen extends StatefulWidget {

  DateTime dateTime;

  AddMemoScreen({required this.dateTime});

  @override
  State<AddMemoScreen> createState() => _AddMemoScreenState();

}

class _AddMemoScreenState extends State<AddMemoScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
                Icons.delete_forever_outlined,
                size: 30),
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.black87,
          size: 20,
        ),
        title: Text(DateFormat('yyyy-MM-dd').format(widget.dateTime),
        style: TextStyle(
          fontSize: 20,
          color: Colors.black87
        ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text("Title",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "제목",
                    ///사용자가 폼 클릭시
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    /// 기본 폼 상태
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Contents",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  controller: contentsController,
                  decoration: InputDecoration(
                      hintText: "내용",
                      fillColor: Colors.white,
                      ///사용자가 폼 클릭시
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      /// 기본 폼 상태
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      // contentPadding: EdgeInsets.symmetric(vertical: 40)
                  ),
                  maxLines: 10,
                  maxLength: 500,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        minimumSize: Size(50, 50),

                      ),
                      onPressed: () async{
                        // _addMemo(
                        //     context: context,
                        //     onComplete: (){
                        //       Navigator.pop(context);
                        //     }
                        // );
                        // //
                        // // var result = await _addMemoFuture(context: context);
                        // // if(result==true){
                        // //   Navigator.pop(context);
                        // // }

                        Provider.of<EventModel>(context,listen: false).addOneEvent(map: {widget.dateTime:Event(titleController.text)});
                        Navigator.pop(context);



                      },
                      child: Text("완료",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<bool> _addMemoFuture({required BuildContext context}) async{

    return await showDialog(
      context: context,
      builder: (BuildContext context1) => AlertDialog(
        content: Text("추가 하시겠습니까?"),
        actions: <Widget>[
          TextButton(
            child: Text('취소'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('추가'),
            onPressed: () {
              setState(() {
                var title = titleController.text;
                if(title.isEmpty){
                  //todo 타이틀 내용이 없을때
                  Navigator.of(context1).pop(false);
                }else{
                  //todo 타이틀 내용이 있을때

                  Provider.of<EventModel>(context,listen: false).addOneEvent(map: {widget.dateTime:Event(titleController.text)});
                  Navigator.pop(context);

                }

              });

            },
          ),
        ],
      ),
    );
  }


  void _addMemo({required BuildContext context, required Function onComplete}) {

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          content: Text("추가 하시겠습니까?"),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('추가'),
              onPressed: () {
                setState(() {
                  var title = titleController.text;
                  if(title.isEmpty){
                    //todo 타이틀 내용이 없을때
                    Navigator.of(context, rootNavigator: true).pop();
                  }else{
                    //todo 타이틀 내용이 있을때
                    Provider.of<MemoModel>(context,listen:false).addMemo(title);
                    Navigator.of(context, rootNavigator: true).pop();
                    onComplete();
                  }

                });

              },
            ),
          ],
        ),
    );
  }



}
