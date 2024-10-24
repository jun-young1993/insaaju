import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/exceptions/unknown_exception.dart';
import 'package:insaaju/states/info/info_bloc.dart';
import 'package:insaaju/states/info/info_event.dart';
import 'package:insaaju/states/info/info_selector.dart';
import 'package:insaaju/states/info/info_state.dart';
import 'package:insaaju/states/list/list_bloc.dart';
import 'package:insaaju/states/list/list_event.dart';
import 'package:insaaju/states/me/me_bloc.dart';
import 'package:insaaju/states/me/me_event.dart';
import 'package:insaaju/states/section/section_bloc.dart';
import 'package:insaaju/states/section/section_event.dart';
import 'package:insaaju/states/section/section_selector.dart';
import 'package:insaaju/states/section/section_state.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/app_bar_close_leading_button.dart';
import 'package:insaaju/ui/screen/widget/button.dart';
import 'package:insaaju/ui/screen/widget/info/birth_time_field.dart';
import 'package:insaaju/ui/screen/widget/info/birth_date_field.dart';
import 'package:insaaju/ui/screen/widget/info/name_field.dart';
import 'package:insaaju/ui/screen/widget/info/solar_and_lunar_field.dart';
import 'package:insaaju/ui/screen/widget/loading_box.dart';
import 'package:insaaju/ui/screen/widget/text.dart';
import 'package:insaaju/utills/ad_mob_const.dart';

class PlusPeople extends StatefulWidget {
  final SectionType sectionType;

  const PlusPeople({super.key, required this.sectionType});
  @override
  _PlusPeopleState createState() => _PlusPeopleState();
}

class _PlusPeopleState extends State<PlusPeople> {
  SectionBloc get sectionBloc => context.read<SectionBloc>();
  InfoBloc get infoBloc => context.read<InfoBloc>();
  MeBloc get meBloc => context.read<MeBloc>();
  ListBloc get listBloc => context.read<ListBloc>();
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;

  @override
  void initState(){
    super.initState();
    if(Platform.isAndroid || Platform.isIOS){
      _createBannerAd();
      _loadRewardedAd();  
    }
    
  }

  void _loadRewardedAd(){
    RewardedAd.load(
        adUnitId: AdMobConstant.rewardAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                  onAdDismissedFullScreenContent: (ad){
                    setState(() {
                      ad.dispose();
                      _rewardedAd = null;
                    });
                    _loadRewardedAd();
                  }
              );
              setState(() {
                _rewardedAd = ad;
              });
            },
            onAdFailedToLoad: (LoadAdError error) {
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: const Text('Error'),
                      content: ErrorText(text: error.toString()),
                      actions: [
                        TextButton(
                          child: Text('cancel'.toUpperCase()),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      appBar: _buildAppBar(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoForm(),
          _buildBottomBannerAd()
        ],
      ),
    );
  }

  void _createBannerAd(){
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobConstant.bannerAdUnitId!,
      listener: AdMobConstant.bannerAdListener,
      request: const AdRequest()
    )..load();
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

  AppBar _buildAppBar(){
    return AppBar(
      leading: _buildAppBarLeading(),
      title: ShowSectionSelector((state){
        return Text(state.section.getTitle());
      }),
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
            if(info.date != null)
              ...[
                _buildBirthTimeField(),
                _buildColumnSizedBox(),
                _buildSolarAndLunar(),
                _buildColumnSizedBox(),
              ],
            if(info.name != null)
              ...[
                _buildBirthDateField(),
                _buildColumnSizedBox(),
              ],
            _buildNameField(),
            _buildColumnSizedBox(),
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
          return LoadingBox(
            direction: LoadingBoxDirection.row,
            loadingText: InfoStatus.saving.getTitle(),
          );
        }
        if(status == InfoStatus.saved){

          sectionBloc.add(const ShowSectionEvent(section: SectionType.unselected));
          listBloc.add(const AllListEvent());
          return LoadingBox(
            direction: LoadingBoxDirection.row,
            loadingText: InfoStatus.saved.getTitle(),
          );
        }
        return AppButton(
          onPressed: (!info.hasMissingFields() && status != InfoStatus.saving)
              ? () {
                if(widget.sectionType == SectionType.addPeople){
                  _rewardedAd?.show(
                      onUserEarnedReward: (_, reward) {
                        infoBloc.add(SaveEvent(info: Info.fromState(info)));
                      }
                  );
                }else if(widget.sectionType == SectionType.addMe){
                  meBloc.add(SaveMeInfoEvent(info: Info.fromState(info)));
                }else{
                  throw UnknownException<SectionType>(widget.sectionType);
                }
              }
              : null,
          child: Text(widget.sectionType.getTitle()),
        );

      });
  }

  Widget _buildSolarAndLunar(){
    return SolarAndLunarField(
      onChanged: (value){
        if(value != null){
          infoBloc.add(InputSolarAndLunarEvent(solarAndLunarType: value));
        }
      },
    );
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