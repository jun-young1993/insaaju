import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/app.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/states/info/info_bloc.dart';
import 'package:insaaju/ui/screen/home/home_screen.dart';
void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<InfoRepository>(
          create: (context) => InfoDefaultRepository()
        )
      ], 
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InfoBloc(
              context.read<InfoRepository>()
            )
          )
        ],
        child: MyApp()
      )
    )
  );

 debugPaintSizeEnabled = false; // 위젯 경계 시각화
}



