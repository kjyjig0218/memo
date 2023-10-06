import 'package:flutter/material.dart';
import 'package:memo/model/event_model.dart';
import 'package:memo/model/memo_model.dart';
import 'package:table_calendar/table_calendar.dart';


import 'package:provider/provider.dart';
import 'package:memo/screen/addmemo_screen.dart';

import '../vo/event.dart';



class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var kEvents;

  
  @override
  void initState() {
    super.initState();
    kEvents=Provider.of<EventModel>(context,listen: false).kEvents;
    _selectedDay = _focusedDay;
    // ChangeNotifer 를 상속 받는 클래스
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }


  //날짜 클릭시
  List<Event> _getEventsForDay(DateTime day) {

    // print('완료 ${day}');
    // print(kEvents[day]);
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print('====selectedDay==');
    print(selectedDay);

    //Event event = Event('테스트');
    //Provider.of<EventModel>(context,listen: false).addEvent(map: {selectedDay:[Event('테스트')]});
    //Provider.of<EventModel>(context,listen: false).addOneEvent(map: {selectedDay:Event('테스트')});


    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;

        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       actions:[IconButton(
         icon:Icon(Icons.add,
           color: Colors.black87,) ,

         onPressed: () async{
           await Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemoScreen(dateTime: _selectedDay!,)));
           setState(() {});
         },
       ),
    ]
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            locale: 'ko_KR',
            lastDay: DateTime(2999,12,31),
            firstDay: DateTime(2000,1,1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay, //이벤트 ui 생성
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              /// 디폴트로 설정 되 있는 2주 보기 버튼을 없애줌
                formatButtonVisible: false,
                // 달력 타이틀을 센터로
                titleCentered: true,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.grey[600]
                ),
                /// 달력 왼쪽 아이콘
                leftChevronIcon: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: Colors.black87,
                ),
                /// 달력 오른쪽 아이콘
                rightChevronIcon: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.black87,
                )
            ),
            calendarStyle: CalendarStyle(
              //today 표시여부
              isTodayHighlighted: true,
              //today 모양 조정
              defaultDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              ///선택한 날짜
              // selectedDay 글자 조정
              selectedTextStyle: const TextStyle(
                color: const Color(0xFFFAFAFA),
                fontSize: 16.0,
              ),
              // selectedDay 모양 조정
              selectedDecoration: const BoxDecoration(
                color: const Color(0xFF5C6BC0),
                shape: BoxShape.circle,
              ),
            ),


            onDaySelected: _onDaySelected,
            // onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          ///이벤트 리스트
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      /// 날짜 클릭시, 이벤트
                     child: ListTile(
                        onTap: () => print('상세페이지로 이동'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}