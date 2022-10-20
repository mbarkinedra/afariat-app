import 'package:afariat/networking/json/abstract_json_resource.dart';

class ConversationJson extends AbstractJsonResource {
  int page;
  int limit;
  int pages;
  int total;
  Links links;
  Embedded embedded;

  ConversationJson(
      {this.page,
      this.limit,
      this.pages,
      this.total,
      this.links,
      this.embedded});

  ConversationJson.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
    total = json['total'];
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
    embedded = json['_embedded'] != null
        ? Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['pages'] = pages;
    data['total'] = total;
    if (links != null) {
      data['_links'] = links.toJson();
    }
    if (embedded != null) {
      data['_embedded'] = embedded.toJson();
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
    self = json['self'] != null ? Self.fromJson(json['self']) : null;
    first = json['first'] != null ? Self.fromJson(json['first']) : null;
    last = json['last'] != null ? Self.fromJson(json['last']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self.toJson();
    }
    if (first != null) {
      data['first'] = first.toJson();
    }
    if (last != null) {
      data['last'] = last.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class Embedded {
  List<Conversation> conversation;

  Embedded({this.conversation});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['conversation'] != null) {
      conversation = <Conversation>[];
      json['conversation'].forEach((v) {
        conversation.add(Conversation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conversation != null) {
      data['conversation'] = conversation.map((v) => v.toJson()).toList();
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
  Links links;

  Conversation(
      {this.createdAt,
      this.id,
      this.message,
      this.from,
      this.to,
      this.read,
      this.totalUnreadMessagesCount,
      this.links});

  Conversation.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    message = json['message'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    to = json['to'] != null ? From.fromJson(json['to']) : null;
    read = json['read'];
    totalUnreadMessagesCount = json['totalUnreadMessagesCount'];
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['message'] = message;
    if (from != null) {
      data['from'] = from.toJson();
    }
    if (to != null) {
      data['to'] = to.toJson();
    }
    data['read'] = read;
    data['totalUnreadMessagesCount'] = totalUnreadMessagesCount;
    if (links != null) {
      data['_links'] = links.toJson();
    }
    return data;
  }
}

class From {
  String username;
  int id;
  String firstName;

  From({this.username, this.id, this.firstName});

  From.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['id'] = id;
    data['firstName'] = firstName;
    return data;
  }
}
