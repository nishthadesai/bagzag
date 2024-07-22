import '../../generated/assets.dart';
import '../../generated/l10n.dart';

class FavoriteStoreData {
  final String image;
  final String storeName;
  final String storeAddress;

  FavoriteStoreData(this.image, this.storeName, this.storeAddress);
}

List favoriteStoreDataList = [
  FavoriteStoreData(Assets.imageFavStoreOne, S.current.theNewStore,
      S.current.GodfreyStreetTigardOr97223),
  FavoriteStoreData(Assets.imageFavStoreTwo, S.current.sevenSennseStore,
      S.current.GodfreyStreetTigardOr97223),
  FavoriteStoreData(Assets.imageFavStoreThree, S.current.sevenSennseStore,
      S.current.GodfreyStreetTigardOr97223),
];
