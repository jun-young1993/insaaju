import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/info/info_bloc.dart';
import 'package:insaaju/states/info/info_event.dart';
import 'package:insaaju/states/info/info_selector.dart';
import 'package:insaaju/states/info/info_state.dart';
import 'package:insaaju/states/section/section_bloc.dart';
import 'package:insaaju/states/section/section_event.dart';
import 'package:insaaju/states/section/section_state.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/app_bar_close_leading_button.dart';
import 'package:insaaju/ui/screen/widget/button.dart';
import 'package:insaaju/ui/screen/widget/info/birth_time_field.dart';
import 'package:insaaju/ui/screen/widget/info/birth_date_field.dart';
import 'package:insaaju/ui/screen/widget/info/name_field.dart';
import 'package:insaaju/ui/screen/widget/loading_box.dart';
import 'package:insaaju/ui/screen/widget/text.dart';

class PlusPeople extends StatefulWidget {


  const PlusPeople({super.key});
  @override
  _PlusPeopleState createState() => _PlusPeopleState();
}

class _PlusPeopleState extends State<PlusPeople> {
  SectionBloc get sectionBloc => context.read<SectionBloc>();
  InfoBloc get infoBloc => context.read<InfoBloc>();

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      appBar: _buildAppBar(),
      child: _buildInfoForm(),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      leading: _buildAppBarLeading(),
      title: Text('ADD'),
      leadingWidth: 80.0,
    );
  }

  Widget _buildAppBarLeading(){
    return AppBarCloseLeadingButton(
        onPressed: (){
          sectionBloc.add(const ShowSectionEvent(section: SectionType.unselected));
        }
    );
  }

  Widget _buildInfoForm(){
    return Padding(
        padding: EdgeInsets.all(20),
        child: _buildInfoStateForm()
    );
  }

  Widget _buildInfoStateForm(){
    return InfoStateSelector((info){
      return InfoFailSelector((error){
        return Column(
          children: [
            _buildNameField(),
            _buildColumnSizedBox(),
            if(info.name != null)
              ...[
                _buildBirthDateField(),
                _buildColumnSizedBox(),
              ],
            if(info.date != null)
              ...[
                _buildBirthTimeField(),
                _buildColumnSizedBox(),
              ],
            if(error != null)
              ...[
                ErrorText(
                  text: info.error.toString(),
                ),
                _buildColumnSizedBox()
              ],
            _buildSaveButton(info)
          ],
        );
      });
    });
  }

  Widget _buildSaveButton(InfoState info){
    return InfoStatusSelector((status){
      if(status == InfoStatus.saving){
        return const LoadingBox(
          direction: LoadingBoxDirection.row,
          loadingText: "저장중입니다...",
        );
      }
      if(status == InfoStatus.saved){

        sectionBloc.add(const ShowSectionEvent(section: SectionType.addPeople));
        return const LoadingBox(
          direction: LoadingBoxDirection.row,
          loadingText: "저장되었습니다.",
        );
      }
      return AppButton(
        onPressed: (
            info.name != null
                && info.date != null
                && info.time != null
                && status != InfoStatus.saving
        )
            ? () {
              infoBloc.add(SaveEvent(info: Info.fromState(info)));
            }
            : null,
        child: Text("저장하기"),
      );

    });
  }

  Widget _buildColumnSizedBox(){
    return const SizedBox(height: 20,);
  }

  Widget _buildNameField(){
    return NameField(
        onSubmitted:(value){
          infoBloc.add(InputNameEvent(name: value));
        }
    );
  }

  Widget _buildBirthDateField(){
    return BirthDateField(
        onSubmitted:(value){
          infoBloc.add(InputDateEvent(date: value));
        }
    );
  }

  Widget _buildBirthTimeField(){
    return BirthTimeField(
        onSubmitted: (value){
          infoBloc.add(InputTimeEvent(
              time: value,
              check: false
          ));
        }
    );
  }
}