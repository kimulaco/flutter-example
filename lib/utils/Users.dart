Future<List<Map<String, dynamic>>> getUsersList() async {
  return List<Map<String, dynamic>>.from([
    {
      'id': 'sam',
      'name': 'Sam Porter Bridges',
      'iconUrl': 'assets/img/user/sam.jpg'
    },
    {
      'id': 'cliff',
      'name': 'Clifford Cliff Unger',
      'iconUrl': 'assets/img/user/cliff.jpg'
    },
    {
      'id': 'ameri',
      'name': 'Samantha America Strand',
      'iconUrl': 'assets/img/user/ameri.jpg'
    },
    {
      'id': 'higgs',
      'name': 'Higgs Monaghan',
      'iconUrl': 'assets/img/user/higgs.jpg'
    },
    {
      'id': 'fragile',
      'name': 'Fragile',
      'iconUrl': 'assets/img/user/fragile.jpg'
    }
  ]);
}

Future<Map<String, dynamic>> getUser(String userId) async {
  final List<Map<String, dynamic>> users = await getUsersList();

  for (Map<String, dynamic> user in users) {
    if (user['id'] == userId) {
      return user;
    }
  }

  return {};
}