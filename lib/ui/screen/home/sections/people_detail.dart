part of '../home_screen.dart';

enum PeopleDetailMenu {
  chat
}

class PeopleDetail extends StatefulWidget {
  final Info info;
  const PeopleDetail({super.key, required this.info});

  @override
  _PeopleDetailState createState() => _PeopleDetailState();
}

class _PeopleDetailState extends State<PeopleDetail> {
  late PeopleDetailMenu? selectedMenu;
  SectionBloc get sectionBloc => context.read<SectionBloc>();
  
  @override
  void initState() {
    super.initState();
    selectedMenu = null;
  }

  @override
  Widget build(BuildContext context) {
    return ShowSectionSelector((status) {
      switch(status.childSection){
        case ChildSectionType.chatRoom:
          return _buildChatRoom();
        case ChildSectionType.toDayDestiny:
          return _buildToDayDestiny();
        default:
          return _buildDefaultDetail();
      }
    });
  }

  Widget _buildToDayDestiny(){
    return ToDayDestinyScreen(
      info: widget.info, 
      onPressed: (){
        sectionBloc.add(ShowChildSectionEvent(childSection: ChildSectionType.unselected, info: widget.info));
      },
    );
  }

  Widget _buildChatRoom(){
    return ChatRoomScreen(
          info: widget.info,
          onPressed: (){
            sectionBloc.add(ShowChildSectionEvent(childSection: ChildSectionType.unselected, info: widget.info));
          },
        );
  }

  Widget _buildDefaultDetail(){
    return AppBackground(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Stack(
            children: [
              InfoProfile(size: 100)
            ],
          ),
          const SizedBox(height: 50,),
          Column(
            children: [
              Text(
                widget.info.name,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(widget.info.toStringDateTime())
            ],
          ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(){
    return BottomNavigationBar(
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54,
        onTap: (int index){
          // 사주 채팅
          if(index == 0){
            sectionBloc.add(ShowChildSectionEvent(childSection: ChildSectionType.chatRoom, info: widget.info));
          }
          // 오늘의 운세
          if(index == 1){
            sectionBloc.add(ShowChildSectionEvent(childSection: ChildSectionType.toDayDestiny, info: widget.info));
          }
        },
        items: _bottomNavigationBarItem(),
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItem(){
    return [
      const BottomNavigationBarItem(
          label: '사주 구성',
          icon: Icon(Icons.chat)
      ),
      const BottomNavigationBarItem(
          label: '오늘의 운세',
          icon: Icon(Icons.bubble_chart)
      ),
    ];
  }

  AppBar _buildAppBar(){
    return AppBar(
      leading: ShowSectionSelector((status) {
        return AppBarCloseLeadingButton(
            onPressed: (){
              if(status.childSection == ChildSectionType.unselected){
                sectionBloc.add(const ShowSectionEvent(section: SectionType.unselected));
              }else{
                sectionBloc.add(const ShowChildSectionEvent(childSection: ChildSectionType.unselected));
              }

            }
        );
      })
    );
  }

}