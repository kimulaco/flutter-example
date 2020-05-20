Future<List<Map<String, dynamic>>> getUsersList() async {
  return List<Map<String, dynamic>>.from([
    {
      'id': 'sam',
      'name': 'Sam Porter Bridges',
      'iconUrl': 'assets/img/sam.jpg'
    },
    {
      'id': 'cliff',
      'name': 'Clifford Cliff Unger',
      'iconUrl': 'assets/img/cliff.jpg'
    },
    {
      'id': 'ameri',
      'name': 'Samantha America Strand',
      'iconUrl': 'assets/img/ameri.jpg'
    },
    {
      'id': 'higgs',
      'name': 'Higgs Monaghan',
      'iconUrl': 'assets/img/higgs.jpg'
    },
    {
      'id': 'fragile',
      'name': 'Fragile',
      'iconUrl': 'assets/img/fragile.jpg'
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