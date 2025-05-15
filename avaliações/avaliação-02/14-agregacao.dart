
import 'dart:convert';
class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }
}

void main() {
    Dependente d1 = Dependente("Ana");
    Dependente d2 = Dependente("Bia");
    Dependente d3 = Dependente("Cecilia");
    Dependente d4 = Dependente("Diana");
    
    Funcionario f1 = Funcionario("João", [d1, d2]);
    Funcionario f2 = Funcionario("Maria", [d3, d4]);
    
    EquipeProjeto equipe = EquipeProjeto("Projeto A", [f1, f2]);
    
    print(jsonEncode(equipe));
}