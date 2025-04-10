import 'package:flutter/material.dart';
import '../../../domain/models/Produto.dart';

class CardProduto extends StatelessWidget {
  final Produto produto;

  const CardProduto({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFFE5E5), // Vermelho bem clarinho
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Compre e \nReceba",
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${produto.percentualDesconto}%",
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "em saldo \nno app",
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // Imagem do produto
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "imagens/${produto.foto}",
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 8), // Ajuste no espaçamento
          // Nome do produto
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              produto.nome,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black), // Diminuído o tamanho da fonte
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 4), // Ajuste no espaçamento
          // Preço com desconto
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "R\$ ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green), // Tamanho ajustado
                ),
                TextSpan(
                  text: produto.precoComDesconto.toStringAsFixed(2),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green), // Tamanho ajustado
                ),
              ],
            ),
          ),
          // Expiração e detalhes do produto
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400], // Botão cinza
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4), // Diminuído o padding
                  ),
                  child: Text(
                    "Expira em 10 dias",
                    style: TextStyle(color: Colors.white, fontSize: 12), // Diminuído o tamanho da fonte
                  ),
                ),
                SizedBox(height: 4), // Ajuste no espaçamento
                Text(
                  "Confira os detalhes",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



