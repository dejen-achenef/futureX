import api from './authService'

export const userService = {
  getAllUsers: async (search?: string, page: number = 1, limit: number = 10) => {
    const params = new URLSearchParams()
    if (search) params.append('search', search)
    params.append('page', page.toString())
    params.append('limit', limit.toString())
    
    return api.get(`/users?${params.toString()}`)
  },

  getUserById: async (id: number) => {
    return api.get(`/users/${id}`)
  },
}

