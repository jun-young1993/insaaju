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
    switch(selectedMenu){
      case PeopleDetailMenu.chat:
        return _buildChatRoom();
      default:
        return _buildDefaultDetail();
    }
  }

  Widget _buildChatRoom(){
    return ChatRoomScreen(
          info: widget.info,
          onPressed: (){
            sectionBloc.add(const ShowSectionEvent(section: SectionType.unselected));
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
          print('${index} selected');
          setState(() {
            selectedMenu = PeopleDetailMenu.chat;
          });
        },
        items: _bottomNavigationBarItem(),
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItem(){
    return [
      BottomNavigationBarItem(
          label: '사주 채팅',
          icon: Icon(Icons.chat)
      ),
      BottomNavigationBarItem(
          label: 'test',
          icon: Icon(Icons.chat)
      ),
    ];
  }

  AppBar _buildAppBar(){
    return AppBar(
      leading: AppBarCloseLeadingButton(
          onPressed: (){
            sectionBloc.add(const ShowSectionEvent(section: SectionType.unselected));
          }
      ),
    );
  }

}