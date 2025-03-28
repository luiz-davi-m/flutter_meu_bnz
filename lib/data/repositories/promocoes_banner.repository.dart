import 'package:flutter_meu_bnz/domain/models/PromocaoBanner.dart';

class PromocaoBannerRepository {

  static List<Promocaobanner> listarPromocoesBannerAtivas() {
    return [
      Promocaobanner(
          id: 1,
          banner: "http://mercado.carrefour.com.br/_next/image?url=https%3A%2F%2Fcarrefourbrfood.vtexassets.com%2Fassets%2Fvtex.file-manager-graphql%2Fimages%2F86645206-25da-47dd-a03b-ca619d4d4ffe___a56690441ae1138f7b43e41de39ddb9c.png&w=1920&q=50",
          ativo: true,
      ),
      Promocaobanner(
        id: 1,
        banner: "https://mercado.carrefour.com.br/_next/image?url=https%3A%2F%2Fcarrefourbrfood.vtexassets.com%2Fassets%2Fvtex.file-manager-graphql%2Fimages%2Fa7839426-b3f5-4c2b-a4bd-351ba2c7a16a___3513cfe54334d820d77345a4a55fb98c.png&w=1920&q=50",
        ativo: true,
      ),
      Promocaobanner(
        id: 1,
        banner: "https://mercado.carrefour.com.br/_next/image?url=https%3A%2F%2Fcarrefourbrfood.vtexassets.com%2Fassets%2Fvtex.file-manager-graphql%2Fimages%2F1f3877b7-d6e9-40a4-a37e-a0fff3601aa0___51e81faeed2b2adfc4c0cb8762e9d3cd.jpg&w=1920&q=50",
        ativo: true,
      )
    ];
  }
}