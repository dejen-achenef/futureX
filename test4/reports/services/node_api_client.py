"""
Client for fetching data from Node.js API
"""
import requests
from django.conf import settings
from typing import Dict, List, Optional


class NodeAPIClient:
    """Client to interact with Node.js API"""
    
    def __init__(self, base_url: Optional[str] = None):
        self.base_url = base_url or settings.NODE_API_URL
        self.timeout = 30
    
    def _get(self, endpoint: str) -> Dict:
        """Make GET request to Node.js API"""
        url = f"{self.base_url}{endpoint}"
        try:
            response = requests.get(url, timeout=self.timeout)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"Failed to fetch from Node API: {str(e)}")
    
    def get_all_users(self) -> List[Dict]:
        """Fetch all users from Node.js API"""
        # Note: This endpoint requires authentication
        # In production, you'd need to pass a token
        try:
            response = self._get('/users')
            if response.get('success'):
                return response.get('data', [])
            return []
        except Exception:
            # If auth fails, return empty list
            return []
    
    def get_all_videos(self, search: Optional[str] = None, category: Optional[str] = None) -> List[Dict]:
        """Fetch all videos from Node.js API"""
        params = {}
        if search:
            params['search'] = search
        if category:
            params['category'] = category
        
        query_string = '&'.join([f"{k}={v}" for k, v in params.items()])
        endpoint = f"/videos?{query_string}" if query_string else "/videos"
        
        try:
            response = self._get(endpoint)
            if response.get('success'):
                return response.get('data', [])
            return []
        except Exception:
            return []
    
    def get_user_by_id(self, user_id: int) -> Optional[Dict]:
        """Fetch user by ID from Node.js API"""
        try:
            response = self._get(f'/users/{user_id}')
            if response.get('success'):
                return response.get('data')
            return None
        except Exception:
            return None

