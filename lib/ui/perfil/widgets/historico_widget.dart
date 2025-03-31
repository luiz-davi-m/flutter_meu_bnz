import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoricoWidget extends StatelessWidget {
  final String categoria;
  final DateTime dataResgate;
  final double valorResgate;

  HistoricoWidget({
    required this.categoria,
    required this.dataResgate,
    required this.valorResgate,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompra = categoria == "compra";
    String categoriaTexto = isCompra ? "Compra na loja" : "Troca por Vale Compras";
    Color valorColor = isCompra ? Colors.green : Colors.red;
    IconData icon = isCompra ? Icons.add : Icons.remove;

    String dataFormatada = DateFormat("dd/MM/yyyy HH:mm").format(dataResgate);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          // Data
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Image.asset(
                  'imagens/icones/date.png',
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 8),
                Text(
                  dataFormatada,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          // Categoria + Valor
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Categoria
                Text(
                  categoriaTexto,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),

                // Valor com Ícone
                Row(
                  children: [
                    Icon(icon, color: valorColor),
                    SizedBox(width: 4),
                    Text(
                      "R\$ ${valorResgate.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: valorColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
