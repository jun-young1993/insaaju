import 'package:flutter/material.dart';
import 'package:insaaju/routes.dart';

class AppBottomNavigationItem {
  final Routes route;
  final Widget icon;
  final String name;

  AppBottomNavigationItem({required this.route, required this.icon, required this.name});
}

class AppBottomNavigationBar extends StatelessWidget {
  final List<AppBottomNavigationItem> items = [
    AppBottomNavigationItem(
        route: Routes.home,
        icon: Icon(Icons.people),
        name: '친구'
    ),
    AppBottomNavigationItem(
        route: Routes.four_pillars_of_destiny,
        icon: Icon(Icons.access_time_rounded),
        name: '사주'
    ),
  ];

  AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
        items: _buildBottomItems(),
        onTap: _handleTap,
        currentIndex: _getCurrentIndex(),
    );
  }

  int _getCurrentIndex(){
        late int currentIndex = 0;
        for(int i = 0; i < items.length; i++){
          if(items[i].route.getValue() == AppNavigator.currentRoute){
            currentIndex = i;
            break;
          }
        }
        return currentIndex;
  }

  void _handleTap(int index) {
    AppNavigator.push(items[index].route);
  }

  List<BottomNavigationBarItem> _buildBottomItems(){
    return items.map((item){
      return BottomNavigationBarItem(
        icon: item.icon,
        label: item.name
      );
    }).toList();
  }



}