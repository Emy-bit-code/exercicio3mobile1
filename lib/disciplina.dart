
class Disciplina {
  int? id;
  String nome;
  String professor;

  Disciplina({this.id, required this.nome, required this.professor});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'professor': professor,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Disciplina.fromMap(Map<String, dynamic> map) {
    return Disciplina(
      id: map['id'],
      nome: map['nome'],
      professor: map['professor'],
    );
  }
}
