import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/me/me_bloc.dart';
import 'package:insaaju/states/me/me_event.dart';
import 'package:insaaju/states/me/me_selector.dart';
import 'package:insaaju/states/section/section_bloc.dart';
import 'package:insaaju/states/section/section_event.dart';
import 'package:insaaju/states/section/section_selector.dart';
import 'package:insaaju/states/section/section_state.dart';
import 'package:insaaju/ui/screen/section/plus_people.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/app_bottom_navigation_bar.dart';
import 'package:insaaju/ui/screen/widget/full_screen_overlay.dart';
import 'package:insaaju/ui/screen/widget/me_profile.dart';
import 'package:insaaju/ui/screen/widget/text.dart';
import 'package:insaaju/utills/ad_mob_const.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}
class _SettingScreenState extends State<SettingScreen> {
  SectionBloc get sectionBloc => context.read<SectionBloc>();
  MeBloc get meBloc => context.read<MeBloc>();
  BannerAd? _bannerAd;

  void _createBannerAd(){
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobConstant.bannerAdUnitId!,
        listener: AdMobConstant.bannerAdListener,
        request: const AdRequest()
    )..load();
  }

  @override
  void initState(){
    super.initState();
    _createBannerAd();
    meBloc.add(const FindMeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ShowSectionSelector((state) {
      return Scaffold(
        body: FullScreenOverlay(
          defaultWidget: _buildDefault(),
          child: _buildOverlay(state.section, state.info),
        ),
        bottomNavigationBar: (state.section == SectionType.unselected)
            ? AppBottomNavigationBar()
            : null
      );
    });
  }

  Widget? _buildOverlay(SectionType section, Info? info){
    switch(section){
      case SectionType.addPeople:
      case SectionType.addMe:
        return PlusPeople(sectionType: section);
      default:
        return null;
    }
  }

  AppBar _buildAppBar(){
    return AppBar(
      leading: const TitleText(text: '설정'),
      leadingWidth: 80.0,

    );
  }

  Widget _buildDefault(){
    return AppBackground(
      appBar: _buildAppBar(),
      child: MeFindSelector((info) {
        return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MeProfile(
                      handleMeCreate: () {
                        sectionBloc.add(const ShowSectionEvent(section: SectionType.addMe));
                      },
                      handleTapList: (info){

                      },
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    _settingRow(icon: Icons.key, keyText: 'ID', valueText: info.mySessionId ?? '')
                  ],
                ),
                _buildBottomBannerAd()
              ],
            )
        );
      })
    );
  }

  Widget _settingRow({
    required IconData icon,
    required String keyText,
    String valueText = '',
  }){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 35,
          color: Colors.blueAccent, // 아이콘 색상을 설정할 수 있습니다.
        ),
        const SizedBox(width: 10), // 아이콘과 텍스트 사이의 간격
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                keyText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700], // 텍스트 색상 설정
                ),
              ),
              const SizedBox(height: 5), // keyText와 valueText 사이의 간격
              Text(
                valueText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black, // value 텍스트의 색상
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBannerAd(){
    return _bannerAd == null
        ? Container()
        : Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 75,
        child: AdWidget(
            ad: _bannerAd!
        )
    );
  }
  
}