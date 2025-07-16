//사람을 뜻하는 Human 클래스를 생성하고,
//이름(name),나이(age),성별(gender)를 담을 수 있는 인스턴스 변수를 생성하세요
//모든 값들은 클래스 호출 시 필수적으로 입력해야하며,
//생성자를 작성할 땐 named parameter 를 이용해야 합니다.(p.106)
//이후 사용자의 정보를 출력하는 함수인 profile을 구현해야 하며,다음의 내용을 출력해야 합니다.
//[안녕하세요. 제 이름은 김철수이며,16살 남성입니다.]

class Human {
  late int age;
  late String _name;
  late String gender;

  // named parameter 사용 시, 소괄호 안에 있는 변수들을 {} 중괄호로 감싸줘야함.
  // 그리고 각 변수들 ex) String givenName 의 앞에는 필수값인 경우 required 를 작성해 줘야 하며,
  // 필수값이 아닌 경우, string givenName = '김철수' 이런 식으로 기본 값을 줘야함.
  Human({required givenName, required givenAge, required givenGender}) {
    _name = givenName;
    age = givenAge;
    gender = givenGender;
  }
}

void main() {
  // named parameter 이용시 생성자에 선언한 변수의 순서를 안맞춰줘도 됨.
  // 왜냐하면 어떤 변수에 어떻게 담을건지 작성을 해주기 때문
  // var human = Human(givenAge: 10, givenGender: "남성", givenName: "김철수");

  // // named parameter 미사용시 생성자에서 선언한 변수의 순서들을 항상 맞춰줘야함.
  // var human = Human("김철수", 10, "남성");
}
