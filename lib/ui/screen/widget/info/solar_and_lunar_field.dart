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
