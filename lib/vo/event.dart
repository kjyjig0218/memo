
/// 이벤트에 넣을 객체를 직접 정의
class Event {
  // title 제목
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}
