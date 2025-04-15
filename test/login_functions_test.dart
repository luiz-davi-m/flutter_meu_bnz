import 'package:flutter_test/flutter_test.dart';
import '../lib/ui/Login/login_screen.dart';

void main() {
  group('Validações de formatação para CPF e CNPJ', () {
    test('Deve formatar corretamente um CPF com 11 dígitos', () {
      final screen = LoginScreen();
      final state = screen.createState() as LoginScreenState;

      expect(state.formatCpfCnpj('12345678901'), equals('123.456.789-01'));
    });

    test('Deve formatar corretamente um CNPJ com 14 dígitos', () {
      final screen = LoginScreen();
      final state = screen.createState() as LoginScreenState;

      expect(state.formatCpfCnpj('12345678000190'), equals('12.345.678/0001-90'));
    });
  });

  group('Validação de senha', () {
    test('Deve retornar erro ao validar uma senha vazia', () {
      final screen = LoginScreen();
      final state = screen.createState() as LoginScreenState;

      expect(state.validatePassword(''), equals('Campo obrigatório'));
    });

    test('Deve retornar erro para senha com menos de 6 caracteres', () {
      final screen = LoginScreen();
      final state = screen.createState() as LoginScreenState;

      expect(state.validatePassword('sen1'), equals('Mínimo 6 caracteres'));
    });

  });

}