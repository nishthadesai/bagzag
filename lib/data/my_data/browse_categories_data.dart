import '../../generated/assets.dart';
import '../../generated/l10n.dart';

class BrowseCategoriesData {
  final String image;
  final String categoryName;

  BrowseCategoriesData(this.image, this.categoryName);
}

List browseCategoriesList = [
  BrowseCategoriesData(Assets.imageManCat, S.current.men),
  BrowseCategoriesData(Assets.imageWomanCat, S.current.women),
  BrowseCategoriesData(Assets.imageKidsCat, S.current.kids),
  BrowseCategoriesData(Assets.imageBeautyCat, S.current.beauty),
  BrowseCategoriesData(Assets.imageHomeLivingCat, S.current.homeLiving),
  BrowseCategoriesData(Assets.imageGedgetsCat, S.current.gedgets),
  BrowseCategoriesData(Assets.imageToyCat, S.current.toyBaby),
  BrowseCategoriesData(Assets.imageSportsCat, S.current.sports),
];
