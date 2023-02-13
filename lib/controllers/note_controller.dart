import 'package:flutter/cupertino.dart';
import 'package:note_book/models/notes/note_model.dart';
import 'database_helper.dart';

class NoteController extends ChangeNotifier {
  final _dbInstance = DatabaseHelper.instance;

  List<NoteModel> _notes = <NoteModel>[];

  List<NoteModel> get notes => _notes;

  getAllNotes() async {
    List<Map<String, dynamic>>? data = await _dbInstance.getAllData();
    if (data != null) {
      _notes = data.map((e) => NoteModel.fromMap(e)).toList();
      notifyListeners();
    } else {
      _notes = List<NoteModel>.empty();
    }
  }

  Future<NoteModel> getNote(int id)async{
    var data = await _dbInstance.getDataById(id: id);
    NoteModel resData = NoteModel.fromMap(data!.first);
    return resData;
  }

  Future<int?> createEmptyNote(){
    return _dbInstance.createEmptyRow();
  }

  Future<int?> updateNote(NoteModel data,{required int id}){
    var rowData = {
      DatabaseHelper.columnTitle :data.title,
      DatabaseHelper.columnDescription : data.description
    };
    return _dbInstance.updateData(rowData: rowData,id: id);
  }

  Future<int?> deleteNote({required int id}){
    return _dbInstance.deleteData(id: id);
  }

  NoteModel _noteData = NoteModel();
  NoteModel get noteData => _noteData;

  getNoteData({required String title, required String desc}){
    _noteData = NoteModel(title: title,description: desc);
    notifyListeners();
  }
}
