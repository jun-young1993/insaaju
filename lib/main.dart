import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/app.dart';
import 'package:insaaju/repository/four_pillars_of_destiny_repository.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_bloc.dart';
import 'package:insaaju/states/info/info_bloc.dart';
import 'package:insaaju/states/list/list_bloc.dart';
import 'package:insaaju/ui/screen/home/home_screen.dart';
void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<InfoRepository>(
          create: (context) => InfoDefaultRepository()
        ),
        RepositoryProvider<FourPillarsOfDestinyRepository>(
          create: (context) => FourPillarsOfDestinyDefaultRepository()
        )
      ], 
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InfoBloc(
              context.read<InfoRepository>()
            )
          ),
          BlocProvider(
              create: (context) => ListBloc(
                  context.read<InfoRepository>()
              )
          ),
          BlocProvider(create: (context) => FourPillarsOfDestinyBloc(
              context.read<FourPillarsOfDestinyRepository>()
          ))
        ],
        child: MyApp()
      )
    )
  );

 debugPaintSizeEnabled = false; // 위젯 경계 시각화
}



