import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// ─── Leads ─────────────────────────────────────────────
enum LeadStatus { newLead, contacted, qualified, unqualified, converted }

extension LeadStatusX on LeadStatus {
  String get label => switch (this) {
        LeadStatus.newLead => 'New',
        LeadStatus.contacted => 'Contacted',
        LeadStatus.qualified => 'Qualified',
        LeadStatus.unqualified => 'Unqualified',
        LeadStatus.converted => 'Converted',
      };
  Color get bg => switch (this) {
        LeadStatus.newLead => AppColors.primarySoft,
        LeadStatus.contacted => AppColors.infoBg,
        LeadStatus.qualified => AppColors.warningBg,
        LeadStatus.unqualified => AppColors.dangerBg,
        LeadStatus.converted => AppColors.successBg,
      };
  Color get fg => switch (this) {
        LeadStatus.newLead => AppColors.primary,
        LeadStatus.contacted => AppColors.infoFg,
        LeadStatus.qualified => AppColors.warningFg,
        LeadStatus.unqualified => AppColors.dangerFg,
        LeadStatus.converted => AppColors.successFg,
      };
}

class Lead {
  final String id, name, email, phone, source, company, owner, ownerInitials, created;
  final LeadStatus status;
  final int score;
  const Lead({
    required this.id, required this.name, required this.email, required this.phone,
    required this.source, required this.company, required this.owner, required this.ownerInitials,
    required this.created, required this.status, required this.score,
  });
}

const kLeads = <Lead>[
  Lead(id: 'LEA-8001', name: 'William Anderson', email: 'william@example.com', phone: '+61 400 111 222', source: 'Website form', company: 'Anderson Ventures', owner: 'John Smith', ownerInitials: 'JS', created: '18/07/2026', status: LeadStatus.qualified, score: 82),
  Lead(id: 'LEA-8002', name: 'Chloe Ramirez', email: 'chloe@example.com', phone: '+61 400 222 333', source: 'Referral', company: 'Ramirez Realty', owner: 'Shiva Kadhka', ownerInitials: 'SK', created: '19/07/2026', status: LeadStatus.contacted, score: 68),
  Lead(id: 'LEA-8003', name: 'Aisha Khan', email: 'aisha@northside.example', phone: '+61 400 333 444', source: 'LinkedIn', company: 'Northside Mortgage', owner: 'Roshna Abraham', ownerInitials: 'RA', created: '20/07/2026', status: LeadStatus.newLead, score: 45),
  Lead(id: 'LEA-8004', name: 'Marcus Chen', email: 'marcus@harbour.example', phone: '+61 400 444 555', source: 'Broker page', company: 'Harbour Loans', owner: 'Marcus Chen', ownerInitials: 'MC', created: '15/07/2026', status: LeadStatus.converted, score: 100),
  Lead(id: 'LEA-8005', name: 'Priya Mehta', email: 'priya@greystone.example', phone: '+61 400 555 666', source: 'Event', company: 'Greystone Realty', owner: 'Tejas Gokhe', ownerInitials: 'TG', created: '10/07/2026', status: LeadStatus.qualified, score: 91),
  Lead(id: 'LEA-8006', name: 'Daniel Rossi', email: 'daniel@apex.example', phone: '+61 400 666 777', source: 'Cold outreach', company: 'Apex Property Group', owner: 'John Smith', ownerInitials: 'JS', created: '05/07/2026', status: LeadStatus.unqualified, score: 22),
];

// ─── Contacts ─────────────────────────────────────────
class Contact {
  final String id, name, email, phone, jobTitle, company, owner, ownerInitials, lastContacted;
  final List<String> tags;
  const Contact({
    required this.id, required this.name, required this.email, required this.phone,
    required this.jobTitle, required this.company, required this.owner, required this.ownerInitials,
    required this.lastContacted, required this.tags,
  });
}

const kContacts = <Contact>[
  Contact(id: 'CON-9001', name: 'Priya Mehta', email: 'priya@greystone.example', phone: '+61 400 555 666', jobTitle: 'CFO', company: 'Greystone Realty', owner: 'Tejas Gokhe', ownerInitials: 'TG', lastContacted: '2 days ago', tags: ['vip', 'renewal']),
  Contact(id: 'CON-9002', name: 'Marcus Chen', email: 'marcus@harbour.example', phone: '+61 400 444 555', jobTitle: 'Founder', company: 'Harbour Loans', owner: 'Marcus Chen', ownerInitials: 'MC', lastContacted: 'Today', tags: ['prospect']),
  Contact(id: 'CON-9003', name: 'Daniel Rossi', email: 'daniel@apex.example', phone: '+61 400 666 777', jobTitle: 'Director', company: 'Apex Property Group', owner: 'Daniel Rossi', ownerInitials: 'DR', lastContacted: '1 week ago', tags: ['dormant']),
  Contact(id: 'CON-9004', name: 'Olivia Bennett', email: 'olivia@northwind.com', phone: '+61 400 777 888', jobTitle: 'Head of Ops', company: 'Northwind Traders', owner: 'Roshna Abraham', ownerInitials: 'RA', lastContacted: 'Yesterday', tags: ['champion']),
  Contact(id: 'CON-9005', name: 'Sarah Kim', email: 'sarah@meridian.example', phone: '+61 400 888 999', jobTitle: 'Advisor', company: 'Meridian Partners', owner: 'Sarah Kim', ownerInitials: 'SK', lastContacted: '3 days ago', tags: ['partner']),
];

// ─── Companies ────────────────────────────────────────
class Company {
  final String id, name, industry, website, size, owner, ownerInitials, revenue, country;
  final int deals, contacts;
  const Company({
    required this.id, required this.name, required this.industry, required this.website,
    required this.size, required this.owner, required this.ownerInitials, required this.revenue,
    required this.country, required this.deals, required this.contacts,
  });
}

const kCompanies = <Company>[
  Company(id: 'CMP-5001', name: 'Greystone Realty', industry: 'Real Estate', website: 'greystone.example', size: '250-500', owner: 'Tejas Gokhe', ownerInitials: 'TG', revenue: '\$48,200', country: 'AU', deals: 3, contacts: 8),
  Company(id: 'CMP-5002', name: 'Harbour Loans', industry: 'Finance', website: 'harbour.example', size: '50-100', owner: 'Marcus Chen', ownerInitials: 'MC', revenue: '\$32,500', country: 'AU', deals: 2, contacts: 4),
  Company(id: 'CMP-5003', name: 'Apex Property Group', industry: 'Real Estate', website: 'apex.example', size: '10-50', owner: 'Daniel Rossi', ownerInitials: 'DR', revenue: '\$18,900', country: 'AU', deals: 1, contacts: 3),
  Company(id: 'CMP-5004', name: 'Northside Mortgage', industry: 'Finance', website: 'northside.example', size: '100-250', owner: 'Roshna Abraham', ownerInitials: 'RA', revenue: '\$76,000', country: 'AU', deals: 4, contacts: 6),
  Company(id: 'CMP-5005', name: 'Meridian Partners', industry: 'Consulting', website: 'meridian.example', size: '10-50', owner: 'Sarah Kim', ownerInitials: 'SK', revenue: '\$12,400', country: 'NZ', deals: 1, contacts: 2),
];

// ─── Forecasting ──────────────────────────────────────
class ForecastCell {
  final String owner;
  final String initials;
  final String commit;
  final String bestCase;
  final String pipeline;
  final String quota;
  final double attainment;
  const ForecastCell({required this.owner, required this.initials, required this.commit, required this.bestCase, required this.pipeline, required this.quota, required this.attainment});
}

const kForecast = <ForecastCell>[
  ForecastCell(owner: 'John Smith', initials: 'JS', commit: '\$142k', bestCase: '\$186k', pipeline: '\$310k', quota: '\$200k', attainment: 0.71),
  ForecastCell(owner: 'Tejas Gokhe', initials: 'TG', commit: '\$96k', bestCase: '\$128k', pipeline: '\$240k', quota: '\$180k', attainment: 0.53),
  ForecastCell(owner: 'Roshna Abraham', initials: 'RA', commit: '\$78k', bestCase: '\$104k', pipeline: '\$205k', quota: '\$150k', attainment: 0.52),
  ForecastCell(owner: 'Shiva Kadhka', initials: 'SK', commit: '\$68k', bestCase: '\$92k', pipeline: '\$168k', quota: '\$140k', attainment: 0.49),
  ForecastCell(owner: 'Marcus Chen', initials: 'MC', commit: '\$54k', bestCase: '\$72k', pipeline: '\$134k', quota: '\$120k', attainment: 0.45),
];
