"""
Serializers for report responses
"""
from rest_framework import serializers


class SummaryReportSerializer(serializers.Serializer):
    total_users = serializers.IntegerField()
    total_videos = serializers.IntegerField()
    top_categories = serializers.ListField(
        child=serializers.DictField()
    )


class UserActivityReportSerializer(serializers.Serializer):
    user = serializers.DictField()
    total_videos = serializers.IntegerField()
    total_duration_seconds = serializers.IntegerField()
    videos_by_category = serializers.DictField()
    videos = serializers.ListField(
        child=serializers.DictField()
    )

