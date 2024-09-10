part of '../compatibility_screen.dart';
class CompatibilityMultiList extends StatefulWidget {
  final int selectedIndexA;
  final Info? selectedInfoA;
  final int selectedIndexB;
  final Info? selectedInfoB;
  final Function(Info? info, int index) onSelectedA;
  final Function(Info? info, int index) onSelectedB;


  const CompatibilityMultiList({
    super.key,
    required this.selectedIndexA,
    this.selectedInfoA,
    required this.selectedIndexB,
    this.selectedInfoB, required this.onSelectedA, required this.onSelectedB
  });

  @override
  _CompatibilityMultiLstState createState() => _CompatibilityMultiLstState();

}
class _CompatibilityMultiLstState extends State<CompatibilityMultiList> {

  FourPillarsOfDestinyBloc get fourPillarsOfDestinyBloc => context.read<FourPillarsOfDestinyBloc>();
  @override
  Widget build(BuildContext context) {
    final int selectedIndexA = widget.selectedIndexA;
    final int selectedIndexB = widget.selectedIndexB;
    final Info? selectedInfoA = widget.selectedInfoA;
    final Info? selectedInfoB = widget.selectedInfoB;
    final Function(Info? info, int index) onSelectedA = widget.onSelectedA;
    final Function(Info? info, int index) onSelectedB = widget.onSelectedB;
    return Column(
      children: [
        _buildCompatibilityButton(
            (selectedInfoA == null || selectedInfoB == null),
                (type){
              if((selectedInfoA != null && selectedInfoB != null)){
                fourPillarsOfDestinyBloc.add(
                    SendMessageFourPillarsOfDestinyCompatibilityEvent(
                        fourPillarsOfDestinyCompatibilityType: type,
                        info: [selectedInfoA!, selectedInfoB!],
                        modelCode: CodeConstants.gpt_base_model
                    )
                );
              }
            }
        ),
        Expanded(
          child: Row(
            children: [
              CompatibilityList(
                selectedInfo: selectedInfoA,
                selectedIndex: selectedIndexA,
                onSelected: onSelectedA,
                disableInfo: selectedInfoB,
              ),
              CompatibilityList(
                selectedInfo: selectedInfoB,
                selectedIndex: selectedIndexB,
                onSelected: onSelectedB,
                disableInfo: selectedInfoA,
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildCompatibilityButton(
      bool isDisable,
      Function(FourPillarsOfDestinyCompatibilityType) onPressed
      ){

    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 12.0), // 텍스트 내부 여백,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: FourPillarsOfDestinyCompatibilityType.values.map((item) {
                return Row(
                  children: [
                    DisableButton(
                      isDisabled: isDisable,
                      text: item.getTitle(),
                      onPressed: (){
                        onPressed(item);
                      },
                    ),
                    SizedBox(width: 10,)
                  ],
                ) ;
              }).toList()
          )
      ),
    );
  }
}


class CompatibilityList extends StatefulWidget {
  final Info? selectedInfo;
  final int selectedIndex;
  final Function(Info? info, int index) onSelected;
  final Info? disableInfo;

  const CompatibilityList({
    super.key,
    this.selectedInfo,
    required this.selectedIndex,
    required this.onSelected, 
    this.disableInfo
  });

  @override
  _CompatibilityListState createState() => _CompatibilityListState();
}

class _CompatibilityListState extends State<CompatibilityList> {
  @override
  Widget build(BuildContext context) {
    return _buildList(
        widget.selectedInfo,
        widget.selectedIndex,
        widget.disableInfo,
        (info, index){
          if(index == widget.selectedIndex){
            widget.onSelected(null, -1);
          }else{
            widget.onSelected(info, index);
          }
        }
    );
  }
  Widget _buildList(
      Info? info,
      int selectedIndex,
      Info? disableInfo,
      Function(Info, int) onSelected
      ){
    return Expanded(
      child: Column(
        children: [
          _buildSelectedTitle(info),
          Expanded(
              child: InfoCardListSection(
                // key: ValueKey(selectedIndex),
                  disableInfo: disableInfo,
                  selectedIndex: selectedIndex,
                  autoSelect: false,
                  onSelected: onSelected
              )
          ),
        ],
      ),
    );
  }


  Widget _buildSelectedTitle(Info? info){
    return  Padding(
      padding: const EdgeInsets.all(8.0), // 패딩 추가
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // 배경 색상 추가
          borderRadius: BorderRadius.circular(8), // 둥근 모서리
          border: Border.all(color: Colors.grey, width: 1), // 테두리 추가
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0), // 텍스트 내부 여백
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 텍스트 중앙 정렬
          children: [
            Icon(
              info != null ? Icons.check_circle : Icons.error, // 선택 여부에 따라 아이콘 변경
              color: info != null ? Colors.green : Colors.red, // 선택 여부에 따라 아이콘 색상 변경
            ),
            const SizedBox(width: 8), // 아이콘과 텍스트 사이에 간격 추가
            Text(
              info != null ? info.name : "미선택", // 선택 여부에 따른 텍스트
              style: TextStyle(
                fontSize: 18, // 폰트 크기
                fontWeight: FontWeight.bold, // 폰트 굵기
                color: info != null ? Colors.black : Colors.redAccent, // 선택 여부에 따른 색상
              ),
            ),
          ],
        ),
      ),
    );
  }
}