import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/ui/home/home.dart';
import 'package:flutter_meu_bnz/ui/home/home_page_app.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPage();
}

class _PerfilPage extends State<PerfilPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          final RenderBox button = context.findRenderObject() as RenderBox;
          final Offset buttonPosition = button.localToGlobal(Offset.zero);
          final double buttonHeight = button.size.height;
          final double buttonWidth = button.size.width;

          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              buttonPosition.dx + buttonWidth - 50,
              buttonPosition.dy + buttonHeight - 233,
              0.0,
              0.0,
            ),
            items: [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.discount, color: Colors.blue),
                    SizedBox(width: 10),
                    Text('Descontos'),
                  ],
                ),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  });
                },
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.newspaper, color: Colors.blue),
                    SizedBox(width: 10),
                    Text('Jornal'),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  print('Jornal');
                },
              ),
            ],
          );
        },
      ),
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
                                  text: '150',
                                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.green), // Tamanho ajustado
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print("Resgatar cashback");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF253885),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Ajuste o valor aqui para bordas menos arredondadas
                              ),
                            ),
                            child: Text("Resgatar", style: TextStyle(color: Colors.white)),
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
