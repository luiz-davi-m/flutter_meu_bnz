import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/ui/home/widgets/card_widget.dart';
import 'package:flutter_meu_bnz/ui/home/widgets/card_promocoes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> promoImages = [
    "http://mercado.carrefour.com.br/_next/image?url=https%3A%2F%2Fcarrefourbrfood.vtexassets.com%2Fassets%2Fvtex.file-manager-graphql%2Fimages%2F86645206-25da-47dd-a03b-ca619d4d4ffe___a56690441ae1138f7b43e41de39ddb9c.png&w=1920&q=50",
    "https://mercado.carrefour.com.br/_next/image?url=https%3A%2F%2Fcarrefourbrfood.vtexassets.com%2Fassets%2Fvtex.file-manager-graphql%2Fimages%2Fa7839426-b3f5-4c2b-a4bd-351ba2c7a16a___3513cfe54334d820d77345a4a55fb98c.png&w=1920&q=50",
    "https://mercado.carrefour.com.br/_next/image?url=https%3A%2F%2Fcarrefourbrfood.vtexassets.com%2Fassets%2Fvtex.file-manager-graphql%2Fimages%2F1f3877b7-d6e9-40a4-a37e-a0fff3601aa0___51e81faeed2b2adfc4c0cb8762e9d3cd.jpg&w=1920&q=50"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // AppBar
            Container(
              color: Color(0xFF35478E),
              height: 210,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              print('Ajuda');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              print('Notificações');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.search),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              print('Pesquisa');
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Ler Qrcode",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            icon: const Icon(Icons.qr_code),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              print('Abrir QR Code Scanner');
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: const Text(
                          "Olá, Usuário da Silva Texeira",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Cards de descontos, cupons e cashback
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 0),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CardItem(icon: Icons.attach_money, title: "Você já economizou:", value: "R\$ 1.200,00"),
                      SizedBox(width: 16),
                      CardItem(icon: Icons.card_giftcard, title: "Saldo Vale-Compra", value: "R\$ 500,00"),
                      SizedBox(width: 16),
                      CardItem(icon: Icons.redeem, title: "Saldo CashBack", value: "R\$ 150,00"),
                      SizedBox(width: 16),
                      CardItem(icon: Icons.confirmation_number, title: "Cupons Sorteio", value: "5 cupons"),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
            ),
            // Banners de promoções
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 130,
                child: PageView.builder(
                  itemCount: promoImages.length,
                  controller: PageController(viewportFraction: 0.8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CardPromocao(imageUrl: promoImages[index]),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

