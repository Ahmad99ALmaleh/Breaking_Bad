import 'package:breaking_bad/constans/my_colors.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:flutter/material.dart';



class CharactersDetailsScreen extends StatelessWidget {

  final Character character;

   const CharactersDetailsScreen({Key? key , required this.character}) : super(key: key);

   
   Widget buildSliverAppBar(){
     return SliverAppBar(
       expandedHeight: 600,
       pinned: true,
       stretch: true,
       backgroundColor: MyColors.myGrey,
       flexibleSpace: FlexibleSpaceBar(
         title: Text(
           character.nickName,
           style: TextStyle(
             color: MyColors.myWhite,
           ),
         ),
         centerTitle: true,
         background: Hero(
           tag: character.charId,
           child: Image.network(character.image,fit: BoxFit.cover,),
         ),
       ),
     );
   }

   Widget characterInfo(String title , String value){
     return RichText(
       maxLines: 1,
       overflow: TextOverflow.ellipsis,
       text: TextSpan(
         children: [
           TextSpan(
             text: title,
             style: TextStyle(
               color: MyColors.myWhite,
               fontWeight: FontWeight.bold,
               fontSize: 18,
             ),
           ),
           TextSpan(
             text: value,
             style: TextStyle(
               color: MyColors.myWhite,
               fontSize: 16,
           ),
           ),],
       ),
     );
   }

   Widget buildDivider(double endIndent){
     return Divider(
       height: 30,
       endIndent: endIndent,
       color: MyColors.myYellow,
       thickness: 2,
     );
   }

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Job : ',
                        character.jobs.join('/')),
                    buildDivider(335),
                    characterInfo('Appeared in : ',
                        character.categoryForTwoSeries),
                    buildDivider(270),
                    characterInfo('Seasons : ',
                        character.appearanceOfSeasons.join('/')),
                    buildDivider(300),
                    characterInfo('Status : ',
                        character.statusIfDeadOrAlive),
                    buildDivider(315),
                    character.betterCallSaulApperance.isEmpty ? Container():
                    characterInfo('Better Call Saul Seasons : ',
                        character.betterCallSaulApperance.join('/')),
                    character.betterCallSaulApperance.isEmpty ? Container():
                    buildDivider(170),
                    characterInfo('Actor/Actress : ',
                        character.actorName),
                    buildDivider(255),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}
