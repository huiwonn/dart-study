void main() {
  var name = 'nico';
  String name2 = 'nico2';

  //기본적으로 var 또는 다른 타입으로 생성된 변수는 계속 수정가능
  name = "hi";
  name2 = 'hello';

  //수정을 할 수 없는 변수를 만들어야 할 때 final이라는 자료형 사용
  final name3 = 'helllllo';

  name3 = 'hihi';
  //final 자료형은 단 한 번 자료형 지정하고 난 후에는 수정 불가능

  //final 자료형은 변수의 타입도 지정할 수 있다
  final String name4;
}
