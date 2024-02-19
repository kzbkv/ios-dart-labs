import 'dart:io';
import 'dart:math';

void main() {
  print('Простой калькулятор');

  while (true) {
    stdout.write('Введите первое число: ');
    double num1 = double.tryParse(stdin.readLineSync()!) ?? 0.0;

    stdout.write(
        'Введите оператор (+, -, *, /, ^ для возведения в степень, s для квадратного корня): ');
    String operator = stdin.readLineSync()!;

    stdout.write('Введите второе число: ');
    double num2 = double.tryParse(stdin.readLineSync()!) ?? 0.0;

    double result;

    try {
      switch (operator) {
        case '+':
          result = add(num1, num2);
          break;
        case '-':
          result = subtract(num1, num2);
          break;
        case '*':
          result = multiply(num1, num2);
          break;
        case '/':
          result = divide(num1, num2);
          break;
        case '^':
          result = power(num1, num2);
          break;
        case 's':
          result = squareRoot(num1);
          break;
        default:
          throw Exception('Некорректный оператор');
      }
      print('Результат: $result');
    } catch (e) {
      print('Ошибка: $e');
    }

    stdout.write('Желаете продолжить? (да/нет): ');
    String continueInput = stdin.readLineSync()!.toLowerCase();
    if (continueInput != 'да') break;
  }
}

double add(double a, double b) {
  return a + b;
}

double subtract(double a, double b) {
  return a - b;
}

double multiply(double a, double b) {
  return a * b;
}

double divide(double a, double b) {
  if (b == 0) {
    throw Exception('Деление на ноль невозможно');
  }
  return a / b;
}

double power(double base, double exponent) {
  return pow(base, exponent).toDouble();
}

double squareRoot(double number) {
  if (number < 0) {
    throw Exception(
        'Извлечение квадратного корня из отрицательного числа невозможно');
  }
  return sqrt(number);
}
