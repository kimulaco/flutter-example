Future<List<Map<String, dynamic>>> getFriendList() async {
  return List<Map<String, dynamic>>.from([
    {
      'id': 'sam',
      'name': 'Sam Porter Bridges',
      'iconUrl': ''
    },
    {
      'id': 'cliff',
      'name': 'Clifford Cliff Unger',
      'iconUrl': ''
    },
    {
      'id': 'ameri',
      'name': 'Samantha America Strand',
      'iconUrl': ''
    },
    {
      'id': 'higgs',
      'name': 'Higgs Monaghan',
      'iconUrl': ''
    },
    {
      'id': 'fragile',
      'name': 'Fragile',
      'iconUrl': ''
    }
  ]);
}

Future<Map<String, dynamic>> getFriend(String friendId) async {
  final List<Map<String, dynamic>> friends = await getFriendList();

  for (Map<String, dynamic> friend in friends) {
    if (friend['id'] == friendId) {
      return friend;
    }
  }

  return {};
}