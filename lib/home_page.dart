import 'package:bmi_calculator/components/my_textfield.dart';
import 'package:bmi_calculator/models/info.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final TextEditingController heightController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  //instance of the userInfo
  Info userInfo = Info(Age: 0, height: 0, weight: 0, selectGender: null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title: Text('BMI CALCULATOR')),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade500,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 35,
                ),
                child: Row(
                  children: [
                    Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    CheckboxListTile(
                      title: Text('male'),
                      value: userInfo.selectGender == 'Male',
                      onChanged: (value) {
                        setState(() {
                          userInfo.selectGender = 'Male';
                        });
                      },
                    ),
                    SizedBox(width: 20),
                    CheckboxListTile(
                      title: Text('Female'),
                      value: userInfo.selectGender == 'Female',
                      onChanged: (value) {
                        setState(() {
                          userInfo.selectGender = 'Female';
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 35,
                ),
                child: Row(
                  children: [
                    Text(
                      'Height',

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),

                    SizedBox(
                      width: 60,
                      child: MyTextfield(controller: heightController),
                    ),
                    Text('cm', style: TextStyle(fontSize: 14)),

                    SizedBox(width: 10),
                    Text(
                      'Age',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),

                    SizedBox(
                      width: 50,
                      child: MyTextfield(controller: ageController),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
