part of '../four_pillars_of_destiny_screen.dart';
class FourPillarsOfDestinyMenus extends StatefulWidget {
  final Info info;
  const FourPillarsOfDestinyMenus({super.key, required this.info});

  @override
  _FourPillarsOfDestinyMenusState createState() => _FourPillarsOfDestinyMenusState();
}

class _FourPillarsOfDestinyMenusState extends State<FourPillarsOfDestinyMenus> {
  late FourPillarsOfDestinyType? _expanded = null;

  @override
  Widget build(BuildContext context) {
    final fourPillarsOfDestinyBloc = context.read<FourPillarsOfDestinyBloc>();
    return Scaffold(
      body: FourPillarsOfDestinyDataSelector((fourPillarsOfDestinyData) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView( // SingleChildScrollView 대신 ListView로 변경
            children: FourPillarsOfDestinyType.values.map((type) {
              return _buildFourPillarsMenu(
                  fourPillarsOfDestinyBloc, fourPillarsOfDestinyData, type);
            }).toList(),
          ),
        );
      }),
    );
  }

  Widget _buildTextMenu(String text, ChatCompletion? fourPillarsOfDestinyData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Icon(
            fourPillarsOfDestinyData != null ? Icons.check : Icons.close,
            color: fourPillarsOfDestinyData != null ? Colors.green : Colors.red,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildFourPillarsMenu(
      FourPillarsOfDestinyBloc fourPillarsOfDestinyBloc,
      Map<FourPillarsOfDestinyType, ChatCompletion?>? fourPillarsOfDestinyData,
      FourPillarsOfDestinyType type) {
    return Column(
      key: ValueKey(type), // 키를 설정하여 상태를 유지
      children: [
        BigMenuButton(
          height: 80,
          child: _buildTextMenu(type.getTitle(), fourPillarsOfDestinyData![type]),
          onPress: () {
            if (fourPillarsOfDestinyData![type] == null) {
              fourPillarsOfDestinyBloc.add(
                SendMessageFourPillarsOfDestinyEvent(
                  fourPillarsOfDestinyType: type,
                  info: widget.info,
                  modelCode: CodeConstants.gpt_base_model,
                ),
              );
            } else {
              setState(() {
                _expanded == type ? _expanded = null : _expanded = type;
              });
            }
          },
        ),
        const SizedBox(height: 5),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          constraints: BoxConstraints(
            maxHeight: _expanded == type ? MediaQuery.of(context).size.height * 0.6 : 0,
          ),
          child: _expanded == type
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Markdown(
                    shrinkWrap: true, // 컨테이너 내부에서 크기를 자동으로 조절
                    data: fourPillarsOfDestinyData![type]!
                        .choices[0]!
                        .message!
                        .content,
                  ),
                ),
              ),
            )
            : Container(),
        )
      ],
    );
  }
}