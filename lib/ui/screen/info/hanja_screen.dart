import 'package:flutter/material.dart';
import 'package:insaaju/states/info/info_selector.dart';
import 'package:insaaju/ui/screen/widget/button.dart';

class HanjaScreen extends StatelessWidget {
  final List<List<Map<String, dynamic>>>? hanja;
  final String? name;
  final Function(List<String>)? onTap;
  final VoidCallback? onOk;

  const HanjaScreen({
    this.hanja,
    this.name,
    Key? key,
    this.onTap, this.onOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Hanja for $name'),
      ),
      body: hanja!.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(hanja!.length, (index) {
                      return Expanded(
                        child: InfoHanjaStateSelector((hanjaNames) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              children: [
                                _buildHanja(hanjaNames, index),
                                SizedBox(height: 8),
                                Expanded(
                                  child: _buildHanjaByNames(
                                      index,
                                      hanjaNames,
                                      onTap
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppButton(
                    onPressed: () {
                      onOk!();
                      // OK 버튼 눌렀을 때 처리 로직
                    },
                    child: Text('OK'),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildHanja(hanjaNames, index) {
    return Text(
      '${name![index]} (${hanjaNames![index]})',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildHanjaByNames(int index, List<String>? hanjaNames,  Function(List<String>)? onTap) {
    return ListView.builder(
      itemCount: hanja![index].length,
      itemBuilder: (context, hanjaIndex) {
        final hanjaItem = hanja![index][hanjaIndex];
        return GestureDetector(
          onTap: (){
            hanjaNames![index] = hanjaItem['hanja'];
            onTap!(hanjaNames);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: hanjaNames![index] == hanjaItem['hanja'] ? Colors.green : Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // 그림자 색상
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 4), // 그림자의 위치 조정
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    hanjaItem['hanja'],
                    style: TextStyle(
                      color: Colors.white, // 텍스트 색상을 흰색으로 변경하여 버튼과 대조
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    hanjaItem['meaning'].split(',')[0],
                    style: TextStyle(
                      color: Colors.white70, // 부제목 텍스트 색상
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
