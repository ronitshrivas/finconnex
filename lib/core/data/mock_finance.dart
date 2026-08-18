import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum FinStatus { accepted, sent, draft, rejected, partiallyPaid, overdue, completed, pending, failed, refunded, active, inactive }

extension FinStatusX on FinStatus {
  String get label => switch (this) {
        FinStatus.accepted => 'Accepted',
        FinStatus.sent => 'Sent',
        FinStatus.draft => 'Draft',
        FinStatus.rejected => 'Rejected',
        FinStatus.partiallyPaid => 'Partially Paid',
        FinStatus.overdue => 'Overdue',
        FinStatus.completed => 'Completed',
        FinStatus.pending => 'Pending',
        FinStatus.failed => 'Failed',
        FinStatus.refunded => 'Refunded',
        FinStatus.active => 'Active',
        FinStatus.inactive => 'Inactive',
      };
  Color get bg => switch (this) {
        FinStatus.accepted || FinStatus.completed || FinStatus.active => AppColors.successBg,
        FinStatus.sent || FinStatus.partiallyPaid || FinStatus.pending => AppColors.warningBg,
        FinStatus.draft || FinStatus.inactive || FinStatus.refunded => AppColors.neutralBg,
        FinStatus.rejected || FinStatus.overdue || FinStatus.failed => AppColors.dangerBg,
      };
  Color get fg => switch (this) {
        FinStatus.accepted || FinStatus.completed || FinStatus.active => AppColors.successFg,
        FinStatus.sent || FinStatus.partiallyPaid || FinStatus.pending => AppColors.warningFg,
        FinStatus.draft || FinStatus.inactive || FinStatus.refunded => AppColors.neutralFg,
        FinStatus.rejected || FinStatus.overdue || FinStatus.failed => AppColors.dangerFg,
      };
}

// ─── Hub ────────────────────────────────────────────────────────────────
class HubStat {
  final String label;
  final String value;
  final String sub;
  final Color subColor;
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final bool valueDanger;
  const HubStat({
    required this.label,
    required this.value,
    required this.sub,
    required this.subColor,
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    this.valueDanger = false,
  });
}

const kHubStats = <HubStat>[
  HubStat(
    label: 'TOTAL REVENUE (YTD)',
    value: '\$2.4M',
    sub: '↑ +14.5% vs last year',
    subColor: AppColors.successFg,
    icon: Icons.trending_up,
    iconBg: AppColors.successBg,
    iconFg: AppColors.successFg,
  ),
  HubStat(
    label: 'PENDING ESTIMATES',
    value: '42',
    sub: 'Value: \$185k',
    subColor: AppColors.mutedForeground,
    icon: Icons.article_outlined,
    iconBg: AppColors.warningBg,
    iconFg: AppColors.warningFg,
  ),
  HubStat(
    label: 'OVERDUE INVOICES',
    value: '12',
    sub: 'Total: \$45.2k',
    subColor: AppColors.dangerFg,
    icon: Icons.warning_amber_outlined,
    iconBg: AppColors.dangerBg,
    iconFg: AppColors.dangerFg,
    valueDanger: true,
  ),
  HubStat(
    label: 'QUOTE CONVERSION',
    value: '68%',
    sub: '↑ +2% this month',
    subColor: AppColors.successFg,
    icon: Icons.track_changes,
    iconBg: AppColors.primarySoft,
    iconFg: AppColors.primary,
  ),
];

