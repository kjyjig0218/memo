import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../vo/event.dart';

class EventModel extends ChangeNotifier{


  // 선택한 날짜에 따른 이벤트 리스트를 생성
  var kEvents = LinkedHashMap<DateTime, List<Event>>(
    //isSameDay 함수 실행으로 equal여부를 판단하도록 사용자 정의
    equals: isSameDay,
    hashCode: getHashCode,
    // 객체 생성과 동시에 addAll 메소드를 실행
  );

 // kEvents에서 생성한 리스트에 Map<해당 날짜, 발생 이벤트> 해당 날짜에 해당하는 제목을 추가해준다.
  void addOneEvent({required Map<DateTime, Event> map}){

    // map에서 첫번째 키를 가져와 key 변수에 저장
    var key = map.keys.first;
    // map[a]=map 안에 a 라는 키 값을찾아주는 기능
    var date = map[key];

     /// 새로운 리스트 추가
    //null이라는 것은 해당 날짜에 이벤트가 아직 등록되지 않음
    if(kEvents[key]==null){
      kEvents[key]=[];
      kEvents[key]?.add(date!);
      /// 기존에 있던것에서 추가
    }else{
      kEvents[key]?.add(date!);
    }

    print('keve');
    print( kEvents[key]);
    print(key);
    print(date);
    notifyListeners();
  }


  void addEvent({required Map<DateTime, List<Event>> map}){
    kEvents[map.keys.first]?.add(Event('sdg'));
    kEvents.addAll(map);
    print(kEvents);
    notifyListeners();
  }



}



int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}