import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/data/services/promo_banners.service.dart';
import 'package:flutter_meu_bnz/domain/models/PromoBanner.dart';
import 'package:flutter_meu_bnz/ui/home/widgets/card_produto_widget.dart';
import 'package:flutter_meu_bnz/ui/home/widgets/card_widget.dart';
import 'package:flutter_meu_bnz/ui/home/widgets/card_promocoes.dart';

import '../../data/services/produto.service.dart';
import '../../domain/models/Produto.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // AppBar
            Container(
              color: Color(0xFF253885),
              height: 210,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 15,
                      left: 15,
                      child: Image.asset(
                        'imagens/meu_bnz.jpg', // Caminho da imagem
                        height: 230,
                        width: 230,
                      ),
                    ),
                    Column(
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
                child: FutureBuilder<List<PromoBanner>>(
                  future: Future.delayed(Duration(milliseconds: 500), () async {
                    return PromoBannerService.listarPromoBannersAtivos();
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Erro ao carregar promoções"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("Nenhuma promoção disponível"));
                    }

                    final promoBanners = snapshot.data!;

                    return PageView.builder(
                      itemCount: promoBanners.length,
                      controller: PageController(viewportFraction: 0.8),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CardPromocao(imageUrl: promoBanners[index].banner),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            // Listagem de Produtos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: FutureBuilder<List<Produto>>(
                future: ProdutoService.listarProdutos(), // Chamada direta
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Erro ao carregar produtos"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("Nenhum produto disponível"));
                  }

                  final produtos = snapshot.data!;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: produtos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                    ),
                    itemBuilder: (context, index) {
                      return CardProduto(produto: produtos[index]);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 80),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1), // Borda preta fina
                  borderRadius: BorderRadius.circular(8), // Borda arredondada
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[800], size: 30), // Ícone
                      SizedBox(width: 8), // Espaço entre o ícone e o texto
                      Text(
                        "Ofertas válidas enquanto durarem os estoques!",
                        style: TextStyle(color: Colors.blue[800], fontSize: 16), // Texto em azul escuro
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

