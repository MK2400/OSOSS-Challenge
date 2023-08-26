part of 'pokemon_bloc.dart';

abstract class PokemonState {
  final bool rebuild;

  const PokemonState({this.rebuild = true});
}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {
  const PokemonLoadingState({bool rebuild = true})
      : super(rebuild: rebuild);
}

class PokemonFailureState extends PokemonState {
  final BaseError error;

  const PokemonFailureState({required this.error, bool rebuild = true})
      : super(rebuild: rebuild);
}

class PokemonLoadedState extends PokemonState {
  final PokemonModel pokemonModel;

  const PokemonLoadedState(
      {required this.pokemonModel, bool rebuild = true})
      : super(rebuild: rebuild);
}

