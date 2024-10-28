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
        child: _buildHeavenlyAndEarthly(fourPillarsOfDestinyStructure)
      );
    });
  }

  Widget _buildHeavenlyAndEarthly(FourPillarsOfDestiny fourPillarsOfDestinyStructure){
    return Column(
      children: [
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

  Widget _emptyPillars(){
    return Text('불러올 데이터가 없습니다..');
  }

  Widget _loadingBox(){
    return LoadingBox(
      loadingText: '불러오는중 입니다...',
    );
  }

  Widget _buildPillarsRowCard(
    HeavenlyAndEarthlyNames heavenlyAndEarthlyYear,
    HeavenlyAndEarthlyNames heavenlyAndEarthlyMonth,
    HeavenlyAndEarthlyNames heavenlyAndEarthlyDay,
    HeavenlyAndEarthlyNames heavenlyAndEarthlyTime,
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
    HeavenlyAndEarthlyNames heavenlyAndEarthly
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
              '설명',
              style: const TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              heavenlyAndEarthly.hanja,
              style: const TextStyle(fontSize:38.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              heavenlyAndEarthly.ko,
              style: const TextStyle(fontSize: 14.0),
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