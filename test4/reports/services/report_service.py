"""
Report generation service
"""
from typing import Dict, List, Optional
from .node_api_client import NodeAPIClient
from collections import Counter


class ReportService:
    """Service for generating reports"""
    
    def __init__(self, api_client: Optional[NodeAPIClient] = None):
        self.api_client = api_client or NodeAPIClient()
    
    def generate_summary_report(self) -> Dict:
        """Generate summary report with total users, videos, and top categories"""
        users = self.api_client.get_all_users()
        videos = self.api_client.get_all_videos()
        
        # Count categories
        categories = [video.get('category') for video in videos if video.get('category')]
        category_counts = Counter(categories)
        top_categories = [
            {'category': cat, 'count': count}
            for cat, count in category_counts.most_common(5)
        ]
        
        return {
            'total_users': len(users),
            'total_videos': len(videos),
            'top_categories': top_categories,
        }
    
    def generate_user_activity_report(self, user_id: int) -> Dict:
        """Generate activity report for a specific user"""
        user = self.api_client.get_user_by_id(user_id)
        if not user:
            return {'error': 'User not found'}
        
        videos = self.api_client.get_all_videos()
        user_videos = [v for v in videos if v.get('userId') == user_id or v.get('user_id') == user_id]
        
        # Count videos by category
        categories = [video.get('category') for video in user_videos if video.get('category')]
        category_counts = Counter(categories)
        
        total_duration = sum(video.get('duration', 0) for video in user_videos)
        
        return {
            'user': {
                'id': user.get('id'),
                'name': user.get('name'),
                'email': user.get('email'),
            },
            'total_videos': len(user_videos),
            'total_duration_seconds': total_duration,
            'videos_by_category': dict(category_counts),
            'videos': user_videos,
        }

