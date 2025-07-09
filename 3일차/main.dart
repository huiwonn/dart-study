void main() {
  List list = [1, 2, 3];

  if (list.isEmpty) {
    print("리스트가 비어있어요.");
  } else {
    print("리스트가 안비어있어요");
  }

  list.isEmpty
      ? print("리스트가 비어있어요.")
      : list.first == 1
      ? print("첫번째값은 1입니다.")
      : print("첫번째값은 1이 아닙니다.");
}
