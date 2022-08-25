import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class data_con {
  final String name;
  final String token;
  final String description;
  final String createdAt;

  data_con(
      {required this.name,
      required this.token,
      required this.description,
      required this.createdAt});

  factory data_con.fromJson(Map<String, dynamic> json) {
    return data_con(
      name: json['name'],
      token: json['tokenName'],
      description: json['description'],
      createdAt: json['createdAt'],
    );
  }
}
// https://dev.uneva.in/task_721/list.php

getadata() async {
  final response =
      await http.get(Uri.https('dev.uneva.in', 'task_721/list.php'));
  var jsondata = jsonDecode(response.body);
  // print(jsondata);
  List<data_con> Data_cons = [];
  for (var api in jsondata) {
    final DateFormat formatter = DateFormat('dd-MMM HH:mm a');

    DateTime? time = DateTime.tryParse(api['createdAt']);
    var token1 = api['tokenName'];

    data_con Data_con = data_con(
      name: api['name'],
      token: token1,
      description: api['description'],
      createdAt: formatter.format(time!),
    );

    Data_cons.add(Data_con);
  }
  // print(Data_cons.length);
  return Data_cons;
}