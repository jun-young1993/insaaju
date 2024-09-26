import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/domain/entities/code_item.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/chat_completion/chat_completion_bloc.dart';
import 'package:insaaju/states/chat_completion/chat_completion_event.dart';
import 'package:insaaju/states/chat_completion/chat_completion_selector.dart';
import 'package:insaaju/states/chat_completion/chat_completion_state.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/app_bar_close_leading_button.dart';
import 'package:insaaju/ui/screen/widget/info/info_profile.dart';
import 'package:insaaju/ui/screen/widget/loading_box.dart';
import 'package:insaaju/ui/screen/widget/text.dart';

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
  final Color? backgroundColor = Colors.lightGreen[50];

  ChatCompletionBloc get chatCompletionBloc => context.read<ChatCompletionBloc>();
  @override
  void initState(){
    super.initState();
    chatCompletionBloc.add(FindSectionChatCompletionEvent(info: widget.info,));
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      backgroundColor: backgroundColor, // AppBar 배경색 설정
      appBar: _buildAppBar(),
      child: Column(
        children: [
          Expanded(child: _buildMessageListBox()), // 메시지 리스트
          _buildMessageInput(), // 메시지 입력창
        ],
      ),
    );
  }

  // 시스템에서 제공하는 버튼을 채팅 스타일로 제공
  Widget _buildSystemButton(ChatRoomMessage chatRoomMessage) {

 
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
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
                  ElevatedButton(
                    onPressed: () {
                      chatCompletionBloc.add(
                        SendFourPillarsOfDestinyTypeChatCompletionEvent(
                          info: widget.info, 
                          type: FourPillarsOfDestinyTypeExtension.fromValue(chatRoomMessage.userPromptCodeItem.key)!
                        )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.teal, // 버튼 텍스트 색상
                    ),
                    child: Text(
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
        InfoProfile(size: 15), // 상대방 프로필
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
      backgroundColor: backgroundColor,
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
      return ListView.builder(
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