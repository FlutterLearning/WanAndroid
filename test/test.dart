import 'person.dart';

printNumber(num aNumber) => print('$aNumber');

void main() {
//  const int a = 1;
//  final int b = 2;
  const c = 1;
  final d = 2;

//  printElement(element) {
//    print(element);
//    test(a: 1, b: "ss");
//    test(1, "adasd");
//
//    test(a: 1, b: "11");
//  }

//  printElement(111);

  try {
    var list = ['apples', 'oranges', 'grapes', 'bananas', 'plums'];
    list.forEach((i) {
      print(list.indexOf(i).toString() + ': ' + i);
    });
    list.forEach(
            (string) => print(list.indexOf(string).toString() + ': ' + string));
  } on Exception catch (e) {
    print("$e");
  } catch (e) {
    print("$e");
    rethrow;
  }
}

bool test(int a, String b) {
  return true;
}

void returnValue() {
  return null;
}

class Test {
  static const int a = 1;

//  const int c = 1;
  final int b = 2;
}
