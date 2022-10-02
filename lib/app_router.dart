import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';
import 'package:breaking_bad/presentation/screens/character_details_screen.dart';
import 'package:breaking_bad/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constans/strings.dart';
import 'data/models/characters.dart';

class AppRouter{

  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter(){
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }


  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (BuildContext context) =>
                    CharactersCubit(charactersRepository),
                child: const CharactersScreen(),
              ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>  CharactersDetailsScreen(character : character));
    }
  }
}