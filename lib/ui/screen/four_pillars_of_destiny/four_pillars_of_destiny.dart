import 'package:flutter/material.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/button.dart';
import 'package:insaaju/ui/screen/widget/info_list/info_card_list.dart';

class FourPillarsOfDestiny extends StatefulWidget {
  const FourPillarsOfDestiny({super.key});

  @override
  _FourPillarsOfDestinyState createState() => _FourPillarsOfDestinyState();
}

class _FourPillarsOfDestinyState extends State<FourPillarsOfDestiny> {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: InfoCardListSection(
                    onSelected: (info){

                    },
                  )
              ),
              AppButton(
                child: Text('ok'),
              )
            ],
          )
      )
    );
  }
}