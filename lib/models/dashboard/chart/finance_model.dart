// Model for financial bar chart
class FinanceBar {
  const FinanceBar({required this.label, required this.value});

  final String label;
  final double value;
}

final List<FinanceBar> sampleChartDataFinancial = <FinanceBar>[
  const FinanceBar(label: "Expenses", value: 15),
  const FinanceBar(label: "Income", value: 40),
  const FinanceBar(label: "Savings", value: 60),
  const FinanceBar(label: "Invest", value: 25),

  const FinanceBar(label: "Expenses", value: 15),
  const FinanceBar(label: "Income", value: 40),
  const FinanceBar(label: "Savings", value: 60),
  const FinanceBar(label: "Invest", value: 25),
];
