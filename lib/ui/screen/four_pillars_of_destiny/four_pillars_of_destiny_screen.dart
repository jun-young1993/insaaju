import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_bloc.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_event.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_selector.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/states/info/info_selector.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/big_menu_button.dart';
import 'package:insaaju/ui/screen/widget/button.dart';
import 'package:insaaju/ui/screen/widget/info_list/info_card_list.dart';
import 'package:insaaju/ui/screen/widget/big_menu_button.dart';
import 'package:insaaju/ui/screen/widget/info_text_with_description.dart';
part 'sections/four_pilars_of_destiny_menus.dart';

class FourPillarsOfDestinyScreen extends StatefulWidget {
  const FourPillarsOfDestinyScreen({super.key});

  @override
  _FourPillarsOfDestinyScreenState createState() => _FourPillarsOfDestinyScreenState();
}

class _FourPillarsOfDestinyScreenState extends State<FourPillarsOfDestinyScreen> {
  FourPillarsOfDestinyBloc get fourPillarsOfDestinyBloc => context.read<FourPillarsOfDestinyBloc>();
  Info? selectedInfo;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: InfoFourPillarsOfDestinySelector((Info? fourPillarsOfDestinyUserInfo){
                    if(fourPillarsOfDestinyUserInfo == null){
                      return InfoCardListSection(
                        selectedIndex: -1,
                        onSelected: (info){
                          setState((){
                            selectedInfo = info;
                          });
                        },
                      );  
                    }else{
                      return FourPillarsOfDestinyMenus(info: fourPillarsOfDestinyUserInfo);
                    }
                    
                  })
              ),
              AppButton(
                child: Text('ok'),
                onPressed: (){
                  if(selectedInfo != null){
                    fourPillarsOfDestinyBloc.add(
                      SelectedInfoFourPillarsOfDestinyEvent(info: selectedInfo!)
                    );
                  }
                  
                },
              )
            ],
          )
      )
    );
  }
}