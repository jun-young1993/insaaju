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

  // 시스템에서 제공하는 버튼을 채팅 스타일로 제공
  Widget _buildSystemButton(ChatRoomMessage chatRoomMessage) {
    final FourPillarsOfDestinyType fourPillarsOfDestinyType = FourPillarsOfDestinyTypeExtension.fromValue(chatRoomMessage.userPromptCodeItem.key)!;
 
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Wrap(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                              title: const Text('리워드 광고'),
                              content: Text("광고 시청후 ${fourPillarsOfDestinyType.getTitle()} 하기"),
                              actions: [
                                TextButton(
                                  child: const Text('취소'),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text('확인'),
                                  onPressed: (){
                                    Navigator.pop(context);
                                    _rewardedAd?.show(
                                      onUserEarnedReward: (_, reward) {
                                        chatCompletionBloc.add(
                                          SendFourPillarsOfDestinyTypeChatCompletionEvent(
                                            info: widget.info,
                                            type: fourPillarsOfDestinyType
                                          )
                                        );
                                      }
                                    );
                                  },
                                )
                              ],
                          );
                        }
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.teal, // 버튼 텍스트 색상
                    ),
                    icon: Icon(Icons.play_circle_filled),
                    label: Text(
                      chatRoomMessage.content,
                      softWrap: true
                    ),
                  ),
                ],
              ),
            )
            
          ],
        ),
      ),
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

  Widget _buildMessageList(){
    return SectionMessageChatCompletionSelector((messages){
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(10),
        itemCount: messages.length,
        reverse: false, // 가장 최근 메시지가 아래에 오도록 설정
        itemBuilder: (context, index) {
          switch(messages[index].role){
            case ChatRoomRole.system:
            case ChatRoomRole.assistant:
              return _buildMessageBubble(messages[index], false);
            case ChatRoomRole.user:
              return _buildMessageBubble(messages[index], true);
            case ChatRoomRole.button:
              return _buildSystemButton(messages[index]);
            default: 
              return _buildMessageBubble(messages[index], false);
          }
          
        },
      );
    });
  }

  Widget _buildMessageListBox() {

    return SectionChatCompletionSelector((status){
      print(status);
      switch(status){
        case SectionLoadStatus.complete:
          return _buildMessageList();
        case SectionLoadStatus.fail:
          return SectionErrorChatCompletionSelector((error){
            return ErrorText(text: error.toString());
          });
        default:
          return const LoadingBox(
            loadingText: '대화내용을 불러오는 중...',
          );
      }
    });

  }

  Widget _buildMessageBubble(ChatRoomMessage chatRoomMessage, bool isUserMessage) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isUserMessage ? 12 : 0),
            topRight: const Radius.circular(12),
            bottomLeft: const Radius.circular(12),
            bottomRight: Radius.circular(isUserMessage ? 0 : 12),
          ),
        ),
        child: isUserMessage 
        ? Text(
          chatRoomMessage.content,
          style: TextStyle(
            color: Colors.white
          ),
        )
        : Markdown(
          shrinkWrap: true,
          data: chatRoomMessage.content,
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "메시지를 입력하세요...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.teal),
            onPressed: () {
              // 메시지 보내기 로직 추가
            },
          ),
        ],
      ),
    );
  }
}