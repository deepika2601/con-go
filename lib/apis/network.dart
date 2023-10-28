import 'dart:convert';
import 'package:congobonmarche/main.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Service {
  final Map<String, dynamic> body;
  final String loginURL;

  Service(this.loginURL, this.body);

  Future data() async {
    print(loginURL);
    print(jsonEncode(body));
    Response response = await post(Uri.parse(loginURL), body: jsonEncode(body));
    print(response.body);
    var status = jsonDecode(response.body);
    print('dasss' + status.toString());
    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      return {
        "error": status['Message'],
      };
    }
  }

  Future formdata() async {
    print(loginURL);
    print(jsonEncode(body));
    Response response = await post(Uri.parse(loginURL), body: (body));
    print(response.body);
    var status = jsonDecode(response.body);
    print('dasss' + status.toString());
    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else if (status['status'].toString().toLowerCase() == 'error') {
      return {
        "status": "error",
      };
    } else {
      return {
        "error": status['message'],
      };
    }
  }
}

class ServiceWithHeader {
  final String loginURL;

  ServiceWithHeader(
    this.loginURL,
  );

  Future data() async {
    print(loginURL);
    print(MyApp.AUTH_TOKEN_VALUE);
    print('Bearer ${MyApp.AUTH_TOKEN_VALUE?.trim()}');
    final response = await http.get(Uri.parse(loginURL), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${MyApp.AUTH_TOKEN_VALUE?.trim()}',
    });
    print(loginURL);
    print(response.body);
    var status = jsonDecode(response.body);
    print('heee' + status['status'].toString());
    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return {
        "error": status['Message'],
      };
    }
  }

  Future postdatawithoutbody() async {
    print(loginURL);
    print(MyApp.AUTH_TOKEN_VALUE);
    final response = await http.post(Uri.parse(loginURL), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${MyApp.AUTH_TOKEN_VALUE}',
    });
    print(loginURL);
    print(response.body);
    var status = jsonDecode(response.body);
    print('heee' + status['status'].toString());
    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return {
        "error": status['message'],
      };
    }
  }
}

class ServiceWithoutbody {
  final String url;
  ServiceWithoutbody(this.url);
  Future data() async {
    final response = await http.get(
      Uri.parse(url),
      //  header('Content-type: application/json');
    );
    print(url);
    print(response.body);
    var status = jsonDecode(response.body);
    print('heee' + status['status'].toString());

    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      return jsonDecode(data);
    } else if (status['status'].toString().toLowerCase() == 'error') {
      return {
        "error": "error",
      };
    } else if (response.statusCode == 500) {
    } else {
      return {
        "error": status['Message'],
      };
    }
  }

  Future datapost() async {
    final response = await http.post(
      Uri.parse(url),
      //  header('Content-type: application/json');
    );
    print(url);
    print(response.body);
    var status = jsonDecode(response.body);
    print('heee' + status['status'].toString());

    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      String data = response.body;
      return jsonDecode(data);
    } else if (status['status'].toString().toLowerCase() == 'error') {
      return {
        "error": "error",
      };
    } else if (response.statusCode == 500) {
    } else {
      return {
        "error": status['Message'],
      };
    }
  }

  Future dataoutputint() async {
    final response = await http.get(
      Uri.parse(url),
    );
    var status = jsonDecode(response.body);
    // print('heee' + status['Status'].toString());
    if (status['status'].toString().toUpperCase() == 'SUCCESS' ||
        status['status'].toString().toUpperCase() == 'TRUE') {
      if (response.body != null) {
        var data = response.body;
        return jsonDecode(data);
      }
    } else {
      return {
        "error": status['Message'],
      };
    }
  }
}
