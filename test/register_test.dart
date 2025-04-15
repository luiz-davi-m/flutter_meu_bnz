import 'package:flutter_test/flutter_test.dart';
import '../lib/ui/cadastro/screens/register_screen.dart';

void main() {
  group('Testes de Validação', () {
    late RegisterScreenState state;

    setUp(() {
      state = RegisterScreen().createState();
    });

    test('Validação de CPF/CNPJ', () {
      expect(state.validateCpfCnpj(null), 'CPF/CNPJ é obrigatório');
      expect(state.validateCpfCnpj(''), 'CPF/CNPJ é obrigatório');
      expect(state.validateCpfCnpj('123'), 'CPF/CNPJ inválido');
      expect(state.validateCpfCnpj('529.982.247-25'), isNull);
    });

    test('Formatação de CPF', () {
      expect(state.formatCpf(null), '');
      expect(state.formatCpf('52998224725'), '529.982.247-25');
      expect(state.formatCpf('123'), '123');
    });

    test('Validação de Senha', () {
      state.senhaController.text = 'senha123';
      state.confirmarSenhaController.text = 'senha123';

      expect(state.validatePassword(null), 'Senha é obrigatória');
      expect(state.validatePassword('123'), 'Senha deve ter pelo menos 6 caracteres');
      expect(state.validatePassword('senha123'), isNull);
    });

    group('Validação de Email e Data', () {
      late RegisterScreenState state;

      setUp(() {
        state = RegisterScreen().createState();
      });

      test('Validação de Email - Formato válido', () {
        expect(state.validateEmail(null), 'E-mail é obrigatório');
      });

      test('Validação de Email - Formato inválido', () {
        expect(state.validateEmail('emailinvalido'), 'E-mail inválido');
      });

      test('Validação de Data - Formato válido', () {
        expect(state.validateBirthDate('01/01/2000'), null);
      });

      test('Validação de Data - Formato inválido', () {
        expect(state.validateBirthDate( '32/02/2000'), 'Data inválida');
      });
    });
  });
}