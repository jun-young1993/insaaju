import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:insaaju/configs/code_constants.dart';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/routes.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_bloc.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_event.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_selector.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/big_menu_button.dart';
import 'package:insaaju/ui/screen/widget/info_list/info_card_list.dart';
part 'sections/four_pillars_of_destiny_menus.dart';

class FourPillarsOfDestinyScreen extends StatefulWidget {
  const FourPillarsOfDestinyScreen({super.key});

  @override
  _FourPillarsOfDestinyScreenState createState() => _FourPillarsOfDestinyScreenState();
}

class _FourPillarsOfDestinyScreenState extends State<FourPillarsOfDestinyScreen> {
  FourPillarsOfDestinyBloc get fourPillarsOfDestinyBloc => context.read<FourPillarsOfDestinyBloc>();


  @override
  Widget build(BuildContext context) {
    return InfoFourPillarsOfDestinySelector((Info? fourPillarsOfDestinyUserInfo) {
        return LoadingFourPillarsOfDestinySelector((isLoading){
            return AppBackground(
                isLoading: isLoading,
                loadingText: "분석중입니다.. 잠시만 기다려 주세요.",
                onPress: () {
                  if(fourPillarsOfDestinyUserInfo == null){
                    AppNavigator.pop();
                  }else{
                    fourPillarsOfDestinyBloc.add(
                        UnSelectedInfoFourPillarsOfDestinyEvent());
                  }

                },
                child: SafeArea(
                    child:  (fourPillarsOfDestinyUserInfo == null)
                        ? InfoCardListSection(
                      selectedIndex: -1,
                      onSelected: (info) {
                        setState(() {
                          fourPillarsOfDestinyBloc.add(
                              SelectedInfoFourPillarsOfDestinyEvent(
                                  info: info)
                          );
                        });
                      },
                    )
                        : FourPillarsOfDestinyMenus(
                        info: fourPillarsOfDestinyUserInfo
                    )
                )

            );
        });
      });
    }
  }