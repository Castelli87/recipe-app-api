"""
Recipe Serializers
"""
from attr import field
from rest_framework import serializers

from core.models import Recipe, Tag


class RecipeSerializers(serializers.ModelSerializer):
    class Meta:
        model = Recipe

        fields = ["id", "title", "time_minutes", "price", "link"]
        read_only_fields = ["id"]


class RecipeDetailSerializer(RecipeSerializers):
    """Serializer for recipe detail view"""

    class Meta(RecipeSerializers.Meta):
        fields = RecipeSerializers.Meta.fields + ["description"]


class TagSerializer(serializers.ModelSerializer):
    """Serializer for tags."""

    class Meta:
        model = Tag
        fields = ["id", "name"]
        read_only_fields = ["id"]
