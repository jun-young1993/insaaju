import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/list/list_bloc.dart';
import 'package:insaaju/states/list/list_event.dart';
import 'package:insaaju/states/list/list_selector.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/button.dart';
import 'package:insaaju/ui/screen/widget/info_card.dart';
import 'package:insaaju/ui/screen/widget/info_list/info_card_list.dart';

class ListScreen extends StatefulWidget {
  final Function(Info)? onSelected;
  const ListScreen({super.key, this.onSelected});

  @override
  _ListScreenState createState() => _ListScreenState();
}
class _ListScreenState extends State<ListScreen> {
  ListBloc get listBloc => context.read<ListBloc>();

  @override
  void initState(){
    super.initState();
    listBloc.add(const AllListEvent());
  }

  @override
  Widget build(BuildContext context){
    return AppBackground(
      child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: InfoCardListSection(
                  onSelected: (info){

                  },
                )
              ),
            ],
          )
      )
    );
  }
}