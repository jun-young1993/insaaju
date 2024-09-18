import 'package:flutter/material.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/app_bar_close_leading_button.dart';
import 'package:insaaju/ui/screen/widget/info/info_profile.dart';

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
  final List<String> messages = [
    "안녕하세요!",
    "네, 안녕하세요. 오늘 기분은 어떠신가요?",
    "좋아요! 당신은요?",
    "저도 좋습니다. 채팅방 UI 작업 중이에요.",
    "안녕하세요!",
    "네, 안녕하세요. 오늘 기분은 어떠신가요?",
    "좋아요! 당신은요?",
    "저도 좋습니다. 채팅방 UI 작업 중이에요.",
    "안녕하세요!",
    "네, 안녕하세요. 오늘 기분은 어떠신가요?",
    "좋아요! 당신은요?",
    "저도 좋습니다. 채팅방 UI 작업 중이에요.",
    "안녕하세요!",
    "네, 안녕하세요. 오늘 기분은 어떠신가요?",
    "좋아요! 당신은요?",
    "저도 좋습니다. 채팅방 UI 작업 중이에요.",
  ];

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      backgroundColor: backgroundColor, // AppBar 배경색 설정
      appBar: _buildAppBar(),
      child: Column(
        children: [
          Expanded(child: _buildMessageList()), // 메시지 리스트
          _buildSystemButton(),
          _buildMessageInput(), // 메시지 입력창
        ],
      ),
    );
  }

  // 시스템에서 제공하는 버튼을 채팅 스타일로 제공
  Widget _buildSystemButton() {
    return Align(
      alignment: Alignment.centerLeft,
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
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 동작
                print("SYSTEM 버튼 클릭됨");
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal, // 버튼 텍스트 색상
              ),
              child: const Text("클릭하세요"),
            ),
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

  Widget _buildMessageList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: messages.length,
      reverse: true, // 가장 최근 메시지가 아래에 오도록 설정
      itemBuilder: (context, index) {
        bool isUserMessage = index % 2 == 0; // 짝수 인덱스는 사용자 메시지로 간주
        return _buildMessageBubble(messages[index], isUserMessage);
      },
    );
  }

  Widget _buildMessageBubble(String message, bool isUserMessage) {
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
        child: Text(
          message,
          style: TextStyle(
            color: isUserMessage ? Colors.white : Colors.black87,
          ),
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