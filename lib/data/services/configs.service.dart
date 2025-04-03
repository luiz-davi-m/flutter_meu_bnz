import 'package:flutter_meu_bnz/data/repositories/configs.respository.dart';
import '../../domain/models/Config.dart';

class ConfigsService {
  static Future<Config?> configs() {
    return ConfigsRepository.configs();
  }

  static Future<void> atualizarCashback(double novoValor) async {
    await ConfigsRepository.atualizarCashback(novoValor);
  }
}
