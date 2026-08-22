import 'dart:io';

void main() {
  // Dados do visitante
  int id = 1;
  String? nome;
  int? idade;
  double? altura;

  // Dados do ingresso
  double valorIngresso = 50.0;
  double? cupomDesconto;
  String? cupomAplicado;

  // Entrada de dados básicos
  stdout.write('Digite o seu nome: ');
  nome = stdin.readLineSync();

  stdout.write('Digite sua idade: ');
  idade = int.parse(stdin.readLineSync()!);

  stdout.write('Digite sua altura (ex: 1.60): ');
  altura = double.parse(stdin.readLineSync()!);

  // Solicitar o cupom de desconto
  stdout.write(
    'Digite o seu cupom de desconto: (ou pressione Enter para nenhum): ',
  );
  String? entradaCupom = stdin.readLineSync();

  // Verifica se o usuário digitou algo (removendo espaços em branco)
  if (entradaCupom != null && entradaCupom.trim().isNotEmpty) {
    cupomAplicado = entradaCupom.trim().toUpperCase();

    // Validação do cupom digitado
    if (cupomAplicado == 'FATEC50' || cupomAplicado == 'SORRISO50') {
      cupomDesconto = 50.0; // 50% de desconto
    } else {
      cupomDesconto = 0.0;
      print('Aviso: Cupom inválido! Nenhum desconto aplicado.');
    }
  } else {
    // Se não digitou nada, fica nulo
    cupomAplicado = null;
    cupomDesconto = null;
  }

  // Verificação de segurança (Permissão do brinquedo)
  String statusPermissao;
  if (idade >= 12 && altura >= 1.50) {
    statusPermissao = 'Passagem Permitida,  Bons sorrisos!!!';
  } else {
    statusPermissao = 'Passagem negada, você não tem permissão para entrar neste brinquedo 😥';
  }

  // Cálculo do valor final
  double valorFinal = valorIngresso;
  if (cupomDesconto != null && cupomDesconto! > 0) {
    valorFinal = valorIngresso - (valorIngresso * cupomDesconto! / 100);
  }

  // Status do cupom para exibição
  String statusCupom = (cupomDesconto != null && cupomDesconto! > 0)
      ? 'Desconto Aplicado'
      : 'Sem Desconto';

  // Exibição dos resultados
  print('\n========== PARQUE DE DIVERSÕES SORRISO REAL ==========');
  print('ID: $id');
  print('No me: $nome');
  print('Idade: $idade anos');
  print('Altura: ${altura.toStringAsFixed(2)} m');
  print('Status Cupom: $statusCupom');
  print('Cupom: ${cupomAplicado ?? 'Nenhum cupom utilizado'}');
  print('Valor do ingresso: R\$ ${valorIngresso.toStringAsFixed(2)}');
  print('Valor final: R\$ ${valorFinal.toStringAsFixed(2)}');
  print('Status Permissão: $statusPermissao');
}
