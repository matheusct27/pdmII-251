import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer =
      gmail('braga.tabosa09@aluno.ifce.edu.br', 'pqep gccb grin myln');
  final message = Message()
    ..from = Address(
        'braga.tabosa09@aluno.ifce.edu.br', 'Matheus Braga')
    ..recipients.add('braga.tabosa09@aluno.ifce.edu.br') //Adicionando só uma pessoa.
    ..subject = 'Teste'
    ..text = 'Teste da avaliação 05 pdmII';

  try {
    // Envia o e-mail usando o servidor SMTP do Gmail
    for (int i = 1; i <= 30; i++){ // Enviando vários emails
      final resultado = await send(message, smtpServer);
      // Exibe o resultado do envio do e-mail
      print('E-mail enviado: ${resultado}');
    }
    
  } on MailerException catch (e) {
    // Exibe informações sobre erros de envio de e-mail
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}


