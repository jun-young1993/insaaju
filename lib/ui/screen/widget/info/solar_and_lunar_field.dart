import 'package:flutter/material.dart';
import 'package:insaaju/domain/types/solar_and_lunar.dart';
import 'package:insaaju/states/info/info_state.dart';
import 'package:insaaju/ui/screen/widget/drop_box.dart';

class SolarAndLunarField extends StatefulWidget {
  final ValueChanged<SolarAndLunarType?>? onChanged;
  final ValueChanged<SolarAndLunarType?>? onMounted;
  const SolarAndLunarField({super.key, this.onChanged, this.onMounted});

  @override
  _SolarAndLunarFieldState createState() => _SolarAndLunarFieldState();
}

class _SolarAndLunarFieldState extends State<SolarAndLunarField> {
  SolarAndLunarType? selectedValue = SolarAndLunarType.solar;
  final List<Map<String, dynamic>> items = [{
        'value': SolarAndLunarType.solar,
        'name': '양력'
  },{
        'value': SolarAndLunarType.lunar,
        'name': '음력'
  }];
  @override
  void initState() {
    super.initState();
    if (widget.onMounted != null) {
      widget.onMounted!(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropBoxField<SolarAndLunarType>(
      items: items, 
      selectedValue: selectedValue,
      onChanged: (SolarAndLunarType? value){
        setState((){
          selectedValue = value;
        });
         widget.onChanged!(value);
      }
    );
  }

}

        // Expanded(
        //     flex: 1,
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(vertical: 2.0), // 내부 여백을 추가
        //       decoration: BoxDecoration(
        //         border: Border.all(color: Colors.grey), // TextField와 유사한 테두리 추가
        //         borderRadius: BorderRadius.circular(5.0), // 둥근 모서리 적용
        //       ),
        //       child: Center(
        //         child: DropdownButton<String>(
        //           value: solarAndLunarValue,
        //           onChanged: (String? value) {
        //             WidgetsBinding.instance.addPostFrameCallback((_) {
        //               setState(() {
        //                 solarAndLunarValue = value!;
        //               });
        //             });
        //           },
        //           // isExpanded: true, // DropdownButton의 크기를 확장
        //           underline: SizedBox(), // 밑줄 제거
        //           items: solarAndLunar.map<DropdownMenuItem<String>>((String value) {
        //             return DropdownMenuItem<String>(
        //               value: value,
        //               child: Text(value),
        //             );
        //           }).toList(),
        //         ),
        //       ),
        //     ),
        // ),
        // SizedBox(width: 20,),