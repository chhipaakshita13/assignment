import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled/View/height_screen.dart';

import '../Constants/Assetmages.dart';
import '../Constants/CommonColors.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  double _currentValue = 85.0;
  double _getPointerAngle() {
    return (pi / (200 - 80)) * (_currentValue - 80) - pi / 2;
  }
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: SvgPicture.asset(AssetImages.backArrow)),

      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            StepProgressIndicator(
              totalSteps: 4,
              currentStep: 4,
              selectedColor: CommonColors.textColor,
              unselectedColor: CommonColors.unselectColor,
            ),
            SizedBox(height: height*0.06,),
            Text('What\'s your Weight?',style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 15,
                color:CommonColors.text1
            ),),
            SizedBox(height: height*0.007,),
            Text('Help us to create your personalize plan',style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 12,
                color:CommonColors.text2
            ),),
            SizedBox(height: height*0.13,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleSwitch(
                  minWidth:MediaQuery.of(context).size.width,
                  cornerRadius: 20.0,
                  activeBgColors: [[CommonColors.textColor],const [Color.fromRGBO(82,46,210,1)],const [Color.fromRGBO(82,46,210,1)]],
                  activeFgColor: Colors.white,
                  inactiveBgColor: CommonColors.borderColor,
                  inactiveFgColor: const Color.fromRGBO(151,151,151,1),
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  labels: const ['kg', 'Lbs'],
                  radiusStyle: true,

                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),


                // SizedBox(height: 20),
                // Text(
                //   'Selected Gender: ${_genders[_selectedIndex]}',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
              ],
            ),

            Container(
              height: 200,
              width: 300,
              child: Stack(
                children: [
                  // Half Radial Gauge
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: CustomPaint(
                        painter: HorizontalSemiCirclePainter(_currentValue),
                      ),
                    ),
                  ),
                  // Displaying the current value inside the gauge
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 105),
                      child: SvgPicture.asset(AssetImages.drop),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25,),
            RichText(text: TextSpan(children:[
              TextSpan(
                text: '95',style: TextStyle(
                fontSize: 50,fontWeight: FontWeight.w600,color: CommonColors.textColor
              )
              ),
              TextSpan(
                  text: 'kg',style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.w600,color: CommonColors.text1
              )
              ),
            ])),
            SizedBox(height: height*0.1,),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    value: 1,
                    valueColor: AlwaysStoppedAnimation(CommonColors.textColor),
                  ),
                ),
               GestureDetector(
                 child:  CircleAvatar(
                   backgroundColor: CommonColors.textColor,
                   radius: 24,
                   child: SvgPicture.asset(AssetImages.forward),
                 ),
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const HeightScreen()));
                 },
               )
              ],
            )
          ],
        ),
      ),
    );
  }
}
class HorizontalSemiCirclePainter extends CustomPainter {
  final double currentValue;
  HorizontalSemiCirclePainter(this.currentValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    Paint arcPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    Paint tickPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw the background semi-circle gauge (half circle)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: size.width / 2),
      pi, // Start angle (left side)
      pi, // Sweep angle (half circle)
      false,
      circlePaint,
    );

    // Draw the gauge arc based on the current value
    double sweepAngle = (currentValue - 85) / (200 - 80) * pi;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: size.width / 2),
      pi, // Start angle (left side)
      sweepAngle, // Draw the arc according to the value
      false,
      arcPaint,
    );

    // Draw tick marks (for example every 10 units)
    for (double i = 80; i <= 200; i += 10) {
      double angle = _getTickAngle(i);
      double x = size.width / 2 + (size.width / 2) * 0.85 * cos(angle);
      double y = size.height + (size.width / 2) * 0.85 * sin(angle);

      double xEnd = size.width / 2 + (size.width / 2) * 0.9 * cos(angle);
      double yEnd = size.height + (size.width / 2) * 0.9 * sin(angle);

      canvas.drawLine(Offset(x, y), Offset(xEnd, yEnd), tickPaint);
    }
  }

  double _getTickAngle(double value) {
    return (pi / (200 - 80)) * (value - 80) + pi; // Adjust to the horizontal semi-circle
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Custom painter for the drop-shaped pointer
class DropPointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint pointerPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Path pointerPath = Path();
    pointerPath.moveTo(size.width / 2, 0);  // Move to the top
    pointerPath.quadraticBezierTo(size.width / 2 - 10, size.height * 0.6, size.width / 2, size.height);  // Drop shape
    pointerPath.quadraticBezierTo(size.width / 2 + 10, size.height * 0.6, size.width / 2, 0);  // Drop shape
    pointerPath.close();

    canvas.drawPath(pointerPath, pointerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

