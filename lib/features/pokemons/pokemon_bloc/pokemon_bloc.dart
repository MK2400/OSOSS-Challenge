import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ososs/core/services/api/error_types.dart';
import 'package:ososs/core/services/parallel/parallel_model.dart';
import 'package:ososs/core/services/parallel/parallel_service.dart';
import 'package:ososs/features/pokemons/models/pokemon_model.dart';
import 'package:ososs/features/pokemons/repositories/pokemon_services.dart';

part 'pokemon_event.dart';

part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitialState()) {
    on<FetchPokemonData>((event, emit) async {
      emit( PokemonLoadingState(rebuild: event.rebuild));
      ParallelService parallelService = ParallelService(services: [
        ParallelModel(
            service: PokemonServices.getPokemonData(event.offset, event.limit),
            name: PokemonServices.getPokemonDataName),
      ]);

      var parallelServiceResult = await parallelService.getResults();
      if (parallelService.isServicesFailed()) {
        var errorItem = parallelServiceResult
            .firstWhere((element) => element.finalResult.hasError);
        emit(PokemonFailureState(error: errorItem.finalResult.error!,rebuild: event.rebuild));
      } else {
        emit(PokemonLoadedState(
            rebuild: event.rebuild,
            pokemonModel: PokemonModel.fromJson(parallelServiceResult
                .firstWhere((element) =>
                    element.name == PokemonServices.getPokemonDataName)
                .finalResult
                .responseData
                ?.data)));
      }
    });
  }
}
