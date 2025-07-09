class Integer {
  late int _value;

  Integer([int givenvalue = 0]) {
    _value = givenvalue;
  }
}

class TimemachineeInteger extends Integer {}

void main() {
  var int1 = Integer();
  var int2 = Integer(3);

  print(int1._value);
  print(int2._value);
}
