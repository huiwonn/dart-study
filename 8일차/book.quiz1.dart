// 현재 rest-crud.dart 에 있는 파일에서 updateDB 부분은 수정할 데이터가 들어가 있는 값을
// 전부 body에 담아서 사용을 하고 있습니다.
// 이 부분을 저희는 수정할 데이터의 key 값을 요청의 마지막 부분에 담아서 수정을 하고 싶습니다.
// ex) PUT 127.0.0.1:4040/api/0001
// 이 방식을 이용해서 key 값을 조회하고, body 부분에는 다음과 같이 입력을 했을 때
// key에 있는 데이터가 수정이 될 수 있게 하고자 합니다.
// body에 들어갈 값 : { "data": "Cheongju" }
// 현재 존재하는 updateDB 를 위에 작성한 내용대로 실행했을 때 값이 수정되도록 변경해보세요.//REST 라는 HTTP통신을 어떻게 사용할 지에 대한 규약에 대해서 학습
//REST 에서 기본적으로 사용되는 메서드를 -POST,GET,PUT,DELETE가 있다.
//이 메서드들을 사용 할 때 각 기능들은 다음의 메서드를 이용한다.
//REST에서는 기본적으로 CRUD를 구현하게 되는데, CRUD는 다음과 같은 기능을 한다.
//CREATE (생성) -POST
//READ (조회) - GET
//UPDATE(수정) - PUT
//DELETE(삭제) - DELETE
//REST 방식으로 개발을 진행하면 RESTful 하다. 라고 부른다.
//기본적으로 REST를 이용해 API를 구현할 때에는 다음의 구조를 따라서 만들게 된다.
//ip:port/{기능이름}/{key값}
// 예를 들어서 사용자 생성 이라는 기능을 만들어야 한다면?
// 127.0.0.1:4040/user 로 POST 메서드를 이용하면 되겠죠.
// 수정 기능이라면?
// 127.0.0.1:4040/user/{키값} 으로 PUT 메서드를 이용하면 되겠죠.

import 'dart:convert';

import 'dart:io';

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

//db : REST 방식을 이용해서 사용자가 요청을 보냈을 때 CRUD가 진행된 후 결과ㅓ를 담을 변수
//request : 사용자의 요청
//content
void printAndSendHttpResponse(var db, var request, var content) async {
  print("\$ $content \n current DB  : $db");
  request.response
    ..headers.contentType = ContentType('text', 'plain', charset: "utf-8")
    ..headers.contentLength = content.length
    ..statusCode = HttpStatus.ok
    ..write(content);
  await request.response.close();
}

void createDB(var db, var request) async {
  //cotent 변수에 사용자의 요청을 utf8 코드로 해독해서 담고 있음
  var content = await utf8.decoder.bind(request).join();
  //transaction 변수에 uf8 코드로 해독된 사용자의 요청을 받고 있음
  //담을 때 as Map 을 통해서 json 형식의 데이터를 Map 형식으로 변형해서 담고있음
  var transaction = jsonDecode(content) as Map;
  var key, value; // 우리가 DB에 정보를 담을 때 각 정보의 key와 value에 담을 때 사용할 변수

  print("\>comtent : $content");

  //Map변수.forEach : Map 변수 안에 있는 각각의 값들을 전부 다 하나씩 접근
  //(k,v) : transaction Map 변수에서 가지고 있는 key와 value 를  k,v 로 표현
  transaction.forEach((k, v) {
    key = k;
    //transaction의 key를 바깥에서 선언한 key변수에 담겠다.
    value = v;
    //transaction의 value를 바깥에서 선언한 value변수에 담겠다.
  });

  if (db.containsKey(key) == false) {
    //현재 db에 값이 없으면 해당 key에 해당하는 부분에 value를 넣어라
    db[key] = value;
    content = "Success < $transaction created >";
  } else {
    //db변수가 이미 key를 가지고 있는 경우
    content = "fail <$key already exist >";
  }

  printAndSendHttpResponse(db, request, content);
}

