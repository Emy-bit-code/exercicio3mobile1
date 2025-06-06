import 'package:flutter/material.dart';
import 'estudante.dart';
import 'disciplina.dart';
import 'estudante_dao.dart';
import 'disciplina_dao.dart';
import 'cursando_dao.dart';

class PagCursa extends StatefulWidget {
  const PagCursa({super.key});

  @override
  _PagCursaState createState() => _PagCursaState();
}

class _PagCursaState extends State<PagCursa> {
  final _estudanteDAO = EstudanteDAO();
  final _disciplinaDAO = DisciplinaDAO();
  final _cursandoDAO = CursandoDAO();

  int? _selectedEstudanteId;
  int? _selectedDisciplinaId;

  List<Estudante> _estudantes = [];
  List<Disciplina> _disciplinas = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final estudantes = await _estudanteDAO.getAll();
    final disciplinas = await _disciplinaDAO.getAll();
    setState(() {
      _estudantes = estudantes;
      _disciplinas = disciplinas;
    });
  }

  void _saveRelacion() async {
    if (_selectedEstudanteId != null && _selectedDisciplinaId != null) {
      await _cursandoDAO.insert(_selectedEstudanteId!, _selectedDisciplinaId!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Asignación guardada.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asignar Disciplina a Estudante')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Estudante'),
              items: _estudantes.map((e) {
                return DropdownMenuItem<int>(
                  value: e.id,
                  child: Text(e.nome),
                );
              }).toList(),
              onChanged: (value) =>
                  setState(() => _selectedEstudanteId = value),
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Disciplina'),
              items: _disciplinas.map((d) {
                return DropdownMenuItem<int>(
                  value: d.id,
                  child: Text(d.nome),
                );
              }).toList(),
              onChanged: (value) =>
                  setState(() => _selectedDisciplinaId = value),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveRelacion,
              child: Text('Guardar Asignación'),
            ),
          ],
        ),
      ),
    );
  }
}
