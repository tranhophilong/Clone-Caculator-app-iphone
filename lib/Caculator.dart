import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:intl/intl.dart';


const btnNumberColor =  Color(0xFF616161);
const caculationBtnColor = Color(0xFFFB8C00);
const changeNumberBtnColor = Color(0xFFD6D6D6);

void main(){
    runApp(const CaculatorApp());
}

class CaculatorApp extends StatelessWidget{

  const CaculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CaculatorPage(),

    );
  }

}


class CaculatorPage extends StatefulWidget{
  @override
  State<CaculatorPage> createState() {
   return StateCaculatorPage();
  }

}


class StateCaculatorPage extends State<CaculatorPage> {
  String resultLabel = "0";
  final formatNumber = NumberFormat("###,###.###", "tr_TR");
  var caculationMode = CaculationMode.none;
  double sizeLableResult = 70;
  bool isInputingNumber = true;
  double secondNumber = 0;
  double tempResult = 0;
  var labelForBtnClear = "AC";
  bool isStateAllClear = true;
  bool wasGotResult = false;


  Map<CaculationMode, Color> bgColorForBtnCaculation = {
    CaculationMode.subtraction : caculationBtnColor,
    CaculationMode.multiplication : caculationBtnColor,
    CaculationMode.summation : caculationBtnColor,
    CaculationMode.division : caculationBtnColor
  };

  Map<CaculationMode, Color> tinColorForBtnCaculation = {
    CaculationMode.subtraction : Colors.white,
    CaculationMode.multiplication : Colors.white,
    CaculationMode.summation : Colors.white,
    CaculationMode.division : Colors.white
  };


