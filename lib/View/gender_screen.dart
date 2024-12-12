
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled/View/weight_screen.dart';

import '../Constants/Assetmages.dart';
import '../Constants/CommonColors.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(onPressed: (){}, icon: SvgPicture.asset(AssetImages.backArrow)),
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
              currentStep: 2,
              selectedColor: CommonColors.textColor,
              unselectedColor: CommonColors.unselectColor,
            ),
            SizedBox(height: height*0.06,),
            Text('Select your gender',style: TextStyle(
              fontWeight: FontWeight.w500,fontSize: 15,
              color:CommonColors.text1
            ),),
            SizedBox(height: height*0.007,),
            Text('Help us to create your personalize plan',style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 12,
                color:CommonColors.text2
            ),),
            SizedBox(height: height*0.13,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Female Column
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align radio button to the top of the image
                      children: [
                        // Female icon (image)
                        SvgPicture.asset(
                          AssetImages.female,
                        ),
                        SizedBox(width: 5),

                        Radio<String>(
                          value: 'female',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                // Male Column
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AssetImages.male,
                        ),
                        const SizedBox(width: 5),
                        Radio<String>(
                          value: 'male',
                          groupValue: _selectedGender,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height*0.05,),
            Center(
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: CommonColors.borderColor),
                  borderRadius: BorderRadius.circular(5)
                ),
                width: 130,
                child: Center(
                  child: Text('Other',style: TextStyle(
                      fontWeight: FontWeight.w500,fontSize: 15,
                      color:CommonColors.text1
                  )),
                ),
              ),
            ),
            SizedBox(height: height*0.05,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColors: [[CommonColors.textColor],const [Color.fromRGBO(82,46,210,1)],const [Color.fromRGBO(82,46,210,1)]],
                  activeFgColor: Colors.white,
                  inactiveBgColor: CommonColors.borderColor,
                  inactiveFgColor: const Color.fromRGBO(151,151,151,1),
                  initialLabelIndex: 1,
                  totalSwitches: 3,
                  labels: const ['Female', 'Male','Other'],
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
            SizedBox(height: height*0.05,),

            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    value: 0.5,
                    valueColor: AlwaysStoppedAnimation(CommonColors.textColor),
                  ),
                ),

                GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: CommonColors.textColor,
                    radius: 24,
                    child: SvgPicture.asset(AssetImages.forward),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const WeightScreen()));
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
