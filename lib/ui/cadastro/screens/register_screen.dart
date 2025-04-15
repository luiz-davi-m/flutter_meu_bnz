import 'package:flutter/material.dart';
import '../../../data/services/usuario.service.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../widgets/custom_input_field.dart';
import 'package:flutter_meu_bnz/ui/Login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController cpfCnpjController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();
  final TextEditingController _nomeCompletoController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    cpfCnpjController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    _nomeCompletoController.dispose();
    _generoController.dispose();
    _dataNascimentoController.dispose();
    _telefoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? validateCpfCnpj(String? value) {
    if (value == null || value.isEmpty) return 'CPF/CNPJ é obrigatório';

    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.length < 11) return 'CPF/CNPJ inválido';
    return null;
  }

  String formatCpf(String? value) {
    if (value == null) return '';

    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length > 9) {
      return '${cleaned.substring(0, 3)}.${cleaned.substring(3, 6)}.${cleaned.substring(6, 9)}-${cleaned.substring(9)}';
    }
    return value;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

 String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'E-mail é obrigatório';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? validateBirthDate(String? value) {
    if (value == null || value.isEmpty) return 'Data de nascimento é obrigatória';
    if (!UsuarioService.validarDataNascimento(value)) return 'Data inválida';

    return null;
  }

  Future<void> _submitForm() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (senhaController.text != confirmarSenhaController.text) {
      setState(() {
        _errorMessage = 'As senhas não coincidem';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final cpfCnpj = cpfCnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final telefone = _telefoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final dataNascimento = _dataNascimentoController.text;

      final usuario = await UsuarioService.registrar(
        cpf: cpfCnpj,
        senha: senhaController.text,
        nomeCompleto: _nomeCompletoController.text,
        genero: _generoController.text,
        dataNascimento: dataNascimento,
        telefone: telefone,
        email: emailController.text,
      );

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 390),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.border,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: AppColors.textPrimary,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 19),
                      Text('Cadastrar', style: AppTextStyles.title),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              _errorMessage!,
                              style: AppTextStyles.body.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ),

                        Center(
                          child: Image.asset(
                            "imagens/icones/imgLogin.png",
                            width: 102,
                            height: 129,
                          ),
                        ),
                        const SizedBox(height: 27),
                        Text(
                          'Para receber descontos você precisa cadastrar-se.',
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: cpfCnpjController,
                          label: 'CPF/CNPJ',
                          fieldType: 'cpfCnpj',
                          required: true,
                          validator: validateCpfCnpj,
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: _nomeCompletoController,
                          label: 'Nome completo',
                          required: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nome completo é obrigatório';
                            }
                            if (value.trim().split(' ').length < 2) {
                              return 'Informe nome e sobrenome';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: _generoController,
                          label: 'Gênero',
                          required: true,
                          isDropdown: true,
                          dropdownItems: const [
                            'Masculino',
                            'Feminino',
                            'Outro',
                            'Prefiro não informar',
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Gênero é obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: _dataNascimentoController,
                          label: 'Data de Nascimento',
                          fieldType: 'date',
                          required: true,
                          validator: validateBirthDate,
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: _telefoneController,
                          label: 'Telefone',
                          fieldType: 'phone',
                          required: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Telefone é obrigatório';
                            }
                            final telefoneLimpo = value.replaceAll(RegExp(r'[^0-9]'), '');
                            if (telefoneLimpo.length < 10) {
                              return 'Telefone inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: emailController,
                          label: 'E-mail',
                          required: true,
                          validator: validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: senhaController,
                          label: 'Senha',
                          required: true,
                          obscureText: true,
                          validator: validatePassword,
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: confirmarSenhaController,
                          label: 'Confirmação de senha',
                          required: true,
                          obscureText: true,
                          showInfo: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirmação de senha é obrigatória';
                            }
                            if (value != senhaController.text) {
                              return 'As senhas não coincidem';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 34),

                        Center(
                          child: SizedBox(
                            width: 230,
                            height: 42,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 4,
                                shadowColor: AppColors.buttonShadow,
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                                  : Text(
                                'Próximo',
                                style: AppTextStyles.button,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}