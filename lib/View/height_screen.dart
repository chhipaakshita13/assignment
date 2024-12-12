import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled/View/profile_view.dart';

import '../Constants/Assetmages.dart';
import '../Constants/CommonColors.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: SvgPicture.asset(AssetImages.backArrow)),
        actions: [
          Text('Skip   ',style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.w500,color: CommonColors.textColor
          ),)
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
          children: [
            StepProgressIndicator(
              totalSteps: 4,
              currentStep: 3,
              selectedColor: CommonColors.textColor,
              unselectedColor: CommonColors.unselectColor,
            ),
            SizedBox(height: height*0.06,),
            Text('What\'s your Height?',style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 15,
                color:CommonColors.text1
            ),),
            SizedBox(height: height*0.007,),
            Text('Help us to create your personalize plan',style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 12,
                color:CommonColors.text2
            ),),
            SizedBox(height: height*0.08,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleSwitch(
                  minWidth:MediaQuery.of(context).size.width/2,
                  cornerRadius: 20.0,
                  activeBgColors: [[CommonColors.textColor]],
                  activeFgColor: Colors.white,
                  inactiveBgColor: CommonColors.borderColor,
                  inactiveFgColor: const Color.fromRGBO(151,151,151,1),
                  initialLabelIndex: 0,
                  totalSwitches: 1,
                  labels: const ['Cm'],
                  radiusStyle: true,
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),


              ],
            ),
            SizedBox(height: height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(AssetImages.body,height: 240,),
                  SizedBox(
                    height: 280,
                    child: SfLinearGauge(
                      orientation: LinearGaugeOrientation.vertical,
                      minimum: 145,  // Minimum value for the gauge
                      maximum: 190,  // Maximum value for the gauge
                      interval: 5,  // Interval between values
                      isAxisInversed: true,
                      markerPointers: [
                        LinearShapePointer(
                          value: 165,
                          color: CommonColors.textColor,
                        ),
                      ],
                      barPointers: const [LinearBarPointer(value: 80,color: Colors.transparent,)],
                    ),
                  ),

              ],
            ),
            SizedBox(height: height*0.1,),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    value: 0.7,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientProfileScreen()));
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
