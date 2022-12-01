class ctcData {
  int id;
  String nome;

  ctcData(this.id, this.nome);

  Map toJson() => {'id': id, 'nome': nome};

  factory ctcData.fromJson(dynamic json) {
    return ctcData(json['id'] as int, json['nome'] as String);
  }
  @override
  String toString() {
    return '{${this.id}, ${this.nome}}';
  }
}
