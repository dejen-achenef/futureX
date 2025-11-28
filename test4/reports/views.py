"""
Views for report endpoints
"""
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .services.report_service import ReportService
from .serializers import SummaryReportSerializer, UserActivityReportSerializer


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

