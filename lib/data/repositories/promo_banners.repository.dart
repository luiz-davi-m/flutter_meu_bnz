import 'package:flutter_meu_bnz/domain/models/PromoBanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PromoBannerRespository {
  static final _supabase = Supabase.instance.client;

  static Future<List<PromoBanner>> listarPromoBannersAtivos() async {
    final response = await _supabase
        .from('promo_banners')
        .select('*');

    print(response);

    if (response.isEmpty) {
      return [];
    }

    return response.map((json) => PromoBanner.fromJson(json)).toList();
  }
}
