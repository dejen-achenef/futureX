"""
Views for report endpoints
"""
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from drf_spectacular.utils import extend_schema, OpenApiParameter, OpenApiExample
from drf_spectacular.types import OpenApiTypes
from .services.report_service import ReportService
from .serializers import SummaryReportSerializer, UserActivityReportSerializer


@extend_schema(
    summary='Get summary report',
    description='Returns summary statistics including total users, total videos, and top categories',
    tags=['Reports'],
    responses={
        200: SummaryReportSerializer,
        500: OpenApiTypes.OBJECT
    },
    examples=[
        OpenApiExample(
            'Example Response',
            value={
                'total_users': 10,
                'total_videos': 25,
                'top_categories': [
                    {'category': 'Programming', 'count': 8},
                    {'category': 'Design', 'count': 5}
                ]
            }
        )
    ]
)
@api_view(['GET'])
def summary_report(request):
    """Generate summary report"""
    try:
        service = ReportService()
        report_data = service.generate_summary_report()
        serializer = SummaryReportSerializer(report_data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@extend_schema(
    summary='Get user activity report',
    description='Returns detailed activity report for a specific user including videos, duration, and categories',
    tags=['Reports'],
    parameters=[
        OpenApiParameter(
            name='user_id',
            type=OpenApiTypes.INT,
            location=OpenApiParameter.PATH,
            description='User ID',
            required=True,
            examples=[
                OpenApiExample('Example', value=1)
            ]
        )
    ],
    responses={
        200: UserActivityReportSerializer,
        404: OpenApiTypes.OBJECT,
        500: OpenApiTypes.OBJECT
    },
    examples=[
        OpenApiExample(
            'Example Response',
            value={
                'user': {
                    'id': 1,
                    'name': 'John Doe',
                    'email': 'john@example.com'
                },
                'total_videos': 5,
                'total_duration_seconds': 1500,
                'videos_by_category': {
                    'Programming': 3,
                    'Design': 2
                },
                'videos': []
            }
        )
    ]
)
@api_view(['GET'])
def user_activity_report(request, user_id):
    """Generate user activity report"""
    try:
        service = ReportService()
        report_data = service.generate_user_activity_report(user_id)
        
        if 'error' in report_data:
            return Response(
                report_data,
                status=status.HTTP_404_NOT_FOUND
            )
        
        serializer = UserActivityReportSerializer(report_data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

