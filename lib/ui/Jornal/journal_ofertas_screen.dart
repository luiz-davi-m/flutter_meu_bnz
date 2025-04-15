import 'package:flutter/material.dart';
import '../../data/services/produto_promocao.service.dart';
import '../../domain/models/ProdutoPromocao.dart';
import 'widgets/product_card.dart';
import 'package:flutter_meu_bnz/utils/widgets/float_action_button.dart';

class JournalOfertasScreen extends StatefulWidget {
  const JournalOfertasScreen({super.key});

  @override
  State<JournalOfertasScreen> createState() => _JournalOfertasScreenState();
}

class _JournalOfertasScreenState extends State<JournalOfertasScreen> {
  String _categoriaSelecionada = 'Limpeza';
  final List<String> _categorias = [
    'Limpeza',
    'Bebidas',
    'Laticinios',
    'Padaria',
    'Enlatados',
    'Alimento',
    'Carnes',
    'Mercearia',
    'Higiene',
    'Frutas',
  ];

  Future<List<ProdutoPromocao>> _carregarProdutosJornal() async {
    try {
      final produtos = await ProdutoPromocaoService.listarProdutos();

      return produtos.where((p) => p.precoPromocao != null)
          .map((p) => ProdutoPromocao(
        id: p.id,
        nome: p.nome,
        preco: p.preco,
        foto: p.foto,
        categoria: p.categoria,
        precoPromocao: p.precoPromocao!, percentualDesconto: ((p.preco - p.precoPromocao!) / p.preco) * 100,

      ))
          .toList();
    } catch (e) {
      debugPrint('Erro ao carregar produtos: $e');
      return [];
    }
  }

  List<ProdutoPromocao> _filtrarProdutosPorCategoria(List<ProdutoPromocao> produtos) {
    return produtos.where((produto) {
      return produto.categoria.toLowerCase() == _categoriaSelecionada.toLowerCase();
    }).toList();
  }

  double _calcularPercentualDesconto(double preco, double precoPromocao) {
    return ((preco - precoPromocao) / preco) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: MenuFloatingActionButton(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF253885),
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: const Text(
                  'Jornal de ofertas',
                  style: TextStyle(
                    color: Color(0xFF083DCC),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                height: 180,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Image.asset(
                    'imagens/mascote.png',
                    width: 218,
                    height: 191,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF083DCC), width: 1.5),
                  ),
                  child: DropdownButton<String>(
                    value: _categoriaSelecionada,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _categorias.map((String categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            categoria,
                            style: const TextStyle(
                              color: Color(0xFF253885),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? novaCategoria) {
                      if (novaCategoria != null) {
                        setState(() {
                          _categoriaSelecionada = novaCategoria;
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              FutureBuilder<List<ProdutoPromocao>>(
                future: _carregarProdutosJornal(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Erro ao carregar produtos: ${snapshot.error}"));
                  }

                  final produtos = snapshot.data ?? [];
                  final produtosFiltrados = _filtrarProdutosPorCategoria(produtos);

                  if (produtosFiltrados.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Nenhuma promoção disponível para $_categoriaSelecionada",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: produtosFiltrados.length,
                      itemBuilder: (context, index) {
                        final produto = produtosFiltrados[index];
                        final percentualDesconto = _calcularPercentualDesconto(
                            produto.preco,
                            produto.precoPromocao ?? produto.preco
                        );

                        return ProductCard(
                          imageUrl: produto.foto,
                          title: produto.nome,
                          price: produto.preco,
                          promoPrice: produto.precoPromocao,
                          discountPercentage: percentualDesconto,
                        );
                      },
                    ),
                  );
                },
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border(top: BorderSide(color: Colors.blue[100]!, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.storefront_rounded,
                        color: Colors.blue.shade800,
                        size: 26,
                      ),
                    ),
                    Text(
                      'Disponível em nossas lojas físicas',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}