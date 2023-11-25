
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_utils/util.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  late final ValueNotifier<List<Event>> selectedEvents;

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay1;


  // Map<DateTime, List<Event>> events = {
  //   DateTime.utc(2023,9,29) : [ Event('title'), Event('title2') ],
  //   DateTime.utc(2023,9,30) : [ Event('title3') ],
  // };

  @override
  void initState() {
    super.initState();

    selectedDay1 = focusedDay;
    // ChangeNotifer 를 상속 받는 클래스
    selectedEvents = ValueNotifier(getEventsForDay(selectedDay1!));
  }

  @override
  void dispose() {
    selectedEvents.dispose();

    super.dispose();
  }

  void onDaySelected(DateTime selectDay, DateTime focuseDay) {
    if (!isSameDay(selectedDay1, selectDay)) {
      setState(() {
        selectedDay1 = selectedDay1;
        focusedDay = focusedDay;
      });

      selectedEvents.value = getEventsForDay(selectDay);
    }
  }


  ///리스트로 구현 해주는것
  List<Event> getEventsForDay(DateTime day) {

    print('완료');
    return kEvents[day] ?? [];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [TableCalendar(

          /// 이벤트에 대한 마커를 추가하기 위해 eventLoader를 설정합니다.
          // eventLoader: (day){
          //   return kEvents
          // },
          // onDaySelected: (){
          //   print('day======');
          //
          // },
          locale: 'ko_KR',
          focusedDay: DateTime.now(),
          selectedDayPredicate: (day) => isSameDay(selectedDay1, day),

          // selectedDayPredicate: (DateTime day) {
          //   // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
          //   return isSameDay(selectedDay, day);
          // },
          firstDay: DateTime(1800),
          lastDay: DateTime(3000),
          //todo 달력 title 스타일
          headerStyle: const HeaderStyle(
            // 디폴트로 설정 되 있는 2주 보기 버튼을 없애줌
              formatButtonVisible: false,
              // 달력 타이틀을 센터로
              titleCentered: true,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.blue
              ),
              //todo 달력 왼쪽 아이콘
              leftChevronIcon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: Colors.black87,
              ),
              //todo 달력 오른쪽 아이콘
              rightChevronIcon: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.black87,
              )
          ),
          //todo today 오늘날짜
          calendarStyle: CalendarStyle(
            //today 표시여부
            isTodayHighlighted: true,
            //today 모양 조정
            defaultDecoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            // todo 선택한 날짜
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
    ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //리스트 항목 개수
                  itemCount: value.length,
                  //리스트의 반복문 항목 형성
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.redAccent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        // vertical: 4.0,
                      ),
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.grey)
                        ),
                      /// 날짜 클릭시, 이벤트
                      child: ListTile(
                        onTap: () => print('안녕'),
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


