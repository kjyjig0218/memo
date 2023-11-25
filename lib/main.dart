import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:memo/model/event_model.dart';

import 'package:memo/screen/calendar_screen.dart';
import 'package:memo/model/memo_model.dart';
import 'package:memo/screen/addmemo_screen.dart';
import 'package:memo/screen/table_events_example.dart';
import 'package:provider/provider.dart';



Future <void> main() async {
  /// 한글 언어 설정
  await initializeDateFormatting();

  runApp(MyMemoApp());
}

class MyMemoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (context)=>MemoModel()),
          ChangeNotifierProvider(create: (context)=>EventModel()),
        ],
      child: MaterialApp(
        title: '메모장 앱',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.redAccent
          ),
        ),

        home: TableEventsExample(),
      ),
    );
  }
}


