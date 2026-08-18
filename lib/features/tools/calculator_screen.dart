import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double _amount = 500000;
  double _rate = 6.5;
  double _termYears = 30;

  double get _monthlyRate => _rate / 100 / 12;
  double get _n => _termYears * 12;
  double get _monthly {
    if (_monthlyRate == 0) return _amount / _n;
    final r = _monthlyRate;
    final f = _pow(1 + r, _n);
    return _amount * r * f / (f - 1);
  }
  double get _totalPaid => _monthly * _n;
  double get _totalInterest => _totalPaid - _amount;

  double _pow(double b, double e) {
    var r = 1.0;
    for (var i = 0; i < e.round(); i++) {
      r *= b;
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Loan calculator', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text('Quick home-loan repayment estimate to share with clients.',
            style: TextStyle(fontSize: 13, color: p.mutedForeground)),
        const SizedBox(height: 20),
        mobile
            ? Column(children: [_inputs(p), const SizedBox(height: 16), _result(p)])
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: _inputs(p)),
                const SizedBox(width: 16),
                Expanded(child: _result(p)),
              ]),
      ]),
    );
  }

  Widget _inputs(AppPalette p) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('Inputs', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        _slider('Loan amount', '\$${_amount.round()}', _amount, 100000, 2000000, 10000, (v) => setState(() => _amount = v)),
        const SizedBox(height: 16),
        _slider('Interest rate', '${_rate.toStringAsFixed(2)}%', _rate, 2, 12, 0.1, (v) => setState(() => _rate = v)),
        const SizedBox(height: 16),
        _slider('Term (years)', '${_termYears.round()} yrs', _termYears, 5, 30, 1, (v) => setState(() => _termYears = v)),
      ]),
    );
  }

  Widget _slider(String label, String value, double v, double min, double max, double step, ValueChanged<double> on) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary)),
      ]),
      Slider(value: v, min: min, max: max, divisions: ((max - min) / step).round(), onChanged: on, activeColor: AppColors.primary),
    ]);
  }

  Widget _result(AppPalette p) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('Result', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('Estimated monthly repayment', style: TextStyle(fontSize: 12, color: p.mutedForeground)),
        const SizedBox(height: 12),
        Text('\$${_monthly.toStringAsFixed(2)}', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.primary)),
        const SizedBox(height: 16),
        Divider(height: 1, color: p.border),
        const SizedBox(height: 16),
        _row('Loan amount', '\$${_amount.round()}'),
        _row('Total paid', '\$${_totalPaid.toStringAsFixed(0)}'),
        _row('Total interest', '\$${_totalInterest.toStringAsFixed(0)}', danger: true),
      ]),
    );
  }

  Widget _row(String l, String v, {bool danger = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [
        Expanded(child: Text(l, style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground))),
        Text(v, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: danger ? AppColors.dangerFg : AppColors.foreground)),
      ]));
}
