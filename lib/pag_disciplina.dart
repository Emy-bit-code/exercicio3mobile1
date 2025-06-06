import 'package:flutter/material.dart';
import 'disciplina.dart';
import 'disciplina_dao.dart';

class PagDisciplina extends StatefulWidget {
  const PagDisciplina({super.key});

  @override
  _PagDisciplinaState createState() => _PagDisciplinaState();
}

class _PagDisciplinaState extends State<PagDisciplina> {
  final _dao = DisciplinaDAO();
  final _nomeController = TextEditingController();
  final _professorController = TextEditingController();
  List<Disciplina> _disciplinas = [];

  @override
  void initState() {
    super.initState();
    _loadDisciplinas();
  }

  void _loadDisciplinas() async {
    final disciplinas = await _dao.getAll();
    setState(() {
      _disciplinas = disciplinas;
    });
  }

  void _saveDisciplina() async {
    final nome = _nomeController.text;
    final professor = _professorController.text;
    if (nome.isNotEmpty && professor.isNotEmpty) {
      await _dao.insert(Disciplina(nome: nome, professor: professor));
      _nomeController.clear();
      _professorController.clear();
      _loadDisciplinas();
    }
  }

  void _deleteDisciplina(int id) async {
    await _dao.delete(id);
    _loadDisciplinas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Disciplinas')),
      body: Column(
        children: [
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: _professorController,
            decoration: InputDecoration(labelText: 'Professor'),
          ),
          ElevatedButton(
            onPressed: _saveDisciplina,
            child: Text('Salvar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _disciplinas.length,
              itemBuilder: (context, index) {
                final d = _disciplinas[index];
                return ListTile(
                  title: Text(d.nome),
                  subtitle: Text(d.professor),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteDisciplina(d.id!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
