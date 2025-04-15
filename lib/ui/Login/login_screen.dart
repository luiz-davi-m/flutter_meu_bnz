import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../ui/Login/widgets/custom_button.dart';
import '../../ui/Login/widgets/custom_text_field.dart';
import '../../data/services/usuario.service.dart';
import '../home/home_page_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final cpfCnpjController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;

  String formatCpfCnpj(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.length <= 11) { // CPF
      if (cleaned.length > 9) {
        return '${cleaned.substring(0, 3)}.${cleaned.substring(3, 6)}.${cleaned.substring(6, 9)}-${cleaned.substring(9)}';
      } else if (cleaned.length > 6) {
        return '${cleaned.substring(0, 3)}.${cleaned.substring(3, 6)}.${cleaned.substring(6)}';
      } else if (cleaned.length > 3) {
        return '${cleaned.substring(0, 3)}.${cleaned.substring(3)}';
      }
    } else {
      if (cleaned.length > 12) {
        return '${cleaned.substring(0, 2)}.${cleaned.substring(2, 5)}.${cleaned.substring(5, 8)}/${cleaned.substring(8, 12)}-${cleaned.substring(12)}';
      } else if (cleaned.length > 8) {
        return '${cleaned.substring(0, 2)}.${cleaned.substring(2, 5)}.${cleaned.substring(5, 8)}/${cleaned.substring(8)}';
      } else if (cleaned.length > 5) {
        return '${cleaned.substring(0, 2)}.${cleaned.substring(2, 5)}.${cleaned.substring(5)}';
      } else if (cleaned.length > 2) {
        return '${cleaned.substring(0, 2)}.${cleaned.substring(2)}';
      }
    }
    return cleaned;
  }


  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 6) {
      return 'Mínimo 6 caracteres';
    }
    return null;
  }

  void _onCpfCnpjChanged(String value) {
    final cursorPosition = cpfCnpjController.selection.start;
    final formatted = formatCpfCnpj(value);

    cpfCnpjController.value = cpfCnpjController.value.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: cursorPosition + (formatted.length - value.length),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _showTopErrorMessage(String message) {
    _removeErrorMessage();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 30,
        left: 20,
        right: 20,
        child: Material(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[600],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  onPressed: _removeErrorMessage,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    Future.delayed(const Duration(seconds: 4), _removeErrorMessage);
  }

  void _removeErrorMessage() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {

        final cpfCnpj = cpfCnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');
        final senha = _passwordController.text;

        final usuario = await UsuarioService.autenticar(cpfCnpj, senha);

        if (usuario != null) {
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePageApp()),
                  (Route<dynamic> route) => false,
            );
          }
        } else {
          _showTopErrorMessage('CPF/CNPJ ou senha incorretos');
        }
      } catch (e) {
        _showTopErrorMessage('Erro ao fazer login: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    cpfCnpjController.addListener(() {
      final text = cpfCnpjController.text;
      if (text.isNotEmpty) {
        _onCpfCnpjChanged(text);
      }
    });
  }

  @override
  void dispose() {
    _removeErrorMessage();
    cpfCnpjController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 800;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEFF2FF)],
          ),
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF35478E),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/90149625881bed76ba94c301a1441943279ddb2d',
                      width: screenSize.width * 0.3,
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    Text(
                      'Preencha com seus dados para entrar',
                      style: TextStyle(
                        fontSize: isLargeScreen ? 20 : 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.05),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '* ',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: 'CPF/CNPJ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.015),
                    CustomTextField(
                      controller: cpfCnpjController,
                      width: double.infinity,
                      hint: 'Digite seu CPF ou CNPJ',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(18),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                        if (cleanedValue.length < 11) {
                          return 'CPF/CNPJ inválido';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: screenSize.height * 0.04),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '* ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18),
                            ),
                            TextSpan(
                              text: 'Senha',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.015),
                    CustomTextField(
                      controller: _passwordController,
                      width: double.infinity,
                      hint: 'Digite sua senha',
                      isPassword: _obscurePassword,
                      validator: validatePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    const Text(
                      'Os campos com * são obrigatórios',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.05),

                    CustomButton(
                      text: 'Entrar',
                      width: double.infinity,
                      onPressed: _isLoading ? null : _login,
                    ),
                    SizedBox(height: screenSize.height * 0.04),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _isLoading ? null : () {},
                          child: const Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              color: Color(0xFF35478E),
                            ),
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.05),
                        TextButton(
                          onPressed: _isLoading ? null : () {},
                          child: const Text(
                            'Cadastrar-se',
                            style: TextStyle(
                              color: Color(0xFF35478E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}