Future main() async {
  //key에 dynamic, value에 dynamic 타입을 가진 map 변수
  var db = <dynamic, dynamic>{};

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);

  printHttpServerActivated(server);

  //앞으로 서버에 요청을 보낼때 127.0.0.1:4040/api/~~ 이 경로로 요청을 보내면 됨
  await for (HttpRequest request in server) {
    //request.uri.path (사용자가 요청한 주소의 경로)가 / api라는 값을 포함?
    if (request.uri.path.contains('/api') == true) {
      printHttpRequestInfo(request);

      try {
        //request.method (사용자가 생성한 요청의 메서드)에 따라
        //POST,GET,PUT,DELETE 가 실행했을 때 각자 다른 함수 실행
        //default 를 이용해서 다른 메서드를 사용하면 아무 기능하지 않게 지정
        switch (request.method) {
          case "POST":
            createDB(db, request);
            break;
          case "GET":
            readDB(db, request);
            break;
          case 'PUT':
            updateDB(db, request);
            break;
          case 'DELETE':
            // delete(db, request);
            break;
          default:
            print("\$ Exception in http request processing");
        }
      } catch (err) {}
    } else {
      printAndSendHttpResponse(
        db,
        request,
        "${request.method}{ERROR: Unsupported API}",
      );
    }
  }
}

//request 라는 변수에 타입을 지정해주지 않고 var 라고 지정을 했기 때문에
//컴퓨터에서는 request가 어느 타입인지 모르게 된다.,-> dynamic 으로 임의로 지정함
//dynamic은 모든 타입을 담을 수 있어서 컴퓨터는 자동완성 지원 안함
void readDB(Map db, HttpRequest request) async {
  // request.uri : 요청한 주소
  // pathSegments : 요청한 주소에 작성이 되어있는 "/" 를 뜻함
  //                / 로 이후 값들을 분리해서 저장함.
  //                예를 들어서 127.0.0.1:4040/api/0001 이라는 주소가 있다면
  //                ["api", "0001"] 이렇게 / 마다 분리를 해줌
  // last : 마지막 데이터
  var key = request.uri.pathSegments.last; // "0001"
  var content, transaction;

  // db 변수가 key 를 현재 가지고 있냐?
  if (db.containsKey(key) == true) {
    transaction = {};
    transaction[key] = db[key];
    content = "Success < $transaction retrieved >";
  } else {
    content = "Fail < $key not-exist >";
  }

  printAndSendHttpResponse(db, request, content);
}

void updateDB(Map db, HttpRequest request) async {
  // 사용자가 API 를 사용할 때 ( SEND 버튼을 눌렀을 때 ) 사용자가 작성해준 데이터를 utf8.decoder 라는 친구한테 bind 기능을 이용해서
  // 사용자가 작성한 request 라는 요청을 utf8 형식으로 해독할거야.
  // 그걸 content 라는 변수에 담은 것임.
  var content = await utf8.decoder.bind(request).join();

  // transaction 에서는 해독된 데이터를 jsonDecode 라는 기능을 이용해서 한 번 더 해독을 할건데
  // decode = 해독하다 jsonDecode = json 형식으로 해독하는 기능
  // as Map = 우리가 해독해서 나온 결과값의 타입을 Map 으로 변경하겠다. 라는 의미를 가지고 있습니다.
  var transaction = jsonDecode(content) as Map;

  var key, value;
  // 사용자한테 key 를 입력 받아서 key 로 이루어져있는 데이터가 현재 우리의 db에 존재하는지 확인하기 위해서 선언을 함.

  print("\> content        : $content");

  // 사용자가 입력한 데이터를 key 와 value에 넣어주고 있음.
  //print("트랜잭션: $transaction");
  transaction.forEach((k, v) {
    print("$k,$v");
    key = k;
    value = v;
  });

  // db.containsKey(key) -> db 변수 안에 key 값에 해당하는 데이터가 있냐? 라는 조건문
  // if (db.containsKey("0001") == true) -> db 변수에 0001 이 키인 값이 있냐? 라는 조건문으로 해석할 수 있게 됨.
  if (db.containsKey(key) == true) {
    // db 변수의 0001 키의 값을 value 로 변경해라.
    db[key] = value;
    content = "Success < $transaction updated >";
  } else {
    content = "Fail < $key not-exist >";
  }
  printAndSendHttpResponse(db, request, content);
}

void deleteDB(var db, var request) async {
  var key = request.uri.pathSegments.last; //삭제할 데이터의 키를 / 이후의 문자열로 받음

  var content, value;

  if (db.containsKey(key) == true) {
    value = db[key];
    db.remove(key);
    content = "Success < {$key, $value} deleted >";
  } else {
    content = "Fail < $key not-exist >";
  }
  printAndSendHttpResponse(db, request, content);
}
