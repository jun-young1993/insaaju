import 'package:flutter/material.dart';
import 'package:insaaju/ui/screen/widget/button.dart';

class HanjaScreen extends StatelessWidget {
  final List<List<Map<String, dynamic>>>? hanja;
  final String? name;

  const HanjaScreen({
    this.hanja,
    this.name,
    Key? key,
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
                    children: List.generate(hanja!.length, (index) {
                      return Expanded(
                        child: Column(
                          children: [
                            Text(
                              name![index],
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: hanja![index].length,
                                itemBuilder: (context, hanjaIndex) {
                                  final hanjaItem = hanja![index][hanjaIndex];
                                  return GestureDetector(
                                    onTap: () {
                                      // 선택된 한자를 처리하는 로직
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(hanjaItem['hanja']),
                                            Text(hanjaItem['meaning']
                                                .split(',')[0]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppButton(
                    onPressed: () {
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
}
