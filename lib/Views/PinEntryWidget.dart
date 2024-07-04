import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

typedef PinEnteredCallback = void Function(String pin);

class PinEntryWidget extends StatefulWidget {
  final PinEnteredCallback onPinEntered;

  PinEntryWidget({required this.onPinEntered});

  @override
  _PinEntryWidgetState createState() => _PinEntryWidgetState();
}

class _PinEntryWidgetState extends State<PinEntryWidget> {
  String pin = '';

  void enterDigit(int digit) {
    if (pin.length < 4) {
      setState(() {
        pin += digit.toString();
      });
      if (pin.length == 4) {
        // Notify parent widget with entered PIN
        widget.onPinEntered(pin);
      }
    }
  }

  void deleteDigit() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Enter PIN:',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            pin,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(left: 4.w, right: 4.w),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 30.0,
              ),
              itemBuilder: (context, index) {
                if (index == 9) {
                  return GestureDetector(
                    onTap: deleteDigit,
                    child: const Icon(Icons.backspace_outlined),
                  );
                } else if (index == 10) {
                  return GestureDetector(
                    onTap: () => enterDigit(0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Center(
                        child: Text(
                          '0',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  );
                } else if (index == 11) {
                  return SizedBox(); // Empty space
                } else {
                  return GestureDetector(
                    onTap: () => enterDigit(index + 1),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
