"""
URLs for reports app
"""
from django.urls import path
from . import views

urlpatterns = [
    path('summary', views.summary_report, name='summary-report'),
    path('user/<int:user_id>', views.user_activity_report, name='user-activity-report'),
]

