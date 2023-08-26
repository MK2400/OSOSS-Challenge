import 'package:ososs/core/result/result.dart';
import 'package:ososs/core/services/api/api_service.dart';
import 'package:ososs/core/services/api/api_urls.dart';

class PokemonServices {
  static String getPokemonDataName = 'getPokemonDataName';

  static Future<FinalResult> getPokemonData(int? offset, int? limit) async {
    FinalResult finalResult = await ApiService.sendRequest(
      queryParameters: {'offset': offset, 'limit': limit},
      url: ApiUrls.getPokemon,
      method: HttpMethods.get,
    );
    return finalResult;
  }
}
