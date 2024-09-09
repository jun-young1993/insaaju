import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_bloc.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_event.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/disable_buttion.dart';
import 'package:insaaju/ui/screen/widget/info_list/info_card_list.dart';

import '../../../configs/code_constants.dart';

part 'sections/compatibility_list.dart';

class CompatibilityScreen extends StatefulWidget {

  const CompatibilityScreen({
    super.key,
  });

  @override
  _CompatibilityScreenState createState() => _CompatibilityScreenState();
}

class _CompatibilityScreenState extends State<CompatibilityScreen> {
  late int selectedIndexA = -1;
  late Info? selectedInfoA = null;
  late int selectedIndexB = -1;
  late Info? selectedInfoB = null;
  FourPillarsOfDestinyBloc get fourPillarsOfDestinyBloc => context.read<FourPillarsOfDestinyBloc>();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return AppBackground(
        child: SafeArea(
            child: CompatibilityMultiList(
              selectedIndexA: selectedIndexA,
              selectedIndexB: selectedIndexB,
              selectedInfoA: selectedInfoA,
              selectedInfoB: selectedInfoB,
              onSelectedA: (info, index){
                  setState((){
                    selectedIndexA = index;
                    selectedInfoA = info;
                  });
              },
              onSelectedB: (info, index){
                setState((){
                  selectedIndexB = index;
                  selectedInfoB = info;
                });
              },
            )
        )
    );
  }


  _showDialog(
      BuildContext context,
      Info a,
      Info b
  ){
    showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            content: Text('hi')
          );
        }
    );
  }

}