class HubActivity {
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String title;
  final String subtitle;
  final String time;
  const HubActivity({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

const kHubActivity = <HubActivity>[
  HubActivity(
    icon: Icons.attach_money,
    iconBg: AppColors.successBg,
    iconFg: AppColors.successFg,
    title: 'Payment received for Invoice INV-2023-089',
    subtitle: 'Acme Corp  •  \$4,500.00',
    time: '10 mins ago',
  ),
  HubActivity(
    icon: Icons.check_circle_outline,
    iconBg: AppColors.primarySoft,
    iconFg: AppColors.primary,
    title: 'Quote approved by client',
    subtitle: 'TechFlow Solutions…',
    time: '2 hours ago',
  ),
  HubActivity(
    icon: Icons.warning_amber_outlined,
    iconBg: AppColors.warningBg,
    iconFg: AppColors.warningFg,
    title: 'Invoice overdue by 5 days',
    subtitle: 'Global Industries  •  INV…',
    time: 'Yesterday, 9:00 AM',
  ),
  HubActivity(
    icon: Icons.request_quote_outlined,
    iconBg: AppColors.infoBg,
    iconFg: AppColors.infoFg,
    title: 'Quote sent to prospect',
    subtitle: 'Nexus Group  •  QTE-0…',
    time: 'Yesterday, 2:30 PM',
  ),
];

const kRevenueSeries = [
  [42.0, 32.0], [55.0, 40.0], [48.0, 35.0], [68.0, 46.0], [74.0, 52.0], [62.0, 44.0],
];
const kRevenueMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

// ─── Estimates ─────────────────────────────────────────────────────────
class Estimate {
  final String id;
  final String client;
  final String clientInitials;
  final String email;
  final String validUntil;
  final String totalValue;
  final String expiry;
  final FinStatus status;
  const Estimate({
    required this.id,
    required this.client,
    required this.clientInitials,
    required this.email,
    required this.validUntil,
    required this.totalValue,
    required this.expiry,
    required this.status,
  });
}

const kEstimates = <Estimate>[
  Estimate(id: 'EST-3001', client: 'Greystone Realty', clientInitials: 'GR', email: 'priya@greystone.example', validUntil: '31/07/2026', totalValue: '\$2,915.00', expiry: '31/07/2026', status: FinStatus.accepted),
  Estimate(id: 'EST-3002', client: 'Harbour Loans', clientInitials: 'HL', email: 'marcus@harbour.example', validUntil: '05/08/2026', totalValue: '\$4,070.00', expiry: '05/08/2026', status: FinStatus.sent),
  Estimate(id: 'EST-3003', client: 'Northside Mortgage', clientInitials: 'NM', email: 'aisha@northside.example', validUntil: '15/08/2026', totalValue: '\$935.00', expiry: '15/08/2026', status: FinStatus.draft),
  Estimate(id: 'EST-3004', client: 'Apex Property Group', clientInitials: 'AP', email: 'daniel@apex.example', validUntil: '20/07/2026', totalValue: '\$3,300.00', expiry: '20/07/2026', status: FinStatus.rejected),
];

// ─── Quotations ────────────────────────────────────────────────────────
class Quote {
  final String id;
  final String client;
  final String clientInitials;
  final String issueDate;
  final String totalValue;
  final FinStatus status;
  const Quote({
    required this.id, required this.client, required this.clientInitials,
    required this.issueDate, required this.totalValue, required this.status,
  });
}

const kQuotes = <Quote>[
  Quote(id: 'QUO-3101', client: 'Greystone Realty', clientInitials: 'GR', issueDate: '31/07/2026', totalValue: '\$2,915.00', status: FinStatus.accepted),
  Quote(id: 'QUO-3102', client: 'Harbour Loans', clientInitials: 'HL', issueDate: '10/08/2026', totalValue: '\$4,070.00', status: FinStatus.sent),
  Quote(id: 'QUO-3103', client: 'Northside Mortgage', clientInitials: 'NM', issueDate: '20/08/2026', totalValue: '\$935.00', status: FinStatus.draft),
];

// ─── Invoices ──────────────────────────────────────────────────────────
class Invoice {
  final String id;
  final String subtitle;
  final String client;
  final String due;
  final FinStatus status;
  final String paid;
  final String balance;
  const Invoice({
    required this.id, required this.subtitle, required this.client,
    required this.due, required this.status, required this.paid, required this.balance,
  });
}

const kInvoices = <Invoice>[
  Invoice(id: 'INV-3201', subtitle: 'Greystone refinance invoice', client: 'Greystone Realty', due: '29/07/2026', status: FinStatus.partiallyPaid, paid: '\$1,500.00', balance: '\$1,415.00'),
  Invoice(id: 'INV-3202', subtitle: 'Harbour deposit invoice', client: 'Harbour Loans', due: '03/08/2026', status: FinStatus.sent, paid: '\$0.00', balance: '\$1,650.00'),
  Invoice(id: 'INV-3203', subtitle: 'Northside review invoice', client: 'Northside Mortgage', due: '04/08/2026', status: FinStatus.draft, paid: '\$0.00', balance: '\$935.00'),
  Invoice(id: 'INV-3204', subtitle: 'Apex overdue invoice', client: 'Apex Property Group', due: '15/06/2026', status: FinStatus.overdue, paid: '\$0.00', balance: '\$1,650.00'),
];

// ─── Payments ──────────────────────────────────────────────────────────
class Payment {
  final String id;
  final String date;
  final String invoice;
  final String client;
  final String method;
  final FinStatus status;
  final String amount;
  const Payment({
    required this.id, required this.date, required this.invoice, required this.client,
    required this.method, required this.status, required this.amount,
  });
}

const kPayments = <Payment>[
  Payment(id: 'PAY-3301', date: '18/07/2026', invoice: 'INV-3201', client: 'Greystone Realty', method: 'Bank transfer', status: FinStatus.completed, amount: '\$1,500.00'),
  Payment(id: 'PAY-3302', date: '21/07/2026', invoice: 'INV-3202', client: 'Harbour Loans', method: 'Stripe', status: FinStatus.pending, amount: '\$500.00'),
  Payment(id: 'PAY-3303', date: '10/07/2026', invoice: 'INV-3204', client: 'Apex Property Group', method: 'Card', status: FinStatus.failed, amount: '\$1,650.00'),
];

// ─── Items ─────────────────────────────────────────────────────────────
class CatalogItem {
  final String name;
  final String sku;
  final String type;
  final String unit;
  final String tax;
  final FinStatus status;
  final String price;
  const CatalogItem({
    required this.name, required this.sku, required this.type, required this.unit,
    required this.tax, required this.status, required this.price,
  });
}

const kItems = <CatalogItem>[
  CatalogItem(name: 'Home loan packaging', sku: 'SVC-HOME', type: 'Service', unit: 'package', tax: '10%', status: FinStatus.active, price: '\$2,200.00'),
  CatalogItem(name: 'Refinance review', sku: 'SVC-REFIN', type: 'Service', unit: 'review', tax: '10%', status: FinStatus.active, price: '\$850.00'),
  CatalogItem(name: 'Brokerage fee', sku: 'FEE-BROKER', type: 'Service', unit: 'fee', tax: '10%', status: FinStatus.active, price: '\$1,500.00'),
  CatalogItem(name: 'Property valuation coordination', sku: 'SVC-VAL', type: 'Service', unit: 'job', tax: '10%', status: FinStatus.active, price: '\$450.00'),
  CatalogItem(name: 'Client welcome kit', sku: 'PROD-KIT', type: 'Product', unit: 'kit', tax: '10%', status: FinStatus.inactive, price: '\$75.00'),
];
