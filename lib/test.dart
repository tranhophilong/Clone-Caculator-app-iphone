
import 'package:intl/intl.dart';

void main(){
  // String input = "This is a sample string?, with a comma.";
  //
  // RegExp regex = RegExp(r".*,(?!.*\d)");
  // print(regex.hasMatch("0,55"));

  final formatNumber = NumberFormat("###,###.###");
  print(formatNumber.format(1.3 + 2.3));
  // print(0.0001 /2 ); /

  // String numberString = "5.3";
  //
  // double number = double.parse(numberString);
  // int convertedNumber = number.toInt();
  //
  // print(convertedNumber); // Output: 5
  //
  // print("-" + "0");
  //
  print(1.3 + 2.3);

}

