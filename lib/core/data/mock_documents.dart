import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// ─── Library ────────────────────────────────────────────────────────────────

enum DocAccess { private, team, organization }

class DocFolder {
  final String name;
  final int count;
  const DocFolder(this.name, this.count);
}

class DocFile {
  final String name;
  final String size;
  final String folder;
  final String owner;
  final String ownerInitials;
  final String relatedTo;
  final String version;
  final List<String> tags;
  final String uploaded;
  final DocAccess access;
  const DocFile({
    required this.name,
    required this.size,
    required this.folder,
    required this.owner,
    required this.ownerInitials,
    required this.relatedTo,
    required this.version,
    required this.tags,
    required this.uploaded,
    required this.access,
  });
}

extension DocAccessX on DocAccess {
  String get label => switch (this) {
        DocAccess.private => 'Private',
        DocAccess.team => 'Team',
        DocAccess.organization => 'Organization',
      };
  Color get bg => switch (this) {
        DocAccess.private => AppColors.infoBg,
        DocAccess.team => AppColors.primarySoft,
        DocAccess.organization => AppColors.successBg,
      };
  Color get fg => switch (this) {
        DocAccess.private => AppColors.infoFg,
        DocAccess.team => AppColors.primary,
        DocAccess.organization => AppColors.successFg,
      };
}

const kDocFolders = <DocFolder>[
  DocFolder('All Files', 5),
  DocFolder('Clients', 2),
  DocFolder('Deals', 1),
  DocFolder('Templates', 1),
  DocFolder('Signed', 1),
];

const kDocFiles = <DocFile>[
  DocFile(
    name: 'Anderson_Engagement_L…',
    size: '245 KB',
    folder: 'Clients',
    owner: 'John Smith',
    ownerInitials: 'JS',
    relatedTo: 'Lead: William Anderson',
    version: 'v2',
    tags: ['engagement', 'legal'],
    uploaded: '18/07/2026',
    access: DocAccess.team,
  ),
  DocFile(
    name: 'Greystone_Proposal.pdf',
    size: '1.2 MB',
    folder: 'Deals',
    owner: 'Tejas Gokhe',
    ownerInitials: 'TG',
    relatedTo: 'Deal: Greystone Realty',
    version: 'v1',
    tags: ['proposal'],
    uploaded: '15/07/2026',
    access: DocAccess.organization,
  ),
  DocFile(
    name: 'Standard_NDA_Template.…',
    size: '88 KB',
    folder: 'Templates',
    owner: 'Roshna Abraham',
    ownerInitials: 'RA',
    relatedTo: '',
    version: 'v3',
    tags: ['template', 'nda'],
    uploaded: '01/07/2026',
    access: DocAccess.organization,
  ),
  DocFile(
    name: 'Chloe_Bank_Statements_…',
    size: '3.4 MB',
    folder: 'Clients',
    owner: 'Shiva Kadhka',
    ownerInitials: 'SK',
    relatedTo: 'Lead: Chloe Ramirez',
    version: 'v1',
    tags: ['financial', 'kyc'],
    uploaded: '19/07/2026',
    access: DocAccess.private,
  ),
  DocFile(
    name: 'Greystone_Signed_Accep…',
    size: '410 KB',
    folder: 'Signed',
    owner: 'Tejas Gokhe',
    ownerInitials: 'TG',
    relatedTo: 'Deal: Greystone Realty',
    version: 'v1',
    tags: ['signed', 'proposal'],
    uploaded: '12/07/2026',
    access: DocAccess.team,
  ),
];

// ─── Document Requests ──────────────────────────────────────────────────────

enum DocReqStatus { requested, pending, received, approved, rejected, expired }
enum DocReqType { idProof, contract, financial, proposal, legal, other }

class DocRequest {
  final String id;
  final String title;
  final String from;
  final DocReqType type;
  final String relatedTo;
  final String due;
  final DocReqStatus status;
  final String requestedBy;
  final String requestedByInitials;
  const DocRequest({
    required this.id,
    required this.title,
    required this.from,
    required this.type,
    required this.relatedTo,
    required this.due,
    required this.status,
    required this.requestedBy,
    required this.requestedByInitials,
  });
}

extension DocReqStatusX on DocReqStatus {
  String get label => switch (this) {
        DocReqStatus.requested => 'Requested',
        DocReqStatus.pending => 'Pending',
        DocReqStatus.received => 'Received',
        DocReqStatus.approved => 'Approved',
        DocReqStatus.rejected => 'Rejected',
        DocReqStatus.expired => 'Expired',
      };
  Color get dot => switch (this) {
        DocReqStatus.requested => AppColors.infoFg,
        DocReqStatus.pending => AppColors.warningFg,
        DocReqStatus.received => AppColors.primary,
        DocReqStatus.approved => AppColors.successFg,
        DocReqStatus.rejected => AppColors.dangerFg,
        DocReqStatus.expired => AppColors.mutedForeground,
      };
  Color get bg => switch (this) {
        DocReqStatus.requested => AppColors.infoBg,
        DocReqStatus.pending => AppColors.warningBg,
        DocReqStatus.received => AppColors.primarySoft,
        DocReqStatus.approved => AppColors.successBg,
        DocReqStatus.rejected => AppColors.dangerBg,
        DocReqStatus.expired => AppColors.neutralBg,
      };
  Color get fg => switch (this) {
        DocReqStatus.requested => AppColors.infoFg,
        DocReqStatus.pending => AppColors.warningFg,
        DocReqStatus.received => AppColors.primary,
        DocReqStatus.approved => AppColors.successFg,
        DocReqStatus.rejected => AppColors.dangerFg,
        DocReqStatus.expired => AppColors.mutedForeground,
      };
  /// Left-edge accent bar on the row.
  Color get accent => switch (this) {
        DocReqStatus.pending => AppColors.warningFg,
        DocReqStatus.received => AppColors.primary,
        DocReqStatus.approved => AppColors.successFg,
        DocReqStatus.rejected => AppColors.dangerFg,
        DocReqStatus.expired => AppColors.mutedForeground,
        DocReqStatus.requested => Colors.transparent,
      };
}

extension DocReqTypeX on DocReqType {
  String get label => switch (this) {
        DocReqType.idProof => 'ID Proof',
        DocReqType.contract => 'Contract',
        DocReqType.financial => 'Financial',
        DocReqType.proposal => 'Proposal',
        DocReqType.legal => 'Legal',
        DocReqType.other => 'Other',
      };
  Color get bg => switch (this) {
        DocReqType.idProof => AppColors.warningBg,
        DocReqType.contract => AppColors.primarySoft,
        DocReqType.financial => AppColors.successBg,
        DocReqType.proposal => AppColors.infoBg,
        DocReqType.legal => AppColors.dangerBg,
        DocReqType.other => AppColors.neutralBg,
      };
  Color get fg => switch (this) {
        DocReqType.idProof => AppColors.warningFg,
        DocReqType.contract => AppColors.primary,
        DocReqType.financial => AppColors.successFg,
        DocReqType.proposal => AppColors.infoFg,
        DocReqType.legal => AppColors.dangerFg,
        DocReqType.other => AppColors.neutralFg,
      };
}

const kDocRequests = <DocRequest>[
  DocRequest(
    id: 'DR-1001',
    title: 'ID + income proof for pre-approval',
    from: 'William Anderson',
    type: DocReqType.idProof,
    relatedTo: 'Lead: William Anders…',
    due: '25/07/2026',
    status: DocReqStatus.requested,
    requestedBy: 'John Smith',
    requestedByInitials: 'JS',
  ),
  DocRequest(
    id: 'DR-1007',
    title: 'Employment contract copy',
    from: 'William Anderson',
    type: DocReqType.contract,
    relatedTo: 'Lead: William Anders…',
    due: '28/07/2026',
    status: DocReqStatus.requested,
    requestedBy: 'John Smith',
    requestedByInitials: 'JS',
  ),
  DocRequest(
    id: 'DR-1002',
    title: 'Bank statements: last 3 months',
    from: 'Chloe Ramirez',
    type: DocReqType.financial,
    relatedTo: 'Lead: Chloe Ramirez',
    due: '22/07/2026',
    status: DocReqStatus.pending,
    requestedBy: 'Shiva Kadhka',
    requestedByInitials: 'SK',
  ),
  DocRequest(
    id: 'DR-1003',
    title: 'Signed vendor agreement',
    from: 'Marcus Lin',
    type: DocReqType.contract,
    relatedTo: 'Deal: Vendor Manage…',
    due: '20/07/2026',
    status: DocReqStatus.received,
    requestedBy: 'Tejas Gokhe',
    requestedByInitials: 'TG',
  ),
  DocRequest(
    id: 'DR-1004',
    title: 'Proposal pack for Greystone',
    from: 'Olivia Bennett',
    type: DocReqType.proposal,
    relatedTo: 'Deal: Greystone Realty',
    due: '15/07/2026',
    status: DocReqStatus.approved,
    requestedBy: 'Tejas Gokhe',
    requestedByInitials: 'TG',
  ),
  DocRequest(
    id: 'DR-1005',
    title: 'Trust deed extract',
    from: 'Northwind Traders',
    type: DocReqType.legal,
    relatedTo: 'Company: Northwind…',
    due: '10/07/2026',
    status: DocReqStatus.rejected,
    requestedBy: 'Roshna Abraham',
    requestedByInitials: 'RA',
  ),
  DocRequest(
    id: 'DR-1006',
    title: 'ASIC company extract',
    from: 'Fabrikam Inc.',
    type: DocReqType.other,
    relatedTo: 'Company: Fabrikam I…',
    due: '05/07/2026',
    status: DocReqStatus.expired,
    requestedBy: 'John Smith',
    requestedByInitials: 'JS',
  ),
];