  @override
  Widget build(BuildContext context) {

    if(isInputingNumber == false){
      switch(caculationMode){
        case (CaculationMode.none):
          print("none");
        case (CaculationMode.division):
          bgColorForBtnCaculation[CaculationMode.division] = Colors.white;
          tinColorForBtnCaculation[CaculationMode.division] = caculationBtnColor;
        case (CaculationMode.summation):
          bgColorForBtnCaculation[CaculationMode.summation] = Colors.white;
          tinColorForBtnCaculation[CaculationMode.summation] = caculationBtnColor;
        case (CaculationMode.multiplication):
          bgColorForBtnCaculation[CaculationMode.multiplication] = Colors.white;
          tinColorForBtnCaculation[CaculationMode.multiplication] = caculationBtnColor;
        case (CaculationMode.subtraction):
          bgColorForBtnCaculation[CaculationMode.subtraction] = Colors.white;
          tinColorForBtnCaculation[CaculationMode.subtraction] = caculationBtnColor;
        default:
      };
    }

    formatResultLabel();
    setLabelForBtnAllClear();

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // const SizedBox(height: 60,),

                   Expanded(child: ScreenCaculator(resultLabel, sizeText: sizeLableResult,)),
                    const SizedBox(height: 30,),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Btn(label: labelForBtnClear,
                                  bgColor: changeNumberBtnColor,
                                  tinColor: Colors.black,
                                  func: deleteResultLabel),
                              Btn(label: "+/-",
                                  bgColor: changeNumberBtnColor,
                                  tinColor: Colors.black,
                                  func: changePrefixNumber),

                              Btn(label: "%",
                                  bgColor: changeNumberBtnColor,
                                  tinColor: Colors.black,
                                  func: divide100),

                              Btn(label: "÷",
                                  bgColor: bgColorForBtnCaculation[CaculationMode.division]!,
                                  tinColor: tinColorForBtnCaculation[CaculationMode.division]!,
                                  func: divisionMode),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Btn(label: "7",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "8",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "9",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "×",
                                  bgColor:bgColorForBtnCaculation[CaculationMode.multiplication]!,
                                  tinColor: tinColorForBtnCaculation[CaculationMode.multiplication]!,
                                  func: multiplicationMode),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [
                              Btn(label: "4",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "5",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "6",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "-",
                                  bgColor: bgColorForBtnCaculation[CaculationMode.subtraction]!,
                                  tinColor: tinColorForBtnCaculation[CaculationMode.subtraction]!,
                                  func: subtractionMode),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Btn(label: "1",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "2",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "3",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "+",
                                  bgColor: bgColorForBtnCaculation[CaculationMode.summation]!,
                                  tinColor: tinColorForBtnCaculation[CaculationMode.summation]!,
                                  func: summationMode),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Btn(label: "0",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: ",",
                                  bgColor: btnNumberColor,
                                  tinColor: Colors.white,
                                  func: addNumberToScreen),
                              Btn(label: "=",
                                  bgColor: caculationBtnColor,
                                  tinColor: Colors.white,
                                  func: getResult),

                            ],
                          ),

                        ],),
                    ),

                  ],
                )
            )
        )
    );
  }

  void changeSizeLabelResult(){
    if (resultLabel.length <= 7){
      sizeLableResult = 75;
    }else if(resultLabel.length == 9){
      sizeLableResult = 70;
    }else if(resultLabel.length == 10){
      sizeLableResult = 60;
    }else{
      sizeLableResult = 55;
    }
  }

  // Helper function

  void addNumberToScreen(String val) {
    setState(() {
      if (resultLabel.length == 11){
        resultLabel = resultLabel;
      }else{
        if (resultLabel == "0" && caculationMode == CaculationMode.none) {
          if (val == ",") {
            resultLabel = "0,";
          } else {
            resultLabel = val;
          }
        }else{
          if (resultLabel.contains(",") && val == ",") {
            resultLabel += "";
          } else {
            if(isInputingNumber){
              resultLabel += val;
              secondNumber = convertStringToNumber(resultLabel);
            }else{
              resetColorForBtnCaculation();
              resultLabel = val;
              secondNumber = double.parse(val);
              isInputingNumber = true;
            }
          }
        }
      }

      isStateAllClear = false;

    });
  }

  void formatResultLabel(){
    try{
      resultLabel =  formatNumber.format(int.parse(resultLabel.replaceAll(("."), "").replaceAll(",", ".")));
      changeSizeLabelResult();
    }catch(e){

    }

  }

  double convertStringToNumber(String val){
    return double.parse(val.replaceAll(".", "").replaceAll(",", "."));
  }

  void setLabelForBtnAllClear(){
    if(isStateAllClear){
      labelForBtnClear = "AC";
    }else{
      labelForBtnClear = "C";
    }
  }

  void getResult(String val){
    setState(() {

      caculation();
      resetColorForBtnCaculation();
      isInputingNumber = true;
      wasGotResult = true;

    });
  }

  void deleteResultLabel(String val) {
    setState(() {
        if (!isStateAllClear ){
          if (wasGotResult) {
            resultLabel = "0";
            tempResult = 0;
            resetColorForBtnCaculation();
            isInputingNumber = true;
          }else{
            resultLabel = "0";
            secondNumber = 0;
            isInputingNumber = false;
          }
          isStateAllClear = true;

        }else{
          resetColorForBtnCaculation();
          isInputingNumber = true;
          caculationMode = CaculationMode.none;
          tempResult = 0;
          secondNumber = 0;
          resultLabel = "0";
        }

    });
  }

  void caculation(){

    switch(caculationMode){
      case (CaculationMode.summation):
        resultLabel = "${(formatNumber.format(tempResult + secondNumber))}";
      case (CaculationMode.subtraction):
        resultLabel = "${(formatNumber.format(tempResult - secondNumber))}";
      case (CaculationMode.multiplication):
        resultLabel = "${(formatNumber.format(tempResult * secondNumber))}";
      case (CaculationMode.division):
        resultLabel = "${(formatNumber.format(tempResult / secondNumber))}";
      default:
    }
    resultLabel = resultLabel.replaceAll(("."), ",").replaceAll(",0", "");
    tempResult = convertStringToNumber(resultLabel);
  }

  void eventForCaculation(CaculationMode mode){
    resetColorForBtnCaculation();
    caculationMode = mode;
    if(secondNumber == 0 ){
      secondNumber = convertStringToNumber(resultLabel);
    }else if(wasGotResult == false && isInputingNumber == true){
        caculation();
    }
    tempResult = convertStringToNumber(resultLabel);
    isInputingNumber = false;
    wasGotResult = false;
  }


  void summationMode(String val){
    setState(() {
      eventForCaculation(CaculationMode.summation);
    });

  }



  void multiplicationMode(String val){
    setState(() {
        eventForCaculation(CaculationMode.multiplication);
    });
  }


  void subtractionMode(String val){
    setState(() {
      eventForCaculation(CaculationMode.subtraction);
    });

  }


  void divisionMode(String val){
    setState(() {
      eventForCaculation(CaculationMode.division);
    });
  }

  void resetColorForBtnCaculation(){
    bgColorForBtnCaculation[caculationMode] = caculationBtnColor;
    tinColorForBtnCaculation[caculationMode] = Colors.white;
  }



  void divide100(String val) {
    setState(() {
      resultLabel = "${ convertStringToNumber(resultLabel) / 100}".replaceAll(("."), ",");
    });
  }

  void changePrefixNumber(String val) {
    setState(() {

      if (resultLabel[0] == "-") {
        resultLabel = resultLabel.replaceFirst("-", "");
      } else {
        resultLabel = "-" + resultLabel;
      }
    });
  }




}

enum CaculationMode{
  multiplication, summation, subtraction, division, none;

}

class Btn extends StatelessWidget{

  final String label ;
  final Function(String) func;
  final Color bgColor;
  final Color tinColor;

  // final OutlineInputBorder shapeBtn;


  const Btn({required this.label,required this.bgColor, required this.tinColor,  required this.func, super.key});

  @override
  Widget build(BuildContext context) {
      Size sizeScreen = MediaQuery.of(context).size;
      var widthBtn = (sizeScreen.width / 4) - 9*2;
      var heightBtn = (sizeScreen.width / 4) - 9*2;
      AlignmentGeometry align = Alignment.center;
      if (label == "0"){
        widthBtn = widthBtn*2;
        align = Alignment.centerLeft;
      }
      return TextButton(

          onPressed: (){
            func(label);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(180)
            ),
            backgroundColor:  bgColor,
            // fixedSize: Size(100, 100),
              minimumSize: Size(widthBtn, heightBtn),
            onPrimary: tinColor,
            alignment: align
          ),
        child: FittedBox(
          fit: BoxFit.fill,
          child:  Text(label,
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 30
        ),
      ),
    ),

      );
  }



}


class ScreenCaculator extends StatelessWidget{
  final String label;
  final double sizeText;
   const ScreenCaculator(this.label, { required this.sizeText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomRight,
        child: Text(label, style:  TextStyle(
          color:  Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: sizeText,

        ),)
    );
  }


}

















