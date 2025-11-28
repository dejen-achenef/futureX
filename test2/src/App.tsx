import { Routes, Route, Navigate } from 'react-router-dom'
import { ThemeProvider, createTheme } from '@mui/material/styles'
import CssBaseline from '@mui/material/CssBaseline'
import { AuthProvider, useAuth } from './context/AuthContext'
import LoginPage from './pages/LoginPage'
import UserListPage from './pages/UserListPage'
import VideoUploadPage from './pages/VideoUploadPage'
import ProtectedRoute from './components/ProtectedRoute'

const theme = createTheme({
  palette: {
    mode: 'light',
    primary: {
      main: '#1976d2',
    },
    secondary: {
      main: '#dc004e',
    },
  },
})

function AppRoutes() {
  const { isAuthenticated } = useAuth()

  return (
    <Routes>
      <Route 
        path="/login" 
        element={isAuthenticated ? <Navigate to="/users" replace /> : <LoginPage />} 
      />
      <Route
        path="/users"
        element={
          <ProtectedRoute>
            <UserListPage />
          </ProtectedRoute>
        }
      />
      <Route
        path="/videos/upload"
        element={
          <ProtectedRoute>
            <VideoUploadPage />
          </ProtectedRoute>
        }
      />
      <Route path="/" element={<Navigate to="/users" replace />} />
    </Routes>
  )
}

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <AuthProvider>
        <AppRoutes />
      </AuthProvider>
    </ThemeProvider>
  )
}

export default App

