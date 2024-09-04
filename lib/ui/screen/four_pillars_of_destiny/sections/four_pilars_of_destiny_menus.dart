part of '../four_pillars_of_destiny_screen.dart';

class FourPillarsOfDestinyMenus extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final fourPillarsOfDestinyBloc = context.read<FourPillarsOfDestinyBloc>();
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child:  Column(
            children: [
              BigMenuButton(
                height: 80,
                child: _buildTextMenu('용신(用神)과 기신(忌神)'),
                onPress: (){
                  fourPillarsOfDestinyBloc.add(
                    SendMessageFourPillarsOfDestinyEvent(
                      fourPillarsOfDestinyType: FourPillarsOfDestinyType.yongsinAndGisin
                      )
                  );
                },
              ),
              SizedBox(height: 10,),
              BigMenuButton(
                height: 80,
                child: _buildTextMenu('십신(十神) 분석'),
                onPress: (){
                  fourPillarsOfDestinyBloc.add(
                    SendMessageFourPillarsOfDestinyEvent(
                      fourPillarsOfDestinyType: FourPillarsOfDestinyType.sipsinAnalysis
                      )
                  );
                },
              ),
              SizedBox(height: 10,),
              BigMenuButton(
                height: 80,
                child: _buildTextMenu('결혼운'),
                onPress: (){
                  fourPillarsOfDestinyBloc.add(
                    SendMessageFourPillarsOfDestinyEvent(
                      fourPillarsOfDestinyType: FourPillarsOfDestinyType.marriageFortune
                      )
                  );
                },
              ),
              SizedBox(height: 10,),
              BigMenuButton(
                height: 80,
                child: _buildTextMenu('재물운'),
                onPress: (){
                  fourPillarsOfDestinyBloc.add(
                    SendMessageFourPillarsOfDestinyEvent(
                      fourPillarsOfDestinyType: FourPillarsOfDestinyType.wealthFortune
                      )
                  );
                },
              ),
              SizedBox(height: 10,),
              BigMenuButton(
                height: 80,
                child: _buildTextMenu('직업운'),
                onPress: (){
                  fourPillarsOfDestinyBloc.add(
                    SendMessageFourPillarsOfDestinyEvent(
                      fourPillarsOfDestinyType: FourPillarsOfDestinyType.careerFortune
                      )
                  );
                },
              ),
              SizedBox(height: 10,),
              BigMenuButton(
                height: 80,
                child: _buildTextMenu('건강운'),
                onPress: (){
                  fourPillarsOfDestinyBloc.add(
                    SendMessageFourPillarsOfDestinyEvent(
                      fourPillarsOfDestinyType: FourPillarsOfDestinyType.healthFortune
                      )
                  );
                },
              ),
            ],
          )
        )
      )
    );
  }
  
  Widget _buildTextMenu(String text){
    return Text(
      text, 
      style: TextStyle(
      fontSize: 24, 
      fontWeight: FontWeight.bold, 
      color: Colors.black
      ),
    );
  }
}