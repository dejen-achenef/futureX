"""
Unit tests for reports app
"""
from django.test import TestCase
from unittest.mock import Mock, patch
from .services.report_service import ReportService
from .services.node_api_client import NodeAPIClient


class ReportServiceTestCase(TestCase):
    """Test cases for ReportService"""
    
    def setUp(self):
        """Set up test fixtures"""
        self.mock_api_client = Mock(spec=NodeAPIClient)
        self.service = ReportService(api_client=self.mock_api_client)
    
    def test_generate_summary_report(self):
        """Test summary report generation"""
        # Mock API responses
        self.mock_api_client.get_all_users.return_value = [
            {'id': 1, 'name': 'User 1', 'email': 'user1@test.com'},
            {'id': 2, 'name': 'User 2', 'email': 'user2@test.com'},
        ]
        
        self.mock_api_client.get_all_videos.return_value = [
            {'id': 1, 'title': 'Video 1', 'category': 'Programming'},
            {'id': 2, 'title': 'Video 2', 'category': 'Design'},
            {'id': 3, 'title': 'Video 3', 'category': 'Programming'},
        ]
        
        report = self.service.generate_summary_report()
        
        self.assertEqual(report['total_users'], 2)
        self.assertEqual(report['total_videos'], 3)
        self.assertEqual(len(report['top_categories']), 2)
        self.assertEqual(report['top_categories'][0]['category'], 'Programming')
        self.assertEqual(report['top_categories'][0]['count'], 2)
    
    def test_generate_user_activity_report(self):
        """Test user activity report generation"""
        user_id = 1
        
        self.mock_api_client.get_user_by_id.return_value = {
            'id': 1,
            'name': 'Test User',
            'email': 'test@test.com',
        }
        
        self.mock_api_client.get_all_videos.return_value = [
            {
                'id': 1,
                'title': 'Video 1',
                'category': 'Programming',
                'duration': 300,
                'userId': 1,
            },
            {
                'id': 2,
                'title': 'Video 2',
                'category': 'Design',
                'duration': 450,
                'userId': 1,
            },
        ]
        
        report = self.service.generate_user_activity_report(user_id)
        
        self.assertEqual(report['user']['id'], 1)
        self.assertEqual(report['total_videos'], 2)
        self.assertEqual(report['total_duration_seconds'], 750)
        self.assertEqual(len(report['videos_by_category']), 2)
        self.assertEqual(report['videos_by_category']['Programming'], 1)
        self.assertEqual(report['videos_by_category']['Design'], 1)
    
    def test_generate_user_activity_report_user_not_found(self):
        """Test user activity report when user is not found"""
        user_id = 999
        
        self.mock_api_client.get_user_by_id.return_value = None
        
        report = self.service.generate_user_activity_report(user_id)
        
        self.assertIn('error', report)
        self.assertEqual(report['error'], 'User not found')


class NodeAPIClientTestCase(TestCase):
    """Test cases for NodeAPIClient"""
    
    @patch('reports.services.node_api_client.requests.get')
    def test_get_all_videos_success(self, mock_get):
        """Test successful video fetch"""
        mock_response = Mock()
        mock_response.json.return_value = {
            'success': True,
            'data': [
                {'id': 1, 'title': 'Video 1'},
                {'id': 2, 'title': 'Video 2'},
            ]
        }
        mock_response.raise_for_status = Mock()
        mock_get.return_value = mock_response
        
        client = NodeAPIClient(base_url='http://test-api.com')
        videos = client.get_all_videos()
        
        self.assertEqual(len(videos), 2)
        self.assertEqual(videos[0]['id'], 1)
    
    @patch('reports.services.node_api_client.requests.get')
    def test_get_all_videos_failure(self, mock_get):
        """Test video fetch failure"""
        import requests
        mock_get.side_effect = requests.exceptions.RequestException('Connection error')
        
        client = NodeAPIClient(base_url='http://test-api.com')
        
        with self.assertRaises(Exception):
            client.get_all_videos()

