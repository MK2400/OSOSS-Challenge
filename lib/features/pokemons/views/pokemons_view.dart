import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ososs/core/resources/app_strings.dart';
import 'package:ososs/core/resources/theme/app_colors.dart';
import 'package:ososs/core/shared_widgets/error_widget.dart';
import 'package:ososs/features/pokemons/models/pokemon_model.dart';
import 'package:ososs/features/pokemons/pokemon_bloc/pokemon_bloc.dart';
import 'package:ososs/features/pokemons/views/items/pokemon_item.dart';

class PokemonView extends StatefulWidget {
  const PokemonView({super.key});

  @override
  State<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        title: const Text(AppStrings.pokemons),
      ),
      body:BlocProvider(
        create: (context) => PokemonBloc()..add(FetchPokemonData()),
        child: Builder(
            builder: (context) => BlocBuilder(
                bloc: BlocProvider.of<PokemonBloc>(context),
                buildWhen:(_, current) =>
                (current as PokemonState).rebuild,
                builder: (context, state) {
                  if (state is PokemonLoadingState) {
                    return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                    );
                  } else if (state is PokemonLoadedState) {
                   if((state.pokemonModel.pokemonResult??[]).isEmpty){
                     return const Center(
                         child: Text(AppStrings.thereIsNoPokemons,style: TextStyle(fontSize: 22),));
                   }
                    return PokemonPage(
                      pokemonModel: state.pokemonModel,
                    );
                  } else if (state is PokemonFailureState) {
                    return SimpleErrorWidget(
                      type: state.error.errorType,
                      body: state.error.msg,
                      canClose: false,
                      tryAgainFunction: () {
                        BlocProvider.of<PokemonBloc>(context)
                            .add(FetchPokemonData());
                      },
                    );
                  }
                  return const SizedBox();
                })),
      ) ,
    );
  }
}

class PokemonPage extends StatefulWidget {
  final PokemonModel pokemonModel;
  const PokemonPage({required  this.pokemonModel,super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  static const _pageSize = 20;
  int _pageNumber = 1;
  final PagingController<int, PokemonResult> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {

    _checkData(widget.pokemonModel.pokemonResult??[]);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener(
        listener: (context, state) {
          if (state is PokemonLoadedState) {
            _checkData(state.pokemonModel.pokemonResult??[]);
          } else if (state is PokemonFailureState) {
            _pagingController.error(state.error.msg);
          }
        },
        bloc: BlocProvider.of<PokemonBloc>(context),
        child: PagedListView<int, PokemonResult>(
          pagingController: _pagingController,
          padding: const EdgeInsets.all(8.0),
          builderDelegate: PagedChildBuilderDelegate<PokemonResult>(
            itemBuilder: (context,item, index) {
              return PokemonItem(index: index,pokemon: item,);
            },
          )
        ),
      ),
    );
  }
  Future<void> _fetchPage() async {

      BlocProvider.of<PokemonBloc>(context).add(
          FetchPokemonData(
              rebuild: false,
              offset:  (_pageNumber-1)*_pageSize,
              limit: _pageSize));

  }

  void _checkData(List<PokemonResult> list) {
    final isLastPage = list.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(list);
    } else {
      final nextPageKey = _pageNumber++;
      _pagingController.appendPage(list, nextPageKey);
    }
  }

}

