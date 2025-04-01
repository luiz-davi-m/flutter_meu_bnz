import 'package:flutter/material.dart';
import '../data/services/produto.service.dart';
import '../domain/models/Produto.dart';
import '../widgets/product_card.dart';

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
    'Frios',
    'Padaria',
    'Enlatados',
    'Alimento',
    'Proteinas',
    'Fruta',
  ];

  final List<Color> _coresFundo = [
    const Color(0xFFF5F9FF),
    const Color(0xFFF0FFF0),
  ];

  Future<List<Produto>> _carregarProdutos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ProdutoService.listarProdutos();
  }

  List<Produto> _filtrarProdutosPorCategoria(List<Produto> produtos) {
    return produtos.where((produto) {
      return produto.categoria?.toLowerCase() == _categoriaSelecionada.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF253885),
        toolbarHeight: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.menu, color: Colors.white),
        onPressed: _mostrarMenuFlutuante,
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
              FutureBuilder<List<Produto>>(
                future: _carregarProdutos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Erro ao carregar produtos"));
                  }

                  final produtos = snapshot.data ?? [];
                  final produtosFiltrados = _filtrarProdutosPorCategoria(produtos);

                  if (produtosFiltrados.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Nenhum produto de $_categoriaSelecionada disponível"),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _coresFundo[index % _coresFundo.length],
                          ),
                          child: ProductCard(
                            imageUrl: 'imagens/${produto.foto}',
                            title: produto.nome,
                            price: 'R\$ ${produto.preco.toStringAsFixed(2)}',
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarMenuFlutuante() {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx + 233,
        buttonPosition.dy + 380,
        buttonPosition.dx + button.size.width,
        buttonPosition.dy + button.size.height,
      ),
      items: [
        const PopupMenuItem(
          value: 'descontos',
          child: Row(
            children: [
              Icon(Icons.discount, color: Colors.blue),
              SizedBox(width: 10),
              Text('Descontos'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'jornal',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const JournalOfertasScreen()),
            );
          },
          child: const Row(
            children: [
              Icon(Icons.newspaper, color: Colors.blue),
              SizedBox(width: 10),
              Text('Jornal'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'perfil',
          child: Row(
            children: [
              Icon(Icons.person, color: Colors.blue),
              SizedBox(width: 10),
              Text('Perfil'),
            ],
          ),
        ),
      ],
    );
  }
}