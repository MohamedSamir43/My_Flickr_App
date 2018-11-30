
class PublicKeys {
  static String apiKey = '8b0a0ae0f624aeeb0527e59fea9d7214';
  static String secert = '2c16e0b9349cddc2';

  static String searchText = '';
  static String pageNumber = '1';
  static String pageSize = '10';

  static String photosSearchAPI = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=${apiKey}&text=${searchText}&page=${pageNumber}&per_page=${pageSize}&extras=url_m&format=json&nojsoncallback=1';
}