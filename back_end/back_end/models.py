
from django.db import models
from django.conf import settings


# 1. Mode de transport
class ModeTransport(models.Model):
    nom = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.nom


# 2. Ligne de transport
class Ligne(models.Model):
    nom = models.CharField(max_length=100)
    mode_transport = models.ForeignKey(
        ModeTransport,
        on_delete=models.CASCADE,
        related_name='lignes'
    )

    def __str__(self):
        return self.nom


# 3. Station
class Station(models.Model):
    nom = models.CharField(max_length=150)
    latitude = models.FloatField(null=True, blank=True)
    longitude = models.FloatField(null=True, blank=True)

    def __str__(self):
        return self.nom


# 4. Tronçon entre deux stations
class Troncon(models.Model):
    station_depart = models.ForeignKey(
        Station,
        on_delete=models.CASCADE,
        related_name='troncons_depart'
    )

    station_arrivee = models.ForeignKey(
        Station,
        on_delete=models.CASCADE,
        related_name='troncons_arrivee'
    )

    ligne = models.ForeignKey(
        Ligne,
        on_delete=models.CASCADE,
        related_name='troncons'
    )

    duree = models.PositiveIntegerField(help_text="Durée en minutes")
    distance = models.DecimalField(
        max_digits=8,
        decimal_places=2,
        help_text="Distance en kilomètres"
    )

    def __str__(self):
        return f"{self.station_depart} - {self.station_arrivee}"


# 5. Correspondance entre deux stations
class Correspondance(models.Model):
    station_A = models.ForeignKey(
        Station,
        on_delete=models.CASCADE,
        related_name='correspondances_A'
    )

    station_B = models.ForeignKey(
        Station,
        on_delete=models.CASCADE,
        related_name='correspondances_B'
    )

    temps_marche = models.PositiveIntegerField(
        help_text="Temps de marche en minutes"
    )

    def __str__(self):
        return f"{self.station_A} - {self.station_B}"


# 6. Horaire de passage
class Horaire(models.Model):
    ligne = models.ForeignKey(
        Ligne,
        on_delete=models.CASCADE,
        related_name='horaires'
    )

    station = models.ForeignKey(
        Station,
        on_delete=models.CASCADE,
        related_name='horaires'
    )

    heure_passage = models.TimeField()

    jour = models.CharField(
        max_length=20,
        blank=True
    )

    def __str__(self):
        return f"{self.ligne} - {self.heure_passage}"


# 7. Trajet favori
class TrajetFavori(models.Model):
    utilisateur = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='trajets_favoris'
    )

    depart = models.ForeignKey(
        Station,
        on_delete=models.CASCADE,
        related_name='favoris_depart'
    )

    arrivee = models.ForeignKey(
        Station,
        on_delete=models.CASCADE,
        related_name='favoris_arrivee'
    )

    date_ajout = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.depart} - {self.arrivee}"
