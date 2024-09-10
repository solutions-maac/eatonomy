

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

import 'package:logger/logger.dart';

import '../../Data/Model/ChatHistoryHive/history.dart';
class HiveService extends ChangeNotifier{
  List<History> _history = [];
  UnmodifiableListView<History> get notes => UnmodifiableListView(_history);
  final String noteHiveBox = 'history-box';


  // Create new note
  Future<void> createItem(History history) async {
    Box<History> box = await Hive.openBox<History>(noteHiveBox);
    await box.add(history);
    _history.add(history);
    _history = box.values.toList();
    notifyListeners();
  }



  // Get notes
  Future<List<History>> getItems() async {
    Box<History> box = await Hive.openBox<History>(noteHiveBox);
    _history = box.values.toList();

    notifyListeners();
    return _history;
  }


  // remove a note
  Future<void> removeItem(History history) async {
    Box<History> box = await Hive.openBox<History>(noteHiveBox);
    await box.delete(history.key);
    _history = box.values.toList();
    notifyListeners();
  }




}