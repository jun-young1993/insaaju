import 'package:flutter/material.dart';
import 'package:insaaju/domain/types/gender.dart';
import 'package:insaaju/ui/screen/widget/drop_box.dart';

class GenderField extends StatefulWidget {
  final ValueChanged<Gender?>? onChanged;
  final ValueChanged<Gender?>? onMounted;
  const GenderField({super.key, this.onChanged, this.onMounted});

  @override
  _GenderFieldState createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  Gender? selectedValue = Gender.male;
  final List<Map<String, dynamic>> items = [{
        'value': Gender.male,
        'name': '남자'
  },{
        'value': Gender.female,
        'name': '여자'
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
    return DropBoxField<Gender>(
      items: items, 
      selectedValue: selectedValue,
      onChanged: (Gender? value){
        setState((){
          selectedValue = value;
        });
         widget.onChanged!(value);
      }
    );
  }

}
