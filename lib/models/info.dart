import 'package:hive/hive.dart';

part 'info.g.dart';

@HiveType(typeId: 0)
class Info extends HiveObject {
  @HiveField(0)
  int Age;

  @HiveField(1)
  int height;

  @HiveField(2)
  int weight;

  @HiveField(3)
  String? selectGender;

  Info({
    required this.Age,
    required this.height,
    required this.weight,
    required this.selectGender,
  });

  double calculateBMI() {
    // Convert height from cm to meters
    double heightInMeters = height / 100;

    // Apply BMI formula
    double bmi = weight / (heightInMeters * heightInMeters);

    return bmi;
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "you are underweight";
    } else if (bmi < 25) {
      return "You are normal weight";
    } else if (bmi < 30) {
      return "Your are overweight";
    } else if (bmi < 35) {
      return "You are obesity Class I";
    } else if (bmi < 40) {
      return "You are obesity Class II";
    } else {
      return "you are obesity Class III";
    }
  }

  @override
  String toString() {
    return "Age: $Age, Height: ${height}cm, Weight: ${weight}kg, Gender: ${selectGender ?? 'N/A'}";
  }
}
