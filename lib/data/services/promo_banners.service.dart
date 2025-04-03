

import 'package:flutter_meu_bnz/data/repositories/promo_banners.repository.dart';
import 'package:flutter_meu_bnz/domain/models/PromoBanner.dart';

class PromoBannerService {
  static Future<List<PromoBanner>> listarPromoBannersAtivos() {
    return PromoBannerRespository.listarPromoBannersAtivos();
  }
}
