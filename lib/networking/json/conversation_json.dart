import 'package:afariat/networking/json/abstract_json_resource.dart';

class ConversationJson extends AbstractJsonResource {
  int page;
  int limit;
  int pages;
  int total;
  Links lLinks;
  Embedded eEmbedded;

  ConversationJson(
      {this.page,
      this.limit,
      this.pages,
      this.total,
      this.lLinks,
      this.eEmbedded});

  ConversationJson.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
    total = json['total'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    eEmbedded = json['_embedded'] != null
        ? new Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['pages'] = this.pages;
    data['total'] = this.total;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    if (this.eEmbedded != null) {
      data['_embedded'] = this.eEmbedded.toJson();
    }
    return data;
  }
}

class Links {
  Self self;
  Self first;
  Self last;

  Links({this.self, this.first, this.last});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    first = json['first'] != null ? new Self.fromJson(json['first']) : null;
    last = json['last'] != null ? new Self.fromJson(json['last']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    if (this.first != null) {
      data['first'] = this.first.toJson();
    }
    if (this.last != null) {
      data['last'] = this.last.toJson();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Embedded {
  List<Conversation> conversation;

  Embedded({this.conversation});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['conversation'] != null) {
      conversation = new List<Conversation>();
      json['conversation'].forEach((v) {
        conversation.add(new Conversation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conversation != null) {
      data['conversation'] = this.conversation.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversation {
  String createdAt;
  int id;
  String message;
  From from;
  From to;
  bool read;
  int totalUnreadMessagesCount;
  Links lLinks;

  Conversation(
      {this.createdAt,
      this.id,
      this.message,
      this.from,
      this.to,
      this.read,
      this.totalUnreadMessagesCount,
      this.lLinks});

  Conversation.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    message = json['message'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new From.fromJson(json['to']) : null;
    read = json['read'];
    totalUnreadMessagesCount = json['totalUnreadMessagesCount'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['message'] = this.message;
    if (this.from != null) {
      data['from'] = this.from.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to.toJson();
    }
    data['read'] = this.read;
    data['totalUnreadMessagesCount'] = this.totalUnreadMessagesCount;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class From {
  String username;
  int id;
  String name;

  From({this.username, this.id, this.name});

  From.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
