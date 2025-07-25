void main() {
  //변수 선언하고,초기 값 지정해주지 않음
  //값을 지정해주지 않으면 컴퓨터는 해당 변수의 타입이 dynamic이라고 이해
  // var name;
  dynamic name;

  name = '짱구';
  name = 1.2;
  name = false;

  //name 이라는 벼ㅕㄴ수는 현재 dynamic이라는 여러가지 타입을 설정할 수 있기 때문
  //name 뒤에 . 를 이용해서 추가 기능을 확인해보면 적은 자동 완성을 추전
  //이렇게 해야 dynamic 변수에 각 타입을 분리해서 안전하게 자동완성 사용

  //is = 앞에 있는 변수가 오른쪽에 있는 타입인지 확인해주는 기능
  if (name is String) {
    //if문 내부의 중괄호에서는 name 이 항상 string 타입이라는 것을 확인
    //String 타입의 자동 완성을 추천
  }
}
