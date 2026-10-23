import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculadoraHomePage(),
    );
  }
}

class CalculadoraHomePage extends StatefulWidget {
  const CalculadoraHomePage({super.key});

  @override
  State<CalculadoraHomePage> createState() => _CalculadoraHomePageState();
}

class _CalculadoraHomePageState extends State<CalculadoraHomePage> {
  // Controladores para capturar o texto digitado nos inputs
  final TextEditingController _controllerNum1 = TextEditingController();
  final TextEditingController _controllerNum2 = TextEditingController();

  // Variável para armazenar o resultado
  double? _resultado;

  // Função genérica para realizar as operações
  void _calcular(String operacao) {
    // Converte os textos para double (caso estejam vazios, assume 0)
    double num1 = double.tryParse(_controllerNum1.text) ?? 0;
    double num2 = double.tryParse(_controllerNum2.text) ?? 0;

    setState(() {
      switch (operacao) {
        case '+':
          _resultado = num1 + num2;
          break;
        case '-':
          _resultado = num1 - num2;
          break;
        case '*':
          _resultado = num1 * num2;
          break;
        case '/':
          if (num2 == 0) {
            // Tratamento simples para divisão por zero
            _resultado = null;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Erro: Divisão por zero!')),
            );
          } else {
            _resultado = num1 / num2;
          }
          break;
      }
    });
  }

  @override
  void dispose() {
    // Limpa os controladores ao destruir o widget
    _controllerNum1.dispose();
    _controllerNum2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculadora Simples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo para o primeiro número
            TextField(
              controller: _controllerNum1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o primeiro número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Campo para o segundo número
            TextField(
              controller: _controllerNum2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o segundo número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Linha com os botões das 4 operações
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _calcular('+'),
                  child: const Text('+', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('-'),
                  child: const Text('-', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('*'),
                  child: const Text('×', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('/'),
                  child: const Text('÷', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Exibição do Resultado
            Text(
              _resultado == null
                  ? 'Resultado: '
                  : 'Resultado: ${_resultado!.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}