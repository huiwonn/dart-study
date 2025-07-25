void main() {
  //null은 아무런 값이 들어가있지 않은 상태
  var name = null;

  isEmpty(name);

  //Dart에서는 사용자가 실수로 null값을 이용하지 않게 하기 위해
  //nullsafety기능 제공
  //다음 코드에서는 nico라는 변수는 String 값이 들어갈 것이다.라고 컴퓨어에 인식
  String nico = 'nico';

  //하지만 nicco라는 변수에 우리가 nill 값도 사용 할 수 있게 다음과 같이 작성하면 에러 발생

  //기본적으로 우리가 선언한 변수는 null 사용 x
}

bool isEmpty(String string) => string.length == 0;
