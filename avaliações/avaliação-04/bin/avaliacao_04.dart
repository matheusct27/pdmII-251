// Dart CLI application to interact with SQLite database
import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  // Open or create the sqlite database file
  final db = sqlite3.open('students.db');

  // Create table TB_ALUNO if it doesn't exist
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL CHECK(length(nome) <= 50)
    )
  ''');

  print('Bem-vindo ao Sistema de Cadastro de Alunos');
  while (true) {
    print('\nEscolha uma opção:');
    print('1. Inserir novo aluno');
    print('2. Listar alunos');
    print('3. Sair');
    stdout.write('Opção: ');
    final choice = stdin.readLineSync();

    if (choice == '1') {
      _inserirAluno(db);
    } else if (choice == '2') {
      _listarAlunos(db);
    } else if (choice == '3') {
      print('Saindo...');
      db.dispose();
      exit(0);
    } else {
      print('Opção inválida. Tente novamente.');
    }
  }
}

// Function to insert a new student
void _inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (máximo 50 caracteres): ');
  String? nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty) {
    print('Nome inválido. Operação cancelada.');
    return;
  }
  nome = nome.trim();
  if (nome.length > 50) {
    print('Nome muito longo. Máximo permitido: 50 caracteres.');
    return;
  }

  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?)');
  stmt.execute([nome]);
  stmt.dispose();

  print('Aluno "$nome" inserido com sucesso!');
}

// Function to read and list all students
void _listarAlunos(Database db) {
  final ResultSet result = db.select('SELECT id, nome FROM TB_ALUNO ORDER BY id ASC');

  if (result.isEmpty) {
    print('Nenhum aluno cadastrado.');
    return;
  }

  print('\nLista de alunos cadastrados:');
  for (final row in result) {
    print('ID: ${row['id']} - Nome: ${row['nome']}');
  }
}
