import 'package:flutter/material.dart';
import 'new_transaction_view.dart';

// ============================================================================
// FÁBRICA DA CENA DE NOVO LANÇAMENTO (TransactionFactory)
// Responsável por instanciar e retornar a tela de cadastro de nova transação.
// ============================================================================
class TransactionFactory {
  static Widget create() {
    return const NewTransactionView();
  }
}