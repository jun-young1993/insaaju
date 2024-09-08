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
            child: Column(
              children: [
                _buildCompatibilityButton(
                    (selectedInfoA == null || selectedInfoB == null),
                    (type){

                        if((selectedInfoA != null && selectedInfoB != null)){
                          fourPillarsOfDestinyBloc.add(
                            SendMessageFourPillarsOfDestinyCompatibilityEvent(
                              fourPillarsOfDestinyCompatibilityType: type,
                              info: [selectedInfoA!, selectedInfoB!],
                              modelCode: CodeConstants.gpt_base_model
                            )
                          );
                        }
                    }
                ),
                Expanded(
                  child: Row(
                    children: [
                      _buildList(
                        selectedInfoA,
                        selectedIndexA,
                          (info, index){

                            setState(() {
                              if(index == selectedIndexA){
                                selectedIndexA = -1;
                                selectedInfoA = null;
                              }else{
                                selectedIndexA = index;
                                selectedInfoA = info;
                              }
                            });
                          }
                      ),
                      _buildList(
                        selectedInfoB,
                        selectedIndexB,
                          (info, index){
                            setState(() {
                              if(index == selectedIndexB){
                                selectedIndexB = -1;
                                selectedInfoB = null;
                              }else{
                                selectedIndexB = index;
                                selectedInfoB = info;
                              }
                            });
                          }
                      )
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }

  Widget _buildCompatibilityButton(
      bool isDisable,
      Function(FourPillarsOfDestinyCompatibilityType) onPressed
  ){

    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 12.0), // 텍스트 내부 여백,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: FourPillarsOfDestinyCompatibilityType.values.map((item) {
            return Row(
              children: [
                DisableButton(
                  isDisabled: isDisable,
                  text: item.getTitle(),
                  onPressed: (){
                    onPressed(item);
                  },
                ),
                SizedBox(width: 10,)
              ],
            ) ;
          }).toList()
        )
      ),
    );
  }

  Widget _buildSelectedTitle(Info? info){
    return  Padding(
      padding: const EdgeInsets.all(8.0), // 패딩 추가
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // 배경 색상 추가
          borderRadius: BorderRadius.circular(8), // 둥근 모서리
          border: Border.all(color: Colors.grey, width: 1), // 테두리 추가
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0), // 텍스트 내부 여백
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 텍스트 중앙 정렬
          children: [
            Icon(
              info != null ? Icons.check_circle : Icons.error, // 선택 여부에 따라 아이콘 변경
              color: info != null ? Colors.green : Colors.red, // 선택 여부에 따라 아이콘 색상 변경
            ),
            const SizedBox(width: 8), // 아이콘과 텍스트 사이에 간격 추가
            Text(
              info != null ? info.name : "미선택", // 선택 여부에 따른 텍스트
              style: TextStyle(
                fontSize: 18, // 폰트 크기
                fontWeight: FontWeight.bold, // 폰트 굵기
                color: info != null ? Colors.black : Colors.redAccent, // 선택 여부에 따른 색상
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildList(
      Info? info,
      int selectedIndex,
      Function(Info, int) onSelected
  ){
    return Expanded(
      child: Column(
        children: [
          _buildSelectedTitle(info),
          Expanded(
              child: InfoCardListSection(
                // key: ValueKey(selectedIndex),
                selectedIndex: selectedIndex,
                autoSelect: false,
                onSelected: onSelected
              )
          ),
        ],
      ),
    );
  }
}