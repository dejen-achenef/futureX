import api from './authService'

export const videoService = {
  createVideo: async (videoData: {
    title: string
    description: string
    youtubeVideoId: string
    category: string
    duration: number
  }) => {
    return api.post('/videos', videoData)
  },

  getAllVideos: async (search?: string, category?: string) => {
    const params = new URLSearchParams()
    if (search) params.append('search', search)
    if (category) params.append('category', category)
    
    return api.get(`/videos?${params.toString()}`)
  },

  getVideoById: async (id: number) => {
    return api.get(`/videos/${id}`)
  },
}

