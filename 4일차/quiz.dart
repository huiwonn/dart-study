//1.Integer 클래스를 하나 생성한 후, val 이라는 인스턴스 변수를 생성해보자.
//2.Integer 클래스의 생성자는 203페이지의 생성자 생성 방법을 이용해서 작성해보자.
//3.Integer 클래스에서는 val 이라는 인스턴스 변수를 return 하는 get 함수와 값을 변경하는 set 함수가 있어야 한다.
//4.Integer 클래스를 extends 하는 GoodInteger 라는 클래스를 생성한다.
//5.GoodInteger 클래스에 goodlist 라는 list형 인스턴스 변수를 생성해보자.
// goodlist의 기본 값은 []이다.
// //6.integer 클래스에 존재하는 set함수를 @override하여, 값이 변경될 때마다 goodlist에 변경된 값을 저장하는 함수를 만들어보자
//7.goodlist의 값들을 return하는 함수를 만들어보자.

class Integer {
  late int _val;

  Integer({int givenname = 0}) : _val = givenname;

  int get() {
    return _val;
  }

  void set(int givenname) {
    _val = givenname;
  }
}

class GoodInteger extends Integer {
  List<int> _goodlist = [];

  GoodInteger([int givenvalue = 0]) {
    _val = givenvalue;
  }

  @override
  void set(int givenname) {
    _goodlist.add(_val);
    super.set(givenname);
  }

  List returnlist() {
    return _goodlist;
  }
}

void main() {
  var num1 = GoodInteger(9);

  print(num1.get());
}
