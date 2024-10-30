part of '../home_screen.dart';

class FourPillarsOfDestinyStructure extends StatefulWidget {
  final Info info;
  const FourPillarsOfDestinyStructure({super.key, required this.info});

  @override
  _FourPillarsOfDestinyStructureState createState() => _FourPillarsOfDestinyStructureState();
}

class _FourPillarsOfDestinyStructureState extends State<FourPillarsOfDestinyStructure> {

  FourPillarsOfDestinyBloc get fourPillarsOfDestinyBloc => context.read<FourPillarsOfDestinyBloc>();
  SectionBloc get sectionBloc => context.read<SectionBloc>();
  bool _isExpanded = false;
  @override
  void initState()  {
    super.initState();
    fourPillarsOfDestinyBloc.add(ShowFourPillarsOfDestinyEvent(info: widget.info));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildStructure();
  }

  Widget _buildStructure(){
    return AppBackground(
      appBar: _buildAppBar(),
      child: LoadingFourPillarsOfDestinySelector((isLoading) {
        if(isLoading){
          return _loadingBox();
        }else{
          return _buildPillars();
        }
      })
    );
  }

  Widget _buildPillars(){
    return FourPillarsOfDestinyStructureSelector((fourPillarsOfDestinyStructure) {
      if(fourPillarsOfDestinyStructure == null){
        return _emptyPillars();
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfo(widget.info, fourPillarsOfDestinyStructure),
            const SizedBox(height: 8.0,),
            _buildHeavenlyAndEarthly(fourPillarsOfDestinyStructure)
          ],
        )
      );
    });
  }

  Widget _buildHeavenlyAndEarthly(FourPillarsOfDestiny fourPillarsOfDestinyStructure){
    return Column(
      children: [
        _buildHeavenlyAndEarthlyTitle(),
        const SizedBox(height: 8.0,),
        _buildPillarsRowCard(
          fourPillarsOfDestinyStructure.year.heavenly,
          fourPillarsOfDestinyStructure.month.heavenly,
          fourPillarsOfDestinyStructure.day.heavenly,
          fourPillarsOfDestinyStructure.time.heavenly,
        ),
        _buildPillarsRowCard(
          fourPillarsOfDestinyStructure.year.earthly,
          fourPillarsOfDestinyStructure.month.earthly,
          fourPillarsOfDestinyStructure.day.earthly,
          fourPillarsOfDestinyStructure.time.earthly,
        )
      ],
    );
  }

  Widget _buildInfo(Info info, FourPillarsOfDestiny fourPillarsOfDestiny){
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fourPillarsOfDestiny.info.animal,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.info.name,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '양력',
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _toFormatDateString(fourPillarsOfDestiny.info.date.solar),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '음력',
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _toFormatDateString(fourPillarsOfDestiny.info.date.lunar),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _toFormatDateString(String date){
    final splitDate = date.split('-');
    final year = splitDate[0];
    final month = splitDate[1];
    final day = splitDate[2];
    return  '$year년 $month월 $day일';
  }
  

  Widget _buildHeavenlyAndEarthlyTitle(){
    return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['년주', '월주', '일주', '시주'].map((label) => Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              )).toList(),
        );
  }

  Widget _emptyPillars(){
    return Text('불러올 데이터가 없습니다..');
  }

  Widget _loadingBox(){
    return LoadingBox(
      loadingText: '불러오는중 입니다...',
    );
  }

  Widget _buildPillarsRowCard(
    HeavenlyAndEarthlyBase heavenlyAndEarthlyYear,
    HeavenlyAndEarthlyBase heavenlyAndEarthlyMonth,
    HeavenlyAndEarthlyBase heavenlyAndEarthlyDay,
    HeavenlyAndEarthlyBase heavenlyAndEarthlyTime,
  ){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child:_buildPillarCard(heavenlyAndEarthlyYear) ,),
        Expanded(child:_buildPillarCard(heavenlyAndEarthlyMonth) ,),
        Expanded(child:_buildPillarCard(heavenlyAndEarthlyDay) ,),
        Expanded(child:_buildPillarCard(heavenlyAndEarthlyTime) ,),
      ],
    );
  }

  Widget _buildPillarCard(
    HeavenlyAndEarthlyBase heavenlyAndEarthly
  ){
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              heavenlyAndEarthly.ten.ko,
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              heavenlyAndEarthly.hanja,
              style: TextStyle(fontSize:38.0, fontWeight: FontWeight.bold, color: heavenlyAndEarthly.color),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              heavenlyAndEarthly.ko,
              style: TextStyle(fontSize: 14.0, color: heavenlyAndEarthly.color),
              textAlign: TextAlign.center,
            )
          ],
        )
      )
    );
  }


  AppBar _buildAppBar(){
    return AppBar(
      title: const Text("사주 구성"),
      leading: ShowSectionSelector((status){
        return AppBarCloseLeadingButton(
          onPressed: (){
            sectionBloc.add(ShowChildSectionEvent(childSection: ChildSectionType.unselected, info: widget.info));
          }
        );
      })
    );
  }
  
}