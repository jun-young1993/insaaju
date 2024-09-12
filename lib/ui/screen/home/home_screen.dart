import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/routes.dart';
import 'package:insaaju/states/list/list_bloc.dart';
import 'package:insaaju/ui/screen/info/info_screen.dart';
import 'package:insaaju/ui/screen/list/list_screen.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/big_menu_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {
ListBloc get listBloc => context.read<ListBloc>();

@override
void initState(){
  super.initState();

}

@override
Widget build(BuildContext context) {
  return AppBackground(
    showBackIcon: false,
    isBackground: true,
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildTop(),
              
            ],
        ),
      )
    )
  );
}

Widget _buildTop(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildTitle(),
      _buildTopMenuIconButtons()
    ],
  );
}

Widget _buildTitle(){
  return const Text(
    '친구',
    style: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold
    )
  );
}


Widget _buildTopMenuIconButtons(){
  return Row(
    children: [
      IconButton(
        onPressed: (){
          
        }, 
        icon: const Icon(Icons.search)
      ),
      SizedBox(width: 10,),
      IconButton(
        onPressed: (){
          
        }, 
        icon: const Icon(Icons.person_add),
      )
    ],
  );
}

Widget _buildMenuButton(
      BuildContext context,
      String name,
      {VoidCallback? onPress}
) {
    return BigMenuButton(
      onPress: onPress,
      child: Text(name),
    );
  }
}