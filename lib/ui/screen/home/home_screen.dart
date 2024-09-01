import 'package:flutter/material.dart';
import 'package:insaaju/routes.dart';
import 'package:insaaju/ui/screen/info/info_screen.dart';
import 'package:insaaju/ui/screen/list/list_screen.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
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
                  '사주보기',
                  onPress: (){
                    AppNavigator.push(Routes.four_pillars_of_destiny);
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
    return SizedBox(
      width: double.infinity, // 버튼의 너비를 부모의 너비로 설정
      height: 60, // 버튼의 높이를 설정
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0),
          textStyle: TextStyle(fontSize: 18.0), // 버튼 텍스트의 크기를 설정
        ),
        onPressed: () {
          onPress!();
        },
        child: Text(name),
      ),
    );
  }
}