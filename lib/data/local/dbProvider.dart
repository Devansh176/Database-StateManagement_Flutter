import 'package:flutter/widgets.dart';
import 'package:practice2/data/local/db_connection.dart';

class DBProvider extends ChangeNotifier {
  final DBConnection dbConnection;

  DBProvider({required this.dbConnection});

  List<Map<String, dynamic>> _data = [];

  List<Map<String, dynamic>> get getNotes => _data;

  Future<void> addNote(String title, String desc) async {
    bool check = await dbConnection.addNote(
      title: title,
      desc: desc,
    );
    if (check) {
      _data = await dbConnection.getAllNotes();
      notifyListeners();
    }
  }

  Future<void> updateNote(String title, String desc, int sno) async {
    bool check = await dbConnection.updateNote(
      title: title,
      desc: desc,
      sno: sno,
    );
    if (check) {
      _data = await dbConnection.getAllNotes();
      notifyListeners();
    }
  }

  Future<void> deleteNote(int sno) async {
    bool check = await dbConnection.deleteNote(sno: sno);
    if (check) {
      _data = await dbConnection.getAllNotes();
      notifyListeners();
    }
  }


  Future<void> getInitialNotes() async {
    _data = await dbConnection.getAllNotes();
    print("Fetched notes: $_data"); // Debugging line
    notifyListeners();
  }
}
