import 'package:bmi_calculator/components/my_drawer.dart';
import 'package:bmi_calculator/components/my_textfield.dart';
import 'package:bmi_calculator/database/db.dart';
import 'package:bmi_calculator/models/info.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBMI = Hive.box('myBMI');

  BMIDatabase db = BMIDatabase();

  //text controller
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  //instance of the userInfo
  Info userInfo = Info(Age: 0, height: 0, weight: 0, selectGender: null);
  double? bmiResult;

  //submit method
  void submit() {
    setState(() {
      userInfo.height = int.tryParse(heightController.text) ?? 0;
      userInfo.weight = int.tryParse(weightController.text) ?? 0;

      //calculate bmi
      bmiResult = userInfo.calculateBMI();

      //save to db
      db.saveEntry(userInfo, bmiResult!, userInfo.getBMICategory(bmiResult!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,

      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),

      drawer: MyDrawer(),

      body: Center(
        child: Container(
          // height: 470,
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade400,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600.withOpacity(1),
                spreadRadius: 3,
                blurRadius: 8,
                offset: Offset(4, 4),
              ),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.only(
              right: 25,
              left: 25,
              top: 35,
              bottom: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Age
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Age',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    //age controller
                    Expanded(child: MyTextfield(controller: ageController)),

                    SizedBox(width: 10),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text('2 - 120', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),

                // Gender Selection
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      //Male an female checkbox
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('Male'),
                              value: userInfo.selectGender == 'Male',
                              onChanged: (value) {
                                setState(() {
                                  userInfo.selectGender = 'Male';
                                });
                              },
                            ),
                          ),

                          SizedBox(width: 20),

                          Expanded(
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('Female'),
                              value: userInfo.selectGender == 'Female',
                              onChanged: (value) {
                                setState(() {
                                  userInfo.selectGender = 'Female';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Height and weight
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //height
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'Height',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyTextfield(
                          controller: heightController,
                          hintText: 'cm',
                        ),
                      ),
                      SizedBox(width: 10),

                      SizedBox(width: 10),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      //Age
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'weight',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyTextfield(
                          controller: weightController,
                          hintText: 'Kg',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                //submit button
                ElevatedButton(
                  onPressed: submit,

                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.grey[900], fontSize: 18),
                  ),
                ),

                SizedBox(width: 20),

                //result
                if (bmiResult != null)
                  Column(
                    children: [
                      Text(
                        "Your BMI is ${bmiResult!.toStringAsFixed(1)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${userInfo.getBMICategory(bmiResult!)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
