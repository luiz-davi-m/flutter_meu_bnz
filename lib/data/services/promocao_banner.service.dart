import 'package:flutter_meu_bnz/data/repositories/promocoes_banner.repository.dart';
import 'package:flutter_meu_bnz/domain/models/PromocaoBanner.dart';
import '../repositories/produto.repository.dart';

class PromocaoBannerService {
  static List<Promocaobanner> listarPromocoesBannerAtivas() {
    return PromocaoBannerRepository.listarPromocoesBannerAtivas();
  }
}
