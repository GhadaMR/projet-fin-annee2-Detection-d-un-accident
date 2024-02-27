class Utilisateur{
  final String uid;
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String imageUrl;
  int dureeAlarme;
  Map<String, DateTime> historiques;

  Utilisateur({
    required this.uid,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.dureeAlarme = 90,
    this.imageUrl ="",
    Map<String, DateTime>? historiques,
  }) : this.historiques = historiques ?? {};
  void ajouterHistorique(String idAlerte) {
    historiques[idAlerte] = DateTime.now();
  }
  void modifierDureeAlarme(int nouvelleDuree) {
    dureeAlarme = nouvelleDuree;
  }
}