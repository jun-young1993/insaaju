part of '../four_pillars_of_destiny_screen.dart';

class FourPillarsOfDestinyMenus extends StatelessWidget {
  final Info info;

  const FourPillarsOfDestinyMenus({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    
    final fourPillarsOfDestinyBloc = context.read<FourPillarsOfDestinyBloc>();
    return Scaffold(
      body: FourPillarsOfDestinyDataSelector((fourpillarsOfDestinyData){
        print('checked');
        print(fourpillarsOfDestinyData!);    
        return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child:  Column(
                children: FourPillarsOfDestinyType.values.map((type){
                    return _buildFourPillarsMenu(
                      fourPillarsOfDestinyBloc,
                      fourpillarsOfDestinyData,
                      type
                    );
                  }).toList()
                // [
                //   ,
                //   _buildFourPillarsMenu(
                //     fourPillarsOfDestinyBloc,
                //     '용신(用神)과 기신(忌神)',
                //     fourpillarsOfDestinyData,
                //     FourPillarsOfDestinyType.yongsinAndGisin
                //   ),
                //   SizedBox(height: 10,),
                //   _buildFourPillarsMenu(
                //     fourPillarsOfDestinyBloc,
                //     '십신(十神) 분석',
                //     fourpillarsOfDestinyData,
                //     FourPillarsOfDestinyType.sipsinAnalysis
                //   ),
                //   SizedBox(height: 10,),
                //   _buildFourPillarsMenu(
                //     fourPillarsOfDestinyBloc,
                //     '결혼운',
                //     fourpillarsOfDestinyData,
                //     FourPillarsOfDestinyType.marriageFortune
                //   ),
                //   SizedBox(height: 10,),
                //   BigMenuButton(
                //     height: 80,
                //     child: _buildTextMenu('재물운',fourpillarsOfDestinyData![FourPillarsOfDestinyType.wealthFortune]),
                //     onPress: (){
                //       fourPillarsOfDestinyBloc.add(
                //         SendMessageFourPillarsOfDestinyEvent(
                //           fourPillarsOfDestinyType: FourPillarsOfDestinyType.wealthFortune,
                //           info: info
                //           )
                //       );
                //     },
                //   ),
                //   SizedBox(height: 10,),
                //   BigMenuButton(
                //     height: 80,
                //     child: _buildTextMenu('직업운', fourpillarsOfDestinyData![FourPillarsOfDestinyType.careerFortune]),
                //     onPress: (){
                //       fourPillarsOfDestinyBloc.add(
                //         SendMessageFourPillarsOfDestinyEvent(
                //           fourPillarsOfDestinyType: FourPillarsOfDestinyType.careerFortune,
                //           info: info
                //           )
                //       );
                //     },
                //   ),
                //   SizedBox(height: 10,),
                //   BigMenuButton(
                //     height: 80,
                //     child: _buildTextMenu('건강운',fourpillarsOfDestinyData![FourPillarsOfDestinyType.healthFortune]),
                //     onPress: (){
                //       fourPillarsOfDestinyBloc.add(
                //         SendMessageFourPillarsOfDestinyEvent(
                //           fourPillarsOfDestinyType: FourPillarsOfDestinyType.healthFortune,
                //           info: info
                //           )
                //       );
                //     },
                //   ),
                // ],
              )
            )
          );
      })
    );
      
  }
  
  Widget _buildTextMenu(String text, ChatComplation? fourPillarsOfDestinyData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 텍스트와 아이콘 간격을 넓게
        children: [
          Text(
            text, 
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
              color: Colors.black,
            ),
          ),
          // fourPillarsOfDestinyData가 null인지 여부에 따라 체크 또는 X 표시
          Icon(
            fourPillarsOfDestinyData != null ? Icons.check : Icons.close,
            color: fourPillarsOfDestinyData != null ? Colors.green : Colors.red,
            size: 24, // 아이콘 크기
          ),
        ],
      ),
    );
  }

  Widget _buildFourPillarsMenu(
    FourPillarsOfDestinyBloc fourPillarsOfDestinyBloc, 
    Map<FourPillarsOfDestinyType, ChatComplation?>? fourpillarsOfDestinyData, 
    FourPillarsOfDestinyType type
  ){
    return 
    BigMenuButton(
      height: 80,
      child: _buildTextMenu(type.getTitle(),fourpillarsOfDestinyData![type]),
      onPress: (){
        fourPillarsOfDestinyBloc.add(
          SendMessageFourPillarsOfDestinyEvent(
            fourPillarsOfDestinyType: FourPillarsOfDestinyType.sipsinAnalysis,
            info: info
            )
        );
      },
    );
  }
}