import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meu_bnz/ui/home/home.dart';
import 'package:flutter_meu_bnz/ui/home/home_page_app.dart';
import 'package:flutter_meu_bnz/utils/widgets/float_action_button.dart';

import '../../domain/models/ResgateCashback.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPage();
}

class _PerfilPage extends State<PerfilPage> {

  final _formKey = GlobalKey<FormState>();
  final _cashbackController = TextEditingController();
  double _cashback = 150;
  List<ResgateCashback> _historicoResgatesCashback = [];

  @override
  void initState() {
    super.initState();
    _cashbackController.value = TextEditingValue(text: _cashback.toStringAsFixed(2));
    _historicoResgatesCashback = [
      ResgateCashback(
        categoria: 'compra',
        dataResgate: DateTime.now(),
        valorResgate: 75,
      ),
      ResgateCashback(
        categoria: 'compra',
        dataResgate: DateTime.now(),
        valorResgate: 75,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: MenuFloatingActionButton(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              color: Color(0xFF253885),
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, top: 80),
                        child: const Text(
                          "Minha conta",
                          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIconText("imagens/icones/notificacao.png", "Vale \nCompras", Colors.grey),
                      _buildIconText("imagens/icones/cashback.png", "CashBack", Color(0xFF253885)),
                      _buildIconText("imagens/icones/notificacao.png", "Meus \nCupons", Colors.grey),
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total em CashBack",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            print("Botão de ícone superior pressionado");
                          },
                          icon: Icon(Icons.info, color: Color(0xFF253885)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "R\$ ",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green), // Tamanho ajustado
                                ),
                                TextSpan(
                                  text: _cashback.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.green), // Tamanho ajustado
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF253885),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("Resgatar", style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height - 150,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.arrow_back),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Text(
                                                  "Resgate de Cashback",
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(right: 10),
                                              child: Icon(Icons.help_outline, color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 50),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 8,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Valor de Resgate",
                                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(height: 30),
                                              TextFormField(
                                                controller: _cashbackController,
                                                decoration: InputDecoration(
                                                  labelText: "Valor",
                                                  prefixText: "R\$ ",
                                                  prefixStyle: TextStyle(
                                                    fontSize: 30,
                                                      fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                                ],
                                                style: TextStyle(
                                                  fontSize: 60,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(0xFF253885),
                                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    final double? valorResgatar = double.tryParse(_cashbackController.text.replaceAll('R\$', '').trim());

                                                    if (valorResgatar != null && valorResgatar <= _cashback) {
                                                      _cashback -= valorResgatar;
                                                      _cashbackController.value = TextEditingValue(text: _cashback.toStringAsFixed(2));

                                                      _historicoResgatesCashback.add(
                                                        ResgateCashback(
                                                          categoria: 'troca',
                                                          dataResgate: DateTime.now(),
                                                          valorResgate: valorResgatar,
                                                        ),
                                                      );
                                                    }

                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Center(
                                                  child: Text("Resgatar Agora", style: TextStyle(color: Colors.white, fontSize: 16)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey.shade300),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.account_balance_wallet, color: Colors.blue, size: 30),
                                              SizedBox(width: 10),
                                              Text(
                                                "Carteira Digital",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/meus-dados.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Sorteios"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Meu Perfil");
                    },
                  ),
                  Divider(), // Linha separadora opcional
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/desconto.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Meus Descontos"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Histórico de Compras");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/pentagono.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Favoritos"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Configurações");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/documento.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Histórico"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Histórico");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/meus-dados.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Meus Dados"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Meus dados");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/notificacao.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Notificações"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Notificações");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/privacidade.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Privacidade"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Privacidade");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/mensagem.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Contato"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Contato");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/duvida.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Como funciona"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Como funciona");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Image.asset(
                      "imagens/icones/pentagono.png",
                      width: 24,
                      height: 24,
                      color: Color(0xFF253885),
                    ),
                    title: Text("Sobre nós"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF253885), size: 16),
                    onTap: () {
                      print("Clicou em Sobre nós");
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(String image, String label, Color color) {
    return Column(
      children: [
        Image.asset(image, width: 24,height: 24, color: color,),
        SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: color),
        ),
      ],
    );
  }
}
