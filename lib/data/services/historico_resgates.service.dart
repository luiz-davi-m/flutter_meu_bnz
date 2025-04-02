import 'package:flutter_meu_bnz/data/repositories/historico_resgates.repository.dart';
import 'package:flutter_meu_bnz/domain/models/ResgateCashback.dart';

class HistoricoResgateService {
  static Future<List<ResgateCashback>> historicoResgates() {
    return HistoricoResgateRespository.historicoResgates();
  }

  static Future<void> registrarResgate(String categoria, double valor) async {
    HistoricoResgateRespository.registrarResgate(categoria, valor);
  }
}
