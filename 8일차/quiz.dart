// 기존에 학습했던 http 코드들을 참고하여 사용자를 CRUD 할 수 있는 RESTful 프로그램을 작성하고자 합니다.
// 다음의 코드들을 참고하여 RESTful 프로그램을 완성하세요.
// 서버의 포트는 3000번 포트를 이용하며,
// 각 API들은 /user 를 이용하여 호출이 되어야 합니다.

import 'dart:convert';
import 'dart:io';

void create(Map database, HttpRequest request) async {
  // 생성 코드 작성
  //1.사용자가 요청한 값을 문자열로 변환하는 기능을 만들자
  //(request로 서버에게 전달된 값은 일반 사람이 읽을 수 없는 stream 데이터로 받아옴)
  //(그래서 이걸 서버에서 실제 값을 확인 할 수 있게 문자열로 변환하는 기능을 구현)

  var bodydata = await utf8.decoder.bind(request).join();
  var Mapdata = jsonDecode(bodydata) as Map;
  var key, value;


  print("\>bodydata : $bodydata");

 Mapdata.forEach((k, v) {
    key = k;
    value = v;
  });
//DB에 사용자가 입력한 값을 실제로 추가해보자
//추가할 때 같은 키로 데이터를 추가하면 어떻게 되는건지
//우리는 수정,조회,삭제 등등을 할 때 키로 데이터를 확인하는데,
//같은 키를 가진 데이터가 있으면 컴퓨터는 어떤 데이터를 삭제해야할지 모름
//그래서 생서ㅇ하려는 키가 이미 있으면 생성하지 못하게 예외처리해야함

//키가 이미 존재하는지에 대한 조건문 처리 방법*/
  if (database.containsKey(key)) {
    bodydata = "생성 실패! 이미 존재하는 키 입니다.";
  } else {
    bodydata = "생성 성공";
  }

// //키가 존재하지 않는지에 대한 조건문 처리 방법*/
// if(database,containsKey(Key) == false){
// //키가 없는 경우
// }else{
// //키가 있는 경우
// }

  printAndSendHttpResponse(database, request, bodydata);
}

void read(Map database, HttpRequest request) async {
  // 조회 코드 작성
  //url에 있는 사용자가 입력해준 사용자IP값을 가져와야함
  //request.url : 사용자가 요청한 url 
  //pathSegments : 
  var key = request.uri.pathSegments.last;
  var content, transaction;

  if (database.containsKey(key) == true) {
    //실제 database에 있는 값을 사용자에게 response로 전달
  
    transaction = {};
    transaction[key] = database[key];
    content = "조회 성공! 조회한 데이터는 ${database[key]}입니다";

    //
  } else {
    content = "fail< $key not-exist>";
  }

  printAndSendHttpResponse(database, request, content);
}

void update(Map database, HttpRequest request) async {
  var content = await utf8.decoder.bind(request).join();
  var transaction = jsonDecode(content) as Map;
  var key, value;

  print("\> content        : $content");
  transaction.forEach((k, v) {
    key = k;
    value = v;
  });

  if (database.containsKey(key) == true) {
    database[key] = value;
    content = "요청 성공 < $transaction updated >";
  } else {
    content = "요청 실패 < $key not-exist >";
  }
  printAndSendHttpResponse(database, request, content);
}

void delete(Map database, HttpRequest request) async {
  var key = request.uri.pathSegments.last;
  var content, value;

  if (database.containsKey(key) == true) {
    value = database[key];
    database.remove(key);
    content = "요청 성공 < {$key, $value} deleted >";
  } else {
    content = "요청 실패 < $key not-exist >";
  }
  printAndSendHttpResponse(database, request, content);
}

Future main() async {
  var database = <dynamic, dynamic>{};

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);

  printHttpServerActivated(server);

  await for (HttpRequest request in server) {
    if (request.uri.path.contains('/user') == true) {
      printHttpRequestInfo(request);

      try {
        switch (request.method) {
          // 메서드들에 대한 CASE 작성
          case "GET":
          //CRUD에서 READ 담당할 때 GET
          read(database, request);
          break;
        
          case "PUT":
          update(database, request);
          break;
          case "PUSH":
          create(database, request);
          break;
          case "DELETE":
            create(database, request);
            delete(database, request);
            break;
            case 

          default:
            print("\$ 지원하지 않는 메서드입니다.");
            break;
        }
      } catch (err) {
        print("\$ 요청 수행 중 에러가 발생했습니다.");
      }
    } else {
      printAndSendHttpResponse(
        database,
        request,
        "${request.method} {에러: 지원하지 않는 API 입니다.}",
      );
    }
  }
}

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

void printAndSendHttpResponse(
  Map database,
  HttpRequest request,
  String content,
) async {
  print("\$ $content \n current DB      : $database");

  var data = utf8.encode(content);
  //data라는 변수에 content에 있는 한글로 제대로 확인 할 수 있게 변경
  request.response
    ..headers.contentType = ContentType('text', 'plain', charset: 'utf-8')
    ..headers.contentLength = data.length
    ..statusCode = HttpStatus.ok
    ..add(data);

  await request.response.close();
}
