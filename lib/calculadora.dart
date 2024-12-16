import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  void _botaoPressionado(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calculaResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  void _calculaResultado() {
    try {
      _resultado = _avaliaExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Não é possivel calcular';
    }
  }

  double _avaliaExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget _botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _botaoPressionado(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            _expressao,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          child: Text(
            _resultado,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            children: [
              _botao('7'),
              _botao('8'),
              _botao('9'),
              _botao('÷'),
              _botao('4'),
              _botao('5'),
              _botao('6'),
              _botao('x'),
              _botao('1'),
              _botao('2'),
              _botao('3'),
              _botao('-'),
              _botao('0'),
              _botao('.'),
              _botao('='),
              _botao('+'),
            ],
          ),
        ),
        Expanded(
          child: _botao(_limpar),
        )
      ],
    );
  }
}