import 'package:flutter/material.dart';
import 'package:insaaju/routes.dart';
import 'package:insaaju/ui/screen/info/info_screen.dart';
import 'package:insaaju/ui/screen/list/list_screen.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/big_menu_button.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      showBackIcon: false,
      isBackground: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 버튼들을 중앙에 배치
            children: [
              _buildMenuButton(context, '정보 추가',
                onPress: () {
                  AppNavigator.push(Routes.info);
                }
              ),
              SizedBox(height: 16), // 버튼 간의 간격을 추가
              _buildMenuButton(
                  context,
                  '저장된 정보 보기',
                onPress: (){
                  AppNavigator.push(Routes.list);
                }
              ),
              SizedBox(height: 16),
              _buildMenuButton(
                  context,
                  '사주',
                  onPress: (){
                    AppNavigator.push(Routes.four_pillars_of_destiny);
                  }
              ),
              SizedBox(height: 16),
              _buildMenuButton(
                  context,
                  '궁합',
                  onPress: (){
                    AppNavigator.push(Routes.compatibility);
                  }
              ),
            ],
          ),
        ),
      ),
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