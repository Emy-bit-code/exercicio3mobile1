
import 'package:sqflite/sqflite.dart';
import 'DatabaseHelper.dart';
import 'cursando.dart';

class CursandoDAO {
  Future<int> insert(Cursando cursando) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('cursando', cursando.toMap());
  }

  Future<List<Map<String, dynamic>>> getAllJoin() async {
    Database db = await DatabaseHelper.instance.database;
    return await db.rawQuery('''
      SELECT e.nome AS estudante, d.nome AS disciplina, d.professor
      FROM cursando c
      JOIN estudante e ON e.id = c.id_estudante
      JOIN disciplina d ON d.id = c.id_disciplina
    ''');
  }

  Future<int> delete(int idEstudante, int idDisciplina) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete(
      'cursando',
      where: 'id_estudante = ? AND id_disciplina = ?',
      whereArgs: [idEstudante, idDisciplina],
    );
  }
}
