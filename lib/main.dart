import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:memo/model/event_model.dart';

import 'package:memo/screen/calendar_screen.dart';
import 'package:memo/model/memo_model.dart';
import 'package:memo/screen/addmemo_screen.dart';
import 'package:memo/screen/list_screen.dart';
import 'package:memo/screen/table_events_example.dart';
import 'package:provider/provider.dart';



void main() async {

  // import 는 package:intl/date_symbol_data_local.dart
  await initializeDateFormatting();

  runApp(MyMemoApp());
}

class MyMemoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>MemoModel()),
          ChangeNotifierProvider(create: (_)=>EventModel()),
        ],
      child: MaterialApp(
        title: '메모장 앱',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[300],
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


