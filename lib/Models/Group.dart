class Group {
  final String nsid;
  final String name, iconserver, members, pool_count,topic_count, privacy;
  final int eighteenplus,iconfarm;

  Group(
      {this.nsid,
        this.name,
        this.iconserver,
        this.members,
        this.pool_count,
        this.eighteenplus,
        this.iconfarm,
        this.topic_count,
        this.privacy});

  factory Group.fromJson(Map<String, dynamic> parsedJson) {
    return new Group(
        nsid: parsedJson['nsid'],
        name: parsedJson['name'],
        iconserver: parsedJson['iconserver'],
        members: parsedJson['members'],
        pool_count: parsedJson['pool_count'],
        eighteenplus: parsedJson['eighteenplus'],
        iconfarm: parsedJson['iconfarm'],
        topic_count: parsedJson['topic_count'],
        privacy: parsedJson['privacy']);
  }
}