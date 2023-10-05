

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// 이벤트에 넣을 객체를 직접 정의
class Event {
  // title 제목
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}


/// LinkedHashMap은 순서대로 키 값을 가져옴
/// ==비교나 hash값 불러오는 등의 기능을 사용자 정의 할 수 있게 해주는 map
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  //isSameDay 함수 실행으로 equal여부를 판단하도록 사용자 정의
  equals: isSameDay,
  hashCode: getHashCode,
  // 객체 생성과 동시에 addAll 메소드를 실행
)..addAll(_kEventSource);


///마킹 해주는 이벤트 인덱스 길이가 왜 필요한교...?
final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}


/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
// List<DateTime> daysInRange(DateTime first, DateTime last) {
//   final dayCount = last.difference(first).inDays + 1;
//   return List.generate(
//     dayCount,
//         (index) => DateTime.utc(first.year, first.month, first.day + index),
//   );
// }

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);