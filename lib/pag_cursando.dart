
import 'package:flutter/material.dart';
import 'cursando_dao.dart';

class PagCursando extends StatefulWidget {
  const PagCursando({super.key});

  @override
  _PagCursandoState createState() => _PagCursandoState();
}

class _PagCursandoState extends State<PagCursando> {
  final _dao = CursandoDAO();
  List<Map<String, dynamic>> _relaciones = [];

  @override
  void initState() {
    super.initState();
    _loadRelaciones();
  }

  void _loadRelaciones() async {
    final datos = await _dao.getAllJoin();
    setState(() {
      _relaciones = datos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Estudiantes por Disciplina')),
      body: ListView.builder(
        itemCount: _relaciones.length,
        itemBuilder: (context, index) {
          final r = _relaciones[index];
          return ListTile(
            title: Text(r['estudante']),
            subtitle: Text('Disciplina: \${r['disciplina']} | Profesor: \${r['professor']}'),
          );
        },
      ),
    );
  }
}
