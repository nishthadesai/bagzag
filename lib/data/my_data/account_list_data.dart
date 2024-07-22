import '../../generated/l10n.dart';

class AccountListData {
  final String dataName;
  final String dataDesc;

  AccountListData({required this.dataName, required this.dataDesc});
}

List accountDataList = [
  AccountListData(
      dataName: S.current.myOrder,
      dataDesc: S.current.youCanSeeAllPendingAndPastOrders),
  AccountListData(
      dataName: S.current.bookmarks,
      dataDesc: S.current.youCanSeeAllBookmarkPost),
  AccountListData(
      dataName: S.current.bagzagMall,
      dataDesc: S.current.youCanSeeBrandedStore),
  AccountListData(
      dataName: S.current.findPeople,
      dataDesc: S.current.youCanSearchPeopleWhoAreUsingTheApp),
  AccountListData(
      dataName: S.current.myPost,
      dataDesc: S.current.seeAllProductPostCreatedByYou),
  AccountListData(
      dataName: S.current.giftCard, dataDesc: S.current.youCanSendGiftToOther),
  AccountListData(
      dataName: S.current.messages,
      dataDesc: S.current.youCanSeeListOfYourMessages),
  AccountListData(
      dataName: S.current.paymentMethods,
      dataDesc: S.current.youCanAddremovePaymentMethods),
  AccountListData(
      dataName: S.current.manageAddresses,
      dataDesc: S.current.manageBillingShippingAddresses),
  AccountListData(
      dataName: S.current.inviteEarn,
      dataDesc: S.current.youCanInviteOtherUserEarnMoney),
  AccountListData(
      dataName: S.current.settings, dataDesc: S.current.seeAllAppSettings),
];
