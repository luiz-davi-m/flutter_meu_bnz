import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meu_bnz/data/services/historico_resgates.service.dart';
import 'package:flutter_meu_bnz/ui/home/home.dart';
import 'package:flutter_meu_bnz/ui/home/home_page_app.dart';
import 'package:flutter_meu_bnz/ui/perfil/widgets/historico_widget.dart';
import 'package:flutter_meu_bnz/utils/widgets/float_action_button.dart';
import 'package:flutter_meu_bnz/ui/Jornal/journal_ofertas_screen.dart';

import '../../data/services/configs.service.dart';
import '../../domain/models/ResgateCashback.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPage();
}

class _PerfilPage extends State<PerfilPage> {

  final _formKey = GlobalKey<FormState>();
  final _cashbackController = TextEditingController();
  double _cashback = 0;
  late Future<List<ResgateCashback>> _historicoFuture;

  @override
  void initState() {
    super.initState();
    _loadConfig();
    _loadHistoricos();
  }

  Future<void> _loadConfig() async {
    final config = await ConfigsService.configs();
    if (config != null) {
      setState(() {
        _cashback = config.cashback;
        _cashbackController.text = _cashback.toString();
      });
    }
  }

  Future<void> _loadHistoricos() async {
    setState(() {
      _historicoFuture = HistoricoResgateService.historicoResgates();
    });
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
                          icon: Image.asset(
                            'imagens/icones/historico.png',
                            color: Color(0xFF253885),
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {
                            _loadHistoricos();
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
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                          Text(
                                            "CashBack",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 48),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Container(
                                        padding: EdgeInsets.all(50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              blurRadius: 8,
                                              offset: Offset(0, 4)
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Histórico de Cashback",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "R\$ ${_cashback.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF253885),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Mar/25",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(Icons.keyboard_arrow_down, color: Colors.black),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Expanded(
                                        child: FutureBuilder<List<ResgateCashback>>(
                                          future: _historicoFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return Center(child: CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              return Center(child: Text("Erro ao carregar histórico"));
                                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                              return Center(child: Text("Nenhum histórico disponível"));
                                            }

                                            final historicoResgate = snapshot.data!;

                                            return ListView.builder(
                                              itemCount: historicoResgate.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  child: HistoricoWidget(
                                                    categoria: historicoResgate[index].categoria,
                                                    dataResgate: historicoResgate[index].dataResgate,
                                                    valorResgate: historicoResgate[index].valorResgate,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        )
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                                ),
                                TextSpan(
                                  text: _cashback.toStringAsFixed(1),
                                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green),
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
                                                onPressed: () async {
                                                  final double? valorResgatar = double.tryParse(
                                                    _cashbackController.text.replaceAll('R\$', '').trim(),
                                                  );

                                                  if (valorResgatar != null && valorResgatar <= _cashback) {
                                                    final novoCashback = _cashback - valorResgatar;

                                                    await ConfigsService.atualizarCashback(novoCashback);

                                                    await HistoricoResgateService.registrarResgate('troca', valorResgatar);

                                                    setState(() {
                                                      _cashback = novoCashback;
                                                      _cashbackController.text = _cashback.toStringAsFixed(2);
                                                    });

                                                    _loadConfig();

                                                    Navigator.pop(context);
                                                  }
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
                  Divider(),
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
