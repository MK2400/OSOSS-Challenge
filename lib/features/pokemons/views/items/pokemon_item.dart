import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ososs/core/resources/theme/app_colors.dart';
import 'package:ososs/core/services/api/api_urls.dart';
import 'package:ososs/features/pokemons/models/pokemon_model.dart';

class PokemonItem extends StatelessWidget {
  final int index;
  final PokemonResult pokemon;
  const PokemonItem({required this.index,required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration:  BoxDecoration(
                color: AppColors.mediumGrey,
                borderRadius:  const BorderRadius.all(Radius.circular(10),)
            ),
            child: Image.network(
              "${ApiUrls.getPokemonImage}${index + 1}.png",
              fit: BoxFit.contain,
              width: 125,
              height: 130,
              errorBuilder: (ctx,_,e) {
                return const FlutterLogo(size: 125,);
              },
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              pokemon.name ?? "",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
