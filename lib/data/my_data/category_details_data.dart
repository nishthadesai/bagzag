class CategoryDetailsData {
  final String CategoryDetail;

  CategoryDetailsData(this.CategoryDetail);
}

List humanCategoryList = [
  CategoryDetailsData("Top Wear"),
  CategoryDetailsData("Watches"),
  CategoryDetailsData("Footwear"),
  CategoryDetailsData("Innerwear"),
  CategoryDetailsData("Ethnicwear"),
  CategoryDetailsData("Sleepwear"),
  CategoryDetailsData("Jeans"),
];
List beautyCategoryList = [
  CategoryDetailsData("Lipstick"),
  CategoryDetailsData("Eye liner"),
  CategoryDetailsData("Kajal"),
  CategoryDetailsData("Eye Shadow"),
  CategoryDetailsData("Blush"),
  CategoryDetailsData("Nail Polish"),
  CategoryDetailsData("Other"),
];
List homeLivingCategoryList = [
  CategoryDetailsData("Sofa"),
  CategoryDetailsData("Chair"),
  CategoryDetailsData("Dining Table"),
  CategoryDetailsData("Kitchen items"),
  CategoryDetailsData("Other"),
];
List gadgetsCategoryList = [
  CategoryDetailsData("Hands free"),
  CategoryDetailsData("Head phone"),
  CategoryDetailsData("Mobile case"),
  CategoryDetailsData("Charger"),
  CategoryDetailsData("Other"),
];
List toyCategoryList = [
  CategoryDetailsData("Barbie"),
  CategoryDetailsData("Remote Control"),
  CategoryDetailsData("Small kids toys"),
  CategoryDetailsData("Teddy"),
  CategoryDetailsData("Other"),
];
List sportsCategoryList = [
  CategoryDetailsData("Badminton items"),
  CategoryDetailsData("Cricket kit"),
  CategoryDetailsData("Table tennis items"),
  CategoryDetailsData("Other"),
];

Map<int, dynamic> categoryDetails = {
  0: humanCategoryList,
  1: humanCategoryList,
  2: humanCategoryList,
  3: beautyCategoryList,
  4: homeLivingCategoryList,
  5: gadgetsCategoryList,
  6: toyCategoryList,
  7: sportsCategoryList
};
