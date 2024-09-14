import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/list/list_bloc.dart';
import 'package:insaaju/states/list/list_event.dart';
import 'package:insaaju/states/list/list_selector.dart';
import 'package:insaaju/states/list/list_state.dart';
import 'package:insaaju/states/me/me_bloc.dart';
import 'package:insaaju/states/me/me_event.dart';
import 'package:insaaju/states/me/me_selector.dart';
import 'package:insaaju/states/me/me_state.dart';
import 'package:insaaju/states/section/section_event.dart';
import 'package:insaaju/states/section/section_selector.dart';
import 'package:insaaju/states/section/section_state.dart';
import 'package:insaaju/ui/screen/section/plus_people.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/full_screen_overlay.dart';
import 'package:insaaju/ui/screen/widget/info_list/info_row.dart';
import 'package:insaaju/ui/screen/widget/loading_box.dart';
import 'package:insaaju/ui/screen/widget/text.dart';

import '../../../states/section/section_bloc.dart';
part 'sections/people_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {
  ListBloc get listBloc => context.read<ListBloc>();
  MeBloc get meBloc => context.read<MeBloc>();
  SectionBloc get sectionBloc => context.read<SectionBloc>();


  @override
  void initState(){
    super.initState();
    meBloc.add(const FindMeEvent());
    listBloc.add(const AllListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ShowSectionSelector((section) {
      return FullScreenOverlay(
        defaultWidget: _buildDefault(),
        child: _buildOverlay(section)
      );
    });
  }

  Widget? _buildOverlay(SectionType section){
    switch(section){
      case SectionType.addPeople:
        return PlusPeople();
      default:
        return null;
    }
  }

  Widget _buildDefault(){
    return AppBackground(
      appBar: _buildAppBar(),
      child: PeopleList()
    );
  }
  AppBar _buildAppBar(){
    return AppBar(
      leading: const TitleText(text: 'HOME'),
      leadingWidth: 80.0,
      actions: [
        _buildSearchIcon(),
        _buildAddPeople()
      ],
    );
  }

  Widget _buildSearchIcon(){
    return IconButton(
      onPressed: (){
        
      }, 
      icon: const Icon(Icons.search)
    );
  }

  Widget _buildAddPeople(){
    return   IconButton(
      onPressed: (){
        sectionBloc.add(const ShowSectionEvent(section: SectionType.addPeople));
      }, 
      icon: const Icon(Icons.person_add),
    );
  }
}
