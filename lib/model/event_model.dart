import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../vo/event.dart';

class EventModel extends ChangeNotifier{

  var kEvents = LinkedHashMap<DateTime, List<Event>>(
    //isSameDay 함수 실행으로 equal여부를 판단하도록 사용자 정의
    equals: isSameDay,
    hashCode: getHashCode,
    // 객체 생성과 동시에 addAll 메소드를 실행
  );


  void addOneEvent({required Map<DateTime, Event> map}){

    var key = map.keys.first;
    var event = map[map.keys.first];


    if(kEvents[key]==null){
      kEvents[key]=[];
      kEvents[key]?.add(event!);
    }else{
      kEvents[key]?.add(event!);
    }

    print('keve');
    print( kEvents[key]);
    print(key);
    print(event);
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