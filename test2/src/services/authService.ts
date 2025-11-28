import axios from 'axios'

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000'

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
})

// Add token to requests if available
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('authToken')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

export const authService = {
  register: async (name: string, email: string, password: string) => {
    return api.post('/auth/register', { name, email, password })
  },

  login: async (email: string, password: string) => {
    return api.post('/auth/login', { email, password })
  },
}

export default api

