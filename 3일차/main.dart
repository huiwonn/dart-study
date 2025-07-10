class Integer {
  //인스턴스 변수 -> 클래스 내에서 선언되는 변수
  late int _value;

  //생성자가 필요함(메인에서 사용해서 상단에 입력했던 변수의 값을 담아주기 위해)
  //생성자 이름() {};
  //생성자의 이름은 클래스의 이름과 동일해야 함
  //생성자의 소괄호 안에는 사용자가 입력해준 값을 인스턴스 변수에 담기 위해 사용됨
  //생성할 떄 변수를 입력하고싶지 않다면 대괄호[] 안에 변수를 선언하고, 기본값을 주면 됨
  Integer([int givenNumber = 0]) {
    //사용자가 입력한 givenNumber 를 우리의 인스턴스 변수 안에 담음
    _value = givenNumber;
  }
  //인스턴스 변수를 반환하기 위한 함수
  int get() {
    return _value;
  }

  //인스턴스 변수를 수정하기 위한 함수
  void set(int givenNumber) {
    _value = givenNumber;
  }

  //get, set 을 간단하게 getter,setter 만들기
  //getter의 사용법
  //반환할 자료 타입 get 함수명 => 반환할값;
  String get retrurnString => "$_value";

  //setter의 사용법
  // set 함수명(사용자입력값) => 변경할내용;
  set changeNumber(int givenNumber) => _value = givenNumber;
}

class TimemachineeInteger extends Integer {}

class StringCalss {
  late String _value;

  //생성자
  StringCalss([String givenString = '']) {
    _value = givenString;
  }

  String get() {
    return _value;
  }

  set(String givenString) {
    _value = givenString;
  }

  String get asString => "$_value";
}

class Player {
  late String name;
  late int age;

  //생성자
  Player([String givenname = '영자씨', int givenage = 1]) {
    name = givenname;
    age = givenage;
  }
}

void main() {
  //클래스 사용
  var num1 = Integer(123);
  // var player = Player();
  var player = Player();
  //  print();

  // print(num1.get());

  // num1.set(456);

  // print(num1.set);

  // num1.changeNumber = 11;
  // print(num1.retrurnString);
}
