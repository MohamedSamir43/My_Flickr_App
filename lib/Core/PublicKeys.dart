
class PublicKeys {
  static String Base_URL = 'https://api.flickr.com/services/rest/';
  static String apiKey = '8b0a0ae0f624aeeb0527e59fea9d7214';
  static String secert = '2c16e0b9349cddc2';

  static String search_Text = 'Cats';
  static int pageNumber = 1;
  static int pageSize = 10;

  static String getPhotosSearchAPI(){
     String photosSearchAPI = Base_URL + '?method=flickr.photos.search&api_key=${apiKey}'+'&text='+search_Text+'&page='+pageNumber.toString()+'&per_page='+pageSize.toString()+'&extras=url_m&format=json&nojsoncallback=1';
     return photosSearchAPI;
  }
  static String getGroupsSearchAPI(){
    String groupsSearchAPI = Base_URL + '?method=flickr.groups.search&api_key=${apiKey}'+'&text='+search_Text+'&page='+pageNumber.toString()+'&per_page='+pageSize.toString()+'&format=json&nojsoncallback=1';
    return groupsSearchAPI;
  }
}