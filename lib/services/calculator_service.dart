class CalculatorService {

  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  String analyzeBMI(bmi) {

    var result = "";

    if (bmi < 16) {
      result = "Magreza grave";
    }
    if (bmi >= 16 && bmi < 17) {
      result = "Magreza moderada";
    }
    if (bmi >= 17 && bmi < 18.5) {
      result = "Magreza leve";
    }
    if (bmi >= 18.5 && bmi < 25) {
      result = "Saudável";
    }
    if (bmi >= 25 && bmi < 30) {
      result = "Sobrepeso";
    }
    if (bmi >= 30 && bmi < 35) {
      result = "Obesidade Grau I";
    }
    if (bmi >= 35 && bmi < 40) {
      result = "Obesidade Grau II";
    }
    if (bmi >= 40) {
      result = "Obesidade Grau III";
    }
    
    return result;
  }
}
