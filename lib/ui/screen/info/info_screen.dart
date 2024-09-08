import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/exceptions/duplicate_exception.dart';
import 'package:insaaju/routes.dart';
import 'package:insaaju/states/info/info_bloc.dart';
import 'package:insaaju/states/info/info_event.dart';
import 'package:insaaju/states/info/info_selector.dart';
import 'package:insaaju/states/info/info_state.dart';
import 'package:insaaju/ui/screen/home/home_screen.dart';
import 'package:insaaju/ui/screen/info/birth_date_screen.dart';
import 'package:insaaju/ui/screen/info/birth_time_screen.dart';
import 'package:insaaju/ui/screen/info/check_screen.dart';
import 'package:insaaju/ui/screen/info/hanja_screen.dart';
import 'package:insaaju/ui/screen/info/name_screen.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}
class _InfoScreenState extends State<InfoScreen> {
  InfoBloc get infoBloc => context.read<InfoBloc>();
  @override
  Widget build(BuildContext context){
    return AppBackground(
      child: SafeArea(
        child: Stack(
            children: [
              _buildInfoForm(),
              InfoFailSelector((error){
                if(error != null){
                    WidgetsBinding.instance.addPostFrameCallback((_) {

                      if(error is DuplicateException){
                        _showErrorDialog(context,
                            "중복된 정보 입니다.",
                            (){
                              infoBloc.add(const InfoInitializeEvent());
                            }
                        );
                      }else{
                        _showErrorDialog(context, error.toString(),(){
                          infoBloc.add(const InfoInitializeEvent());
                        });
                      }

                    });
                }
                return Container();
              })
            ]
        )
      )
    );
  }

  // 에러 다이얼로그
  void _showErrorDialog(
      BuildContext context,
      String errorMessage,
      VoidCallback onPressed
  ) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: (){
                onPressed();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoForm(){
    return InfoStateSelector((info){
      // if(info.status == InfoStatus.saving){
      //   return Text('저장중입니다.');
      // }
      // if(info.status == InfoStatus.saved){
      //   return HomeScreen();
      // }
      switch(info.menu){
        case InfoMenu.name:
          return NameScreen(
            name: info.name,
            onTap: (text){
              infoBloc.add(InputNameEvent(name: text));
            },
          );
        case InfoMenu.hanja:
          return HanjaScreen(
            hanja: info.hanjaList,
            name: info.name,
            onTap: (hanja){
              infoBloc.add(InputHanjaEvent(hanja: hanja));
            },
            onOk: (){
              infoBloc.add(const InputMenuEvent(menu: InfoMenu.birthDate));
            },
          );
        case InfoMenu.birthDate:
          return BirthdateScreen(
            onTap: (text){
              infoBloc.add(InputDateEvent(date: text));
            },
          );
        case InfoMenu.birthDateAndTime:
          return BirthTimeScreen(
            onTap: (text){
              infoBloc.add(InputTimeEvent(time: text));
            },
          );
        case InfoMenu.check:

          return CheckScreen(
            onSave: (info){
              infoBloc.add(CheckEvent(info: info));
            },
          );

        default:
          return HomeScreen();
      }

    });
  }
}