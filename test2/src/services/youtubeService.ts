// YouTube API service for fetching video metadata
const YOUTUBE_API_KEY = import.meta.env.VITE_YOUTUBE_API_KEY || ''
const YOUTUBE_API_URL = 'https://www.googleapis.com/youtube/v3/videos'

export const youtubeService = {
  getVideoMetadata: async (videoId: string) => {
    if (!YOUTUBE_API_KEY) {
      throw new Error('YouTube API key not configured')
    }

    const response = await fetch(
      `${YOUTUBE_API_URL}?id=${videoId}&key=${YOUTUBE_API_KEY}&part=snippet,contentDetails`
    )

    if (!response.ok) {
      throw new Error('Failed to fetch YouTube video metadata')
    }

    const data = await response.json()

    if (data.items && data.items.length > 0) {
      const video = data.items[0]
      return {
        title: video.snippet.title,
        description: video.snippet.description,
        thumbnail: video.snippet.thumbnails.high?.url || video.snippet.thumbnails.default.url,
        duration: parseDuration(video.contentDetails.duration),
      }
    }

    throw new Error('Video not found')
  },

  getThumbnail: (videoId: string) => {
    return `https://img.youtube.com/vi/${videoId}/maxresdefault.jpg`
  },
}

// Helper function to parse ISO 8601 duration to seconds
function parseDuration(duration: string): number {
  const match = duration.match(/PT(\d+H)?(\d+M)?(\d+S)?/)
  if (!match) return 0

  const hours = (match[1] || '').replace('H', '') || '0'
  const minutes = (match[2] || '').replace('M', '') || '0'
  const seconds = (match[3] || '').replace('S', '') || '0'

  return parseInt(hours) * 3600 + parseInt(minutes) * 60 + parseInt(seconds)
}

