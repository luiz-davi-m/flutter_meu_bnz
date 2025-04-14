import 'package:flutter/material.dart';
import '../../../data/services/usuario.service.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../widgets/custom_input_field.dart';
import 'package:flutter_meu_bnz/ui/Login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cpfCnpjController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  final TextEditingController _nomeCompletoController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _cpfCnpjController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _nomeCompletoController.dispose();
    _generoController.dispose();
    _dataNascimentoController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_senhaController.text != _confirmarSenhaController.text) {
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
      final cpfCnpj = _cpfCnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final telefone = _telefoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final dataNascimento = _dataNascimentoController.text;

      final usuario = await UsuarioService.registrar(
        cpf: cpfCnpj,
        senha: _senhaController.text,
        nomeCompleto: _nomeCompletoController.text,
        genero: _generoController.text,
        dataNascimento: dataNascimento,
        telefone: telefone,
        email: _emailController.text,
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
                    key: _formKey,
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
                          controller: _cpfCnpjController,
                          label: 'CPF/CNPJ',
                          fieldType: 'cpfCnpj',
                          required: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CPF/CNPJ é obrigatório';
                            }
                            final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
                            if (digitsOnly.length == 11) {
                              if (!UsuarioService.validarCpf(digitsOnly)) {
                                return 'CPF inválido';
                              }
                            } else if (digitsOnly.length == 14) {
                              if (!UsuarioService.validarCnpj(digitsOnly)) {
                                return 'CNPJ inválido';
                              }
                            } else {
                              return 'CPF/CNPJ inválido';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Data de nascimento é obrigatória';
                            }
                            if (!UsuarioService.validarDataNascimento(value)) {
                              return 'Data inválida';
                            }
                            return null;
                          },
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
                          controller: _emailController,
                          label: 'E-mail',
                          required: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'E-mail é obrigatório';
                            }
                            if (!UsuarioService.validarEmail(value)) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: _senhaController,
                          label: 'Senha',
                          required: true,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Senha é obrigatória';
                            }
                            if (value.length < 6) {
                              return 'Senha deve ter pelo menos 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 26),

                        CustomInputField(
                          controller: _confirmarSenhaController,
                          label: 'Confirmação de senha',
                          required: true,
                          obscureText: true,
                          showInfo: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirmação de senha é obrigatória';
                            }
                            if (value != _senhaController.text) {
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