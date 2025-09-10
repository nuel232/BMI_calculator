import 'package:bmi_calculator/models/info.dart';
import 'package:hive/hive.dart';

class BMIDatabase {
  final _myBMI = Hive.box('myBMI');

  void saveEntry(Info info, double bmi, String category) {
    List allEntries = _myBMI.get('bmiHistory', defaultValue: []);
    allEntries.add({
      'info': info,
      'bmi': bmi,
      'category': category,
      'timestamp': DateTime.now().toString(),
    });
    _myBMI.put('bmiHistory', allEntries);
  }

  List getAllEntries() {
    return _myBMI.get('bmiHistory', defaultValue: []);
  }
}
