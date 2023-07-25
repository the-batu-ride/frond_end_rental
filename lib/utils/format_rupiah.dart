// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

String formatRupiah(dynamic amount) {
  final formatCurrency = NumberFormat.currency(locale: 'id', symbol: 'Rp');
  return formatCurrency.format(amount);
}
