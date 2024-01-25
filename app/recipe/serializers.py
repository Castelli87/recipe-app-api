"""
Recipe Serializers
"""
from rest_framework import serializers

from core.models import Recipe

class RecipeSerializers(serializers.ModelSerializer):
    class Meta:
        model = Recipe

        fields = ['id','title','time_minutes','price','link']
        read_only_fields = ['id']