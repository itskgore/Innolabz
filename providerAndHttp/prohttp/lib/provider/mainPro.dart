import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prohttp/const/apiUrl.dart';
import 'package:prohttp/models/dogModel.dart';

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
      _dogImageList.clear();
      final result = json.decode(response.body) as Map<String, dynamic>;
      _dogImageList.add(DogImage.fromJson(result));
      notify();
    } else {
      // error
    }
  }

  changeDogImage(Map<String, dynamic> dogImage) {}

  notify() {
    notifyListeners();
  }

  // MODEL REFERENCE

  List<DogImage> _dogImageList = [];
  List<DogImage> get dogImageList {
    return [..._dogImageList];
  }
}
