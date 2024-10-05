import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/chat_completion/chat_completion_bloc.dart';
import 'package:insaaju/states/chat_completion/chat_completion_event.dart';
import 'package:insaaju/states/chat_completion/chat_completion_selector.dart';
import 'package:insaaju/states/chat_completion/chat_completion_state.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/app_bar_close_leading_button.dart';
import 'package:insaaju/ui/screen/widget/destination_card.dart';
import 'package:insaaju/ui/screen/widget/info/info_profile.dart';
import 'package:insaaju/ui/screen/widget/loading_box.dart';
import 'package:insaaju/ui/screen/widget/text.dart';
import 'package:insaaju/utills/ad_mob_const.dart';

class ToDayDestinyScreen extends StatefulWidget {
  final Info info;
  final VoidCallback onPressed;
  const ToDayDestinyScreen({
      super.key,
      required this.info,
      required this.onPressed,
  });

  @override
  _ToDayDestinyState createState() => _ToDayDestinyState();
}

class _ToDayDestinyState extends State<ToDayDestinyScreen> {
  ChatCompletionBloc get chatCompletionBloc => context.read<ChatCompletionBloc>();
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    chatCompletionBloc.add(FindToDayDestinyChatCompletionEvent(info: widget.info));
    if(Platform.isAndroid || Platform.isIOS){
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
      child: _buildToDayDestiny()
    );
  }

  Widget _buildAppBarTitle(){
    return const Text(
          "오늘의 운세",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
       );
    
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _buildAppBarTitle(),
      leading: AppBarCloseLeadingButton(
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }



  Widget _buildCard({
    required CrossAxisAlignment crossAxisAlignment,
    required Widget child
  }){
    return DestinationCard(
      crossAxisAlignment: crossAxisAlignment,
      child: child,
      title: '오늘의 운세'
    );
  }

  Widget _buildToDayDestiny(){
    return ToDayChatStatusSelector((status) {
      switch(status){
        case ToDayStatus.fail:
          return SectionErrorChatCompletionSelector((error){
            return _buildCard(
              crossAxisAlignment: CrossAxisAlignment.center,
              child: ErrorText(text:error.toString())
            );
          });
        case ToDayStatus.complete:
          return _buildCard(
              crossAxisAlignment: CrossAxisAlignment.center,
              child: SectionMessageChatCompletionSelector((messages) {
                return Markdown(
                    shrinkWrap: true,
                    data: messages[0].content ?? ''
                );
              })
          );
        case ToDayStatus.isEmpty:
          return _buildCard(
              crossAxisAlignment: CrossAxisAlignment.center,
              child: _buildReward()
          );
        default:
          return LoadingBox(
            loadingText: '불러오는중입니다...',
          );
      }
    });
  }

  Widget _buildReward(){
    return ElevatedButton.icon(
      onPressed: () {
        _rewardedAd?.show(
          onUserEarnedReward: (_, reward) {
            chatCompletionBloc.add(SendToDayDestinyChatCompletionEvent(info: widget.info));
          }
        );
      },
      icon: const Icon(
        Icons.play_circle_outline, // 광고 재생을 나타내는 아이콘
        color: Colors.white,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        backgroundColor: Colors.purple, // 버튼 배경색
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // 둥근 모서리
        ),
        elevation: 5, // 그림자 효과
      ),
      label: const Text(
        '광고 시청 후 오늘의 운세 보기',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white, // 텍스트 색상
        ),
      ),
    );
  }

}