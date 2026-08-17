import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum DealStage { prospecting, qualification, proposal, negotiation, closedWon, closedLost }

class Deal {
  final String id;
  final String name;
  final String client;
  final DealStage stage;
  final String value;
  final int probability;
  final String owner;
  final String ownerInitials;
  final String close;
  const Deal({
    required this.id,
    required this.name,
    required this.client,
    required this.stage,
    required this.value,
    required this.probability,
    required this.owner,
    required this.ownerInitials,
    required this.close,
  });
}

extension DealStageX on DealStage {
  String get label => switch (this) {
        DealStage.prospecting => 'Prospecting',
        DealStage.qualification => 'Qualification',
        DealStage.proposal => 'Proposal',
        DealStage.negotiation => 'Negotiation',
        DealStage.closedWon => 'Closed won',
        DealStage.closedLost => 'Closed lost',
      };
  Color get bg => switch (this) {
        DealStage.prospecting => AppColors.neutralBg,
        DealStage.qualification => AppColors.infoBg,
        DealStage.proposal => AppColors.primarySoft,
        DealStage.negotiation => AppColors.warningBg,
        DealStage.closedWon => AppColors.successBg,
        DealStage.closedLost => AppColors.dangerBg,
      };
  Color get fg => switch (this) {
        DealStage.prospecting => AppColors.neutralFg,
        DealStage.qualification => AppColors.infoFg,
        DealStage.proposal => AppColors.primary,
        DealStage.negotiation => AppColors.warningFg,
        DealStage.closedWon => AppColors.successFg,
        DealStage.closedLost => AppColors.dangerFg,
      };
}

const kMockDeals = <Deal>[
  Deal(
    id: 'DEA-9021',
    name: 'Greystone renewal — 24 months',
    client: 'Greystone Realty',
    stage: DealStage.negotiation,
    value: '\$48,200',
    probability: 78,
    owner: 'Priya Mehta',
    ownerInitials: 'PM',
    close: 'Aug 28',
  ),
  Deal(
    id: 'DEA-9022',
    name: 'Harbour Loans expansion',
    client: 'Harbour Loans',
    stage: DealStage.proposal,
    value: '\$32,500',
    probability: 55,
    owner: 'Marcus Chen',
    ownerInitials: 'MC',
    close: 'Sep 12',
  ),
  Deal(
    id: 'DEA-9023',
    name: 'Northside multi-year',
    client: 'Northside Holdings',
    stage: DealStage.qualification,
    value: '\$76,000',
    probability: 35,
    owner: 'John Smith',
    ownerInitials: 'JS',
    close: 'Oct 05',
  ),
  Deal(
    id: 'DEA-9024',
    name: 'Apex reinstatement bundle',
    client: 'Apex Property Group',
    stage: DealStage.prospecting,
    value: '\$18,900',
    probability: 15,
    owner: 'Daniel Rossi',
    ownerInitials: 'DR',
    close: 'Oct 20',
  ),
  Deal(
    id: 'DEA-9025',
    name: 'Meridian pilot rollout',
    client: 'Meridian Partners',
    stage: DealStage.closedWon,
    value: '\$12,400',
    probability: 100,
    owner: 'Sarah Kim',
    ownerInitials: 'SK',
    close: 'Aug 12',
  ),
];
