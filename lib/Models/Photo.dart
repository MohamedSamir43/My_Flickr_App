class Photo {
  final String id;
  final String owner, server, secret, title;
  final int farm, isfamily, ispublic, isfriend;
  final String url;

  Photo(
      {this.id,
        this.owner,
        this.secret,
        this.server,
        this.farm,
        this.title,
        this.ispublic,
        this.isfriend,
        this.isfamily,
        this.url});

  factory Photo.fromJson(Map<String, dynamic> parsedJson) {
    return new Photo(
        id: parsedJson['id'],
        owner: parsedJson['owner'],
        secret: parsedJson['secret'],
        server: parsedJson['server'],
        farm: parsedJson['farm'],
        title: parsedJson['title'],
        ispublic: parsedJson['ispublic'],
        isfriend: parsedJson['isfriend'],
        isfamily: parsedJson['isfamily'],
        url: parsedJson['url_m']);
  }
} 