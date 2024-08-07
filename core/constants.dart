import '../app/model/lead_status.dart';
import '../shared/utils/colors.dart';

const inter400 = "Inter-Regular",
    inter500 = "Inter-Medium",
    inter600 = "Inter-SemiBold",
    inter700 = "Inter-Bold";

const randomImageUrl = "https://source.unsplash.com/random/";

final leadStatusList = [
  LeadStatus(name: "New Lead", id: "new", color: primaryClr.withOpacity(1)),
  LeadStatus(
      name: "Qualified Lead",
      id: "qualified",
      color: secondaryClr.withOpacity(1)),
  LeadStatus(name: "Quote", id: "quote", color: quoteClr.withOpacity(1)),
  LeadStatus(
      name: "Negotiation",
      id: "negotiation",
      color: negotiationClr.withOpacity(1)),
  LeadStatus(
      name: "Closing", id: "closed", color: success500Clr.withOpacity(1)),
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];

final leadStatusNewList = [
  // LeadStatus(name: "New Lead", id: "new", color: primaryClr.withOpacity(1)),
  LeadStatus(
      name: "Qualified Lead",
      id: "qualified",
      color: secondaryClr.withOpacity(1)),
  // LeadStatus(name: "Quote", id: "quote", color: quoteClr.withOpacity(1)),
  // LeadStatus(
  //     name: "Negotiation",
  //     id: "negotiation",
  //     color: negotiationClr.withOpacity(1)),
  // LeadStatus(
  //     name: "Closing", id: "closed", color: success500Clr.withOpacity(1)),
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];

final leadStatusQualifiedList = [
  // LeadStatus(
  //     name: "Qualified Lead",
  //     id: "qualified",
  //     color: secondaryClr.withOpacity(1)),
  // LeadStatus(name: "Quote", id: "quote", color: quoteClr.withOpacity(1)),
  // LeadStatus(
  //     name: "Negotiation",
  //     id: "negotiation",
  //     color: negotiationClr.withOpacity(1)),
  // LeadStatus(
  //     name: "Closing", id: "closed", color: success500Clr.withOpacity(1)),
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];

final leadStatusQuoteList = [
  LeadStatus(name: "Quote", id: "quote", color: quoteClr.withOpacity(1)),
  LeadStatus(
      name: "Negotiation",
      id: "negotiation",
      color: negotiationClr.withOpacity(1)),
  LeadStatus(
      name: "Closing", id: "closed", color: success500Clr.withOpacity(1)),
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];
final quoteStatusPendingList = [
  // LeadStatus(name: "Quote", id: "quote", color: quoteClr.withOpacity(1)),
  // LeadStatus(
  //     name: "Negotiation",
  //     id: "negotiation",
  //     color: negotiationClr.withOpacity(1)),
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];

final leadStatusNegotiationList = [
  // LeadStatus(
  //     name: "Negotiation",
  //     id: "negotiation",
  //     color: negotiationClr.withOpacity(1)),
  LeadStatus(
      name: "Closing", id: "closed", color: success500Clr.withOpacity(1)),
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];
final leadStatusClosingList = [
  LeadStatus(
      name: "Closing", id: "closed", color: success500Clr.withOpacity(1)),
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];

final quoteStatusList = [
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];

final quoteStatusApprovedList = [
  LeadStatus(
      name: "Negotiation",
      id: "negotiation",
      color: negotiationClr.withOpacity(1)),
  LeadStatus(
      name: "Closing", id: "closed", color: success500Clr.withOpacity(1)),
  LeadStatus(name: "Lost Lead", id: "lost", color: accentClr.withOpacity(1))
];

final leadStatusLostList = [
  LeadStatus(
      name: "Qualified Lead",
      id: "qualified",
      color: secondaryClr.withOpacity(1)),
];
