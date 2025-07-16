// quiz2.dart 파일을 참고하여 다음의 기능들을 추가로 구현하세요.
// 1. GET 메서드를 사용해 모든 나라의 수도를 출력하는 기능을 구현하세요.
// 경로는 /all 이며,
// 반환되는 데이터는 JSON 형식이어야 합니다.
// 2. DELETE 메서드를 사용해 입력한 나라를 삭제하는 기능을 구현하세요.
// 경로는 /delete=나라이름 이며,
// 해당 데이터를 삭제한 후 남아있는 나라들을 반환해야 합니다.
// 반환되는 데이터는 JSON 형식이여야 합니다.

import 'dart:io';
import 'dart:convert';

void printHttpServerActivated(HttpServer server) {
  var ip = server.address.address;
  var port = server.port;

  print('\$ Server activated in $ip:$port');
}

void printHttpRequestInfo(HttpRequest request) async {
  var ip = request.connectionInfo!.remoteAddress.address;
  var port = request.connectionInfo!.remotePort;
  var method = request.method;
  var path = request.uri.path;

  print('\$ $method $path from $ip:$port');

  if (request.headers.contentLength != -1) {
    print('\> content-type: ${request.headers.contentType}');
    print('\> content-lendth: ${request.headers.contentLength}');
  }
}

void httpGetHandler(HttpRequest request) async {
  if (request.uri.path == '/') {
  } else if (request.uri.path.contains('/add')) {
  } else if (await File(request.uri.path.substring(1)).exists() == true) {
  } else {}
}

//사용자가 요청을 보낼 때 사용한 메서드에 따라서 각가 다른 함수가 동작할 수 있게 만드어보자
//switch(조선에 사용할 변수){
//  case'조건1' : {}
//  case'조건2' : {}
//}

//request.method 라는 요청의 메소드에 따라서 다른 코드를 실행하겠다.

// switch (request.method) {
//   case.'GET' : 
//   httpGetHandler(request);

//   //case 내부의 코드가 다 동작했다면, break; 를 작성해서 "해당 case에서 벗어나겠다."
//   //라는 내용을 반드시 작성해야함
// }