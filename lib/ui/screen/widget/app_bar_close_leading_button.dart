

import 'package:flutter/material.dart';

class AppBarCloseLeadingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  const AppBarCloseLeadingButton({
    super.key, required
    this.onPressed, this.child
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: (){
              onPressed();
            },
            icon: const Icon(Icons.close)
        ),
        if(child != null)
          Expanded(child: child!)
        // TitleText(text: 'ADD'),
      ],
    );
  }
  
}