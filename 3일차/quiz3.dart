//name,age 를 입력받을 수 있는 player class를 만들고
//해당 플레이어의 이름,나이를 확인할 수 있는 get함수와
//해당 내역을 수정 할 수 있는 set 함수를 만들어라

class Player {
  //인스턴스 변수 선언
  late String name;
  late int age;

  //생성자 만들기
  Player(String givenname, []) {
    name = givenname;
    age = givenage;
  }

  //get 함수 
  //반환 할 자료명 함수이름() {retrun 반환할 값}
  String returnname(){
    return name;
  } 

  int returnage(){
    return age;

  }

  //getter 함수
  //
  String get getternname => name;
  int get getternage => age;


  //set 함수
  //반환할 자료명 함수이름(사용자가 변경할 값){}
 void setname(String givenname){
  name = givenname;
 }

  //setter 함수
  set changename(String givenname) => name = givenname;
  set changeage(int givenage) => age = givenage;
}

void main() {
  // // 변수 선언 방법
  // // 자료형 변수명 = ~~~;
  // var sadff = Player('name', 20);

  // print(sadff.age);

//  print(Player.gettename);
//  print(Player.getterage);

var Player = 
 Player.changename = "짱구";
 Player.changeage = 5;

 print(Player.changename);

 
 }
