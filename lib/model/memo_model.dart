import 'package:flutter/material.dart';

class MemoModel extends ChangeNotifier{

  List<String> memos =[];

  void addMemo(String title){
    memos.add(title);
    print(memos);
    notifyListeners();
  }


}