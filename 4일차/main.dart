class Integer {
  //인스턴스 변수 -> 클래스 내에서 선언되는 변수
  late int _value;

  //생성자가 필요함(메인에서 사용해서 상단에 입력했던 변수의 값을 담아주기 위해)
  //생성자 이름() {};
  //생성자의 이름은 클래스의 이름과 동일해야 함
  //생성자의 소괄호 안에는 사용자가 입력해준 값을 인스턴스 변수에 담기 위해 사용됨
  //생성할 떄 변수를 입력하고싶지 않다면 대괄호[] 안에 변수를 선언하고, 기본값을 주면 됨

  //생성자 만드는 방법1
  Integer([int givenNumber = 0]) {
    _value = givenNumber;
  }

  //생성자 만드는 방법2
  // Integer([int givenvalue=0]) : _value = givenvalue;

  //인스턴스 변수를 반환하기 위한 함수
  int get() {
    return _value;
  }

  //인스턴스 변수를 수정하기 위한 함수
  void set(int givenNumber) {
    _value = givenNumber; //_Value =9
  }

  //get, set 을 간단하게 getter,setter 만들기
  //getter의 사용법
  //반환할 자료 타입 get 함수명 => 반환할값;
  String get retrurnString => "$_value";

  //setter의 사용법
  // set 함수명(사용자입력값) => 변경할내용;
  set changeInteger(int givenNumber) => _value = givenNumber;

  //오버로딩 사용법
  //오버로딩 = 기존 클래스에서 함수를 추가하여 클래스를 강화하는 것

  //함수의 선언 방법
  //반환할값 함수명 (사용자가 입력해야 하는 값) {실제 동작할 내용}

  // //더하기
  // int add(int givenvalue) {
  //   return _value + givenvalue;
  // }

  // //빼기

  // //연산자가 함수 이름이 되는 함수
  // int operator +(Integer givenvalue) {
  //   var input = givenvalue; //  Integer(10)

  //   return _value + givenvalue.get(); //_value + 10;
  // }

  //빼기가 함수 이름이 되는 함수
  // int operator -(Integer givenvalue) {
  //   var input = givenvalue; //  Integer(10)

  //   return _value - givenvalue.get(); //_value + 10;
  // }

  // int sub(int givenvalue) {
  //   return _value - givenvalue;
  // }

  String get asString => "$_value";
}

// extends = 다음으로 적힐 클래스명에 있는 모든 내용을 가져옴
// class newInteger extends 클래스명 {}

class NewInteger extends Integer {
  //List
  List<int> _list = []; //[0]

  newInteger([int givenValue = 0]) {
    _value = givenValue;
  }

  @override //Integer 클래스에 있는 코드에서 이 기능을 추가해서 씀
  void set(int givenvalue) {
    _list.add(_value);
    super.set(givenvalue);

    //super= 우리가 클래스를 생성할 때 extends 뒤에 쓴 클래스를 지칭함
  }

  String get asString => "현재값: $_value, 기존에 지정했었던 값: $_list";

  List getold() {
    return _list;
  }
}

void main() {
  var newnum1 = NewInteger();

  newnum1.set(9);
  newnum1.changeInteger = 2;
  print(newnum1.get());

  newnum1.set(11);

  print(newnum1.get());
  print(newnum1.getold());
  print(newnum1.asString);
}
