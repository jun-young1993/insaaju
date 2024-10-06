import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/domain/entities/code_item.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/exceptions/four_of_destiny_required_exception.dart';
import 'package:insaaju/states/chat_completion/chat_completion_bloc.dart';
import 'package:insaaju/states/chat_completion/chat_completion_event.dart';
import 'package:insaaju/states/chat_completion/chat_completion_selector.dart';
import 'package:insaaju/states/chat_completion/chat_completion_state.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/app_bar_close_leading_button.dart';
import 'package:insaaju/ui/screen/widget/destination_card.dart';
import 'package:insaaju/ui/screen/widget/info/info_profile.dart';
import 'package:insaaju/ui/screen/widget/loading_box.dart';
import 'package:insaaju/ui/screen/widget/text.dart';
import 'package:insaaju/utills/ad_mob_const.dart';

class ChatRoomScreen extends StatefulWidget {
  final Info info;
  final VoidCallback onPressed;

  const ChatRoomScreen({
    super.key,
    required this.info,
    required this.onPressed,
  });

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  ChatCompletionBloc get chatCompletionBloc => context.read<ChatCompletionBloc>();
  RewardedAd? _rewardedAd;

  @override
  void initState(){
    super.initState();
    chatCompletionBloc.add(FindSectionChatCompletionEvent(info: widget.info,));
    if(Platform.isAndroid || Platform.isIOS){
      _loadRewardedAd();
    }
    
  }

  @override
  void dispose() {
    _scrollController.dispose(); // 사용 후 컨트롤러 해제
    super.dispose();
  }

  void _scrollToBottom() {
    // 최대 스크롤 값으로 스크롤
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
  void _onIconPressed(int index) {
    setState(() {
      _currentPage = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
      bottomNavigationBar: _buildBottomNavigationBar(),
      child: SectionChatCompletionSelector((status) {
        switch(status){
          case SectionLoadStatus.complete:
            return _buildPageView();
          case SectionLoadStatus.fail:
            return SectionErrorChatCompletionSelector((error){
              return ErrorText(text: error.toString());
            });
          default:
            return const LoadingBox(
              loadingText: '불러오는 중 입니다...',
            );
        }
      })
    );
  }

  Widget _buildPageView(){
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemCount: FourPillarsOfDestinyType.values.length,
      itemBuilder: (context, index){
        return SectionMessageChatCompletionSelector((messages) {
          print(messages.length);
          final FourPillarsOfDestinyType selectedType = FourPillarsOfDestinyType.values[index];
          final message = messages.firstWhereOrNull(
              (message) => selectedType.hasSameValue(message.userPromptCodeItem.key)
          );
          if(message == null) {
            return _buildPageNotFound(selectedType);
          }else{
            return _buildPage(message, selectedType);
          }
        });
      }
    );
  }

  Widget _buildReward(FourPillarsOfDestinyType type){

    return ElevatedButton.icon(
      onPressed: () {
        _rewardedAd?.show(
            onUserEarnedReward: (_, reward) {
              chatCompletionBloc.add(
                  SendFourPillarsOfDestinyTypeChatCompletionEvent(
                      info: widget.info,
                      type: type
                  )
              );
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
      label: Text(
        '광고 시청 후 ${type.getTitle()} 보기',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white, // 텍스트 색상
        ),
      ),
    );
  }

  Widget _buildPageNotFound(FourPillarsOfDestinyType type){
    return DestinationCard(
      crossAxisAlignment: CrossAxisAlignment.center,
      title: type.getTitle(),
      child:_buildReward(type)
    );
  }

  Widget _buildPage(ChatRoomMessage chatRoomMessage, FourPillarsOfDestinyType type){
    return DestinationCard(
        title: type.getTitle(),
        child: Markdown(
            physics: const AlwaysScrollableScrollPhysics(),
            data: chatRoomMessage.content
        )
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        const InfoProfile(size: 15), // 상대방 프로필
        const SizedBox(width: 10),
        Text(
          widget.info.name,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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

  Widget _buildBottomNavigationBar(){
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black54,
      currentIndex: _currentPage,
      showUnselectedLabels: false,
      onTap: (int index){
        _onIconPressed(index);
      },
      type: BottomNavigationBarType.shifting,
      items: _bottomNavigationBarItem(),
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItem(){

    return FourPillarsOfDestinyType.values.map((type) {
      return BottomNavigationBarItem(
          label: type.getTitle(),
          icon: Icon(type.getIcon()),
          tooltip: type.getTitle(),
      );
    }).toList();
  }
}