part of 'pokemon_bloc.dart';

abstract class PokemonEvent {}

class FetchPokemonData extends PokemonEvent {
  final int? offset;
  final int? limit;
  final bool rebuild;

  FetchPokemonData({this.offset, this.limit,this.rebuild=true});
}
