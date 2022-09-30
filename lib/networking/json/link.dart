class Link {
  Link({
    this.href,
  });

  String href;

  Link.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (href != null) {
      json['href'] = href;
    }
    return json;
  }
}

class Links {
  Link self;
  Link first;
  Link last;
  Link next;
  Link previous;
  Link search;

  Links(
      {this.self,
      this.first,
      this.last,
      this.next,
      this.previous,
      this.search});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? Link.fromJson(json['self']) : null;
    first = json['first'] != null ? Link.fromJson(json['first']) : null;
    last = json['last'] != null ? Link.fromJson(json['last']) : null;
    next = json['next'] != null ? Link.fromJson(json['next']) : null;
    previous =
        json['previous'] != null ? Link.fromJson(json['previous']) : null;
    next = json['search'] != null ? Link.fromJson(json['search']) : null;
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
    if (next != null) {
      data['next'] = next.toJson();
    }
    if (previous != null) {
      data['previous'] = previous.toJson();
    }
    if (search != null) {
      data['search'] = search.toJson();
    }
    return data;
  }

  String get firstUrl {
    return (first != null) ? first.href : null;
  }

  String get nextUrl {
    return (next != null) ? next.href : null;
  }

  String get previousUrl {
    return (previous != null) ? previous.href : null;
  }

  String get lastUrl {
    return (last != null) ? last.href : null;
  }

  String get selfUrl {
    return (self != null) ? self.href : null;
  }

  String get searchUrl {
    return (search != null) ? search.href : null;
  }
}
