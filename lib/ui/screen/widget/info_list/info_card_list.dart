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
  final Function(Info)? onSelected;
  final int selectedIndex;
  const InfoCardListSection({super.key, this.onSelected, this.selectedIndex = 1});

  @override
  _InfoCardListSectionState createState() => _InfoCardListSectionState();
}
class _InfoCardListSectionState extends State<InfoCardListSection> {
  ListBloc get listBloc => context.read<ListBloc>();
  late int selectedIndex;

  @override
  void initState(){
    super.initState();
    selectedIndex = widget.selectedIndex;
    listBloc.add(const AllListEvent());
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
                  setState(() {
                    selectedIndex = index;
                  });
                  if(widget.onSelected != null){
                    widget.onSelected!(list[index]);
                  }
                },
                child: InfoCard(
                  color: selectedIndex == index ? Colors.green.shade100 : Colors.white,
                  name: list[index].name,
                  hanja: list[index].hanja,
                  date: list[index].date,
                  time: list[index].time,
                )
            );
          }
      );
    });
  }
}