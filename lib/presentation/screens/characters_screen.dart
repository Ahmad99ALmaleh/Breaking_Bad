import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constans/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {

  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField(){
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18.0,
        ),
      ),
      style: TextStyle(
        color: MyColors.myGrey,
        fontSize: 18.0,
      ),
      onChanged: (searchedCharacter){
        addSearchedForItemToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchedCharacter){
    searchedForCharacters = allCharacters
        .where((character) => character.name.toLowerCase()
        .startsWith(searchedCharacter))
        .toList();
    setState(() {

    });
  }

  List<Widget> _buildAppBarActions(){
    if(_isSearching){
      return [
        IconButton(onPressed: (){
          _clearSearch();
          Navigator.pop(context);
        },
            icon:Icon(Icons.clear,color: MyColors.myGrey,) ,
        ),
      ];
    } else {
      return [
        IconButton(onPressed: _startSearch,
          icon:Icon(Icons.search,color: MyColors.myGrey,) ,
        ),
      ];
    }
  }

  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching(){
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
     BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

   Widget buildBlocWidget(){
    return BlocBuilder<CharactersCubit,CharactersState>(
        builder: (context , state){
          if (state is CharactersLoaded){
            allCharacters = (state).characters;
            return buildLoadedListWidgets();
          }else{
            return showLoadingIndicator() ;
          }
        },
    );
  }

  Widget showLoadingIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets(){
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }


  Widget buildCharactersList(){
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2/3,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
    ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty ? allCharacters.length : searchedForCharacters.length,
        itemBuilder: (ctx , index) {
      return CharacterItem(character:_searchTextController.text.isEmpty ? allCharacters[index] : searchedForCharacters[index],);
        }
    );
  }

  Widget _buildAppBarTitle(){
    return Text(
      "characters",
      style: TextStyle(
        color: MyColors.myGrey,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching ? BackButton(color: MyColors.myGrey,):Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(

      ),
    );
  }
}
