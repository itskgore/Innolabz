import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prohttp/const/apiUrl.dart';

enum Gender { MALE, FEMALE, NOTSAY }
enum DEPART { DEV, HR, MANAGER }

class MainPro with ChangeNotifier {
  Gender gender = Gender.MALE;
  changeGender(Gender gen) {
    gender = gen;
    notify();
  }

  bool isEmployed = true;
  changeEmpy(bool emp) {
    isEmployed = emp;
    notify();
  }

  DEPART depart = DEPART.DEV;
  changeDepartment(DEPART dep) {
    depart = dep;
    notify();
  }

  String dogImg;
  Future<Map<String, dynamic>> getDogApi() async {
    final response = await http.get(ApiUrl.dogsApi);
    if (response.statusCode == 200) {
      final result = json.decode(response.body) as List<dynamic>;
      print(result);
      print(response.body);
      // Model
    } else {
      // error
    }
  }

  notify() {
    notifyListeners();
  }
}
