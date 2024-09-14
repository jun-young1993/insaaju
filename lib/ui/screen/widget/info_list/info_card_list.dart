import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/routes.dart';
import 'package:insaaju/states/list/list_bloc.dart';
import 'package:insaaju/states/list/list_event.dart';
import 'package:insaaju/states/list/list_selector.dart';
import 'package:insaaju/ui/screen/widget/button.dart';
import 'package:insaaju/ui/screen/widget/info_card.dart';
import 'package:insaaju/ui/screen/widget/show_alert_dialog.dart';

class InfoCardListSection extends StatefulWidget {
  final Function(Info, int)? onSelected;
  final int selectedIndex;
  final bool autoSelect;
  final Info? disableInfo;

  const InfoCardListSection({
    super.key,
    this.onSelected,
    this.selectedIndex = 1,
    this.autoSelect = true,
    this.disableInfo
  });

  @override
  _InfoCardListSectionState createState() => _InfoCardListSectionState();
}
class _InfoCardListSectionState extends State<InfoCardListSection> {
  ListBloc get listBloc => context.read<ListBloc>();
  late int selectedIndex;
  late Info? disableInfo;

  @override
  void initState(){
    super.initState();
    selectedIndex = widget.selectedIndex;
    disableInfo = widget.disableInfo;
    listBloc.add(const AllListEvent());
  }

  @override
  void didUpdateWidget(covariant InfoCardListSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 선택된 인덱스가 바뀌었을 때 상태 업데이트
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      setState(() {
        selectedIndex = widget.selectedIndex;
      });
    }
    disableInfo = widget.disableInfo;
  }

  @override
  Widget build(BuildContext context){
    return AllListSelector((list) {
      if(list!.length == 0){
        return Container(
          child: Text('정보추가 하기 후 이용해주세요.'),
        );
      }
      return ListView.builder(
          itemCount: list!.length,
          itemBuilder: (context, index){
            
            return GestureDetector(
                onTap: (){
                  if(!_isDisable(disableInfo,list[index])){
                    if(widget.autoSelect){
                      setState(() {
                        selectedIndex = index;
                      });
                    }

                    if(widget.onSelected != null){
                      widget.onSelected!(list[index], index);
                    }  
                  }
                  
                },
                child: InfoCard(
                  color: _isDisable(disableInfo,list[index])
                  ? Colors.grey 
                  : (selectedIndex == index) 
                    ? Colors.green.shade100 
                    : Colors.white,
                  name: list[index].name,
                  date: list[index].date,
                  time: list[index].time,
                )
            );
          }
      );
    });
  }

  bool _isDisable(Info? disableInfo, Info currentInfo){
    if(disableInfo == null){
      return false;
    }
    return disableInfo.compare(currentInfo);
  }
}