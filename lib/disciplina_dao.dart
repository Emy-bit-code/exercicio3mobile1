
import 'package:sqflite/sqflite.dart';
import 'DatabaseHelper.dart';
import 'disciplina.dart';

class DisciplinaDAO {
  Future<int> insert(Disciplina disciplina) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('disciplina', disciplina.toMap());
  }

  Future<List<Disciplina>> getAll() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query('disciplina');
    return maps.map((map) => Disciplina.fromMap(map)).toList();
  }

  Future<int> update(Disciplina disciplina) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update(
      'disciplina',
      disciplina.toMap(),
      where: 'id = ?',
      whereArgs: [disciplina.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete('disciplina', where: 'id = ?', whereArgs: [id]);
  }
}
