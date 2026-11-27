
from django.contrib import admin
from .models import (
    ModeTransport,
    Ligne,
    Station,
    Troncon,
    Correspondance,
    Horaire,
    TrajetFavori
)


@admin.register(ModeTransport)
class ModeTransportAdmin(admin.ModelAdmin):
    list_display = ('id', 'nom')
    search_fields = ('nom',)


@admin.register(Ligne)
class LigneAdmin(admin.ModelAdmin):
    list_display = ('id', 'nom', 'mode_transport')
    list_filter = ('mode_transport',)
    search_fields = ('nom',)


@admin.register(Station)
class StationAdmin(admin.ModelAdmin):
    list_display = ('id', 'nom', 'latitude', 'longitude')
    search_fields = ('nom',)


@admin.register(Troncon)
class TronconAdmin(admin.ModelAdmin):
    list_display = (
        'id', 'station_depart', 'station_arrivee',
        'ligne', 'duree', 'distance'
    )
    list_filter = ('ligne',)
    search_fields = ('station_depart__nom', 'station_arrivee__nom')


@admin.register(Correspondance)
class CorrespondanceAdmin(admin.ModelAdmin):
    list_display = ('id', 'station_A', 'station_B', 'temps_marche')


@admin.register(Horaire)
class HoraireAdmin(admin.ModelAdmin):
    list_display = ('id', 'ligne', 'station', 'heure_passage', 'jour')
    list_filter = ('ligne', 'jour')


@admin.register(TrajetFavori)
class TrajetFavoriAdmin(admin.ModelAdmin):
    list_display = ('id', 'utilisateur', 'depart', 'arrivee', 'date_ajout')
    search_fields = ('utilisateur__username',)
