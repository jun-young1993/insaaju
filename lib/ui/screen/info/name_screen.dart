import 'package:flutter/material.dart';
import 'package:insaaju/ui/screen/widget/button.dart';

class NameScreen extends StatelessWidget {
  final Function(String)? onTap;
  final String? name;
  late final TextEditingController _nameController;

  NameScreen({
    super.key, 
    this.name,
    this.onTap, 
  }) {
    _nameController = TextEditingController(text: name ?? '');
  }

  @override
  Widget build(BuildContext context){
    return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              SizedBox(height: 20),
              AppButton(
                onPressed: () {
                  String name = _nameController.text;
                  if (name.isNotEmpty) {
                    onTap!(name);
                  } else {
                    // 이름이 입력되지 않은 경우 경고 메시지
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Input Required'),
                          content: Text('Please enter your name before proceeding.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('OK'),
              ),
            ],
        ),
      );
 
  }
}