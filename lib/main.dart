import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:insaaju/app.dart';
import 'package:insaaju/repository/code_item_repository.dart';
import 'package:insaaju/repository/openai_repository.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/states/chat_completion/chat_completion_bloc.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_bloc.dart';
import 'package:insaaju/states/info/info_bloc.dart';
import 'package:insaaju/states/list/list_bloc.dart';
import 'package:insaaju/states/me/me_bloc.dart';
import 'package:insaaju/states/section/section_bloc.dart';
import 'repository/four_pillars_of_destiny_repository.dart';

Future<void> main() async {

// print(ChatCompletion.fromJson());
// print(test);
  await dotenv.load(fileName: "assets/.env");
  MobileAds.instance.initialize();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<InfoRepository>(
          create: (context) => InfoDefaultRepository()
        ),
        RepositoryProvider<OpenaiRepository>(
          create: (context) => OpenaiDefaultRepository()
        ),
        RepositoryProvider<CodeItemRepository>(
            create: (context) => CodeItemDefaultRepository()
        ),
        RepositoryProvider<FourPillarsOfDestinyRepository>(
          create: (context) => FourPillarsOfDestinyDefaultRepository()
        )
      ], 
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InfoBloc(
                context.read<InfoRepository>(),
                context.read<OpenaiRepository>(),
                context.read<CodeItemRepository>()
            )
          ),
          BlocProvider(
              create: (context) => ListBloc(
                  context.read<InfoRepository>()
              )
          ),
          BlocProvider(create: (context) => FourPillarsOfDestinyBloc(
              context.read<OpenaiRepository>(),
              context.read<CodeItemRepository>(),
              context.read<FourPillarsOfDestinyRepository>()
          )),
          BlocProvider(
            create: (context) => MeBloc(
              context.read<InfoRepository>(),
              context.read<OpenaiRepository>(),
              context.read<InfoBloc>(),
              // getInfoBloc(context)
            )
          ),
          BlocProvider(create: (context) => SectionBloc()),
          BlocProvider(
              create: (context) => ChatCompletionBloc(
                context.read<OpenaiRepository>(),
                context.read<InfoRepository>(),
                context.read<CodeItemRepository>()
              ),
          )
        ],
        child: MyApp()
      )
    )
  );



  
  debugPaintSizeEnabled = false; // 위젯 경계 시각화
}



