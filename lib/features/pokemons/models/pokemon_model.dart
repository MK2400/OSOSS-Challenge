import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel {
  @JsonKey(name: "count")
  int? count;
  @JsonKey(name: "previous")
  String? previous;
  @JsonKey(name: "next")
  String? next;
  @JsonKey(name: "results")
  List<PokemonResult>? pokemonResult;

  PokemonModel({this.count, this.next, this.pokemonResult, this.previous});

  //fromJson
  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PokemonResult {
  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "url")
  String? url;

  PokemonResult({this.name, this.url});

  //fromJson
  factory PokemonResult.fromJson(Map<String, dynamic> json) =>
      _$PokemonResultFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$PokemonResultToJson(this);
}
