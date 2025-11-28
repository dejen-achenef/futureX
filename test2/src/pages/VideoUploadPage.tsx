import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Container,
  Paper,
  TextField,
  Button,
  Typography,
  Box,
  Alert,
  MenuItem,
  CircularProgress,
  AppBar,
  Toolbar,
  IconButton,
} from '@mui/material'
import { ArrowBack } from '@mui/icons-material'
import { videoService } from '../services/videoService'
import { youtubeService } from '../services/youtubeService'

const categories = [
  'Programming',
  'Design',
  'Business',
  'Marketing',
  'Science',
  'Education',
  'Entertainment',
  'Other',
]

const VideoUploadPage = () => {
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    youtubeVideoId: '',
    category: '',
    duration: 0,
  })
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [loading, setLoading] = useState(false)
  const [fetchingMetadata, setFetchingMetadata] = useState(false)
  const navigate = useNavigate()

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target
    setFormData((prev) => ({
      ...prev,
      [name]: name === 'duration' ? parseInt(value) || 0 : value,
    }))
  }

  const handleFetchYouTubeMetadata = async () => {
    if (!formData.youtubeVideoId) {
      setError('Please enter a YouTube video ID first')
      return
    }

    setFetchingMetadata(true)
    setError('')
    try {
      const metadata = await youtubeService.getVideoMetadata(formData.youtubeVideoId)
      setFormData((prev) => ({
        ...prev,
        title: metadata.title || prev.title,
        description: metadata.description || prev.description,
        duration: metadata.duration || prev.duration,
      }))
      setSuccess('Video metadata fetched successfully!')
    } catch (err: any) {
      setError(err.message || 'Failed to fetch video metadata. Please enter details manually.')
    } finally {
      setFetchingMetadata(false)
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError('')
    setSuccess('')
    setLoading(true)

    try {
      await videoService.createVideo(formData)
      setSuccess('Video uploaded successfully!')
      setTimeout(() => {
        navigate('/users')
      }, 1500)
    } catch (err: any) {
      setError(err.response?.data?.message || 'Failed to upload video')
    } finally {
      setLoading(false)
    }
  }

  return (
    <Box>
      <AppBar position="static">
        <Toolbar>
          <IconButton edge="start" color="inherit" onClick={() => navigate('/users')} sx={{ mr: 2 }}>
            <ArrowBack />
          </IconButton>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            Upload Video
          </Typography>
        </Toolbar>
      </AppBar>

      <Container maxWidth="md" sx={{ mt: 4, mb: 4 }}>
        <Paper sx={{ p: 4 }}>
          <Typography variant="h5" component="h1" gutterBottom>
            Upload Video Metadata
          </Typography>

          {error && (
            <Alert severity="error" sx={{ mt: 2, mb: 2 }}>
              {error}
            </Alert>
          )}

          {success && (
            <Alert severity="success" sx={{ mt: 2, mb: 2 }}>
              {success}
            </Alert>
          )}

          <Box component="form" onSubmit={handleSubmit} sx={{ mt: 3 }}>
            <TextField
              fullWidth
              label="YouTube Video ID"
              name="youtubeVideoId"
              value={formData.youtubeVideoId}
              onChange={handleChange}
              required
              margin="normal"
              helperText="Enter the YouTube video ID (e.g., dQw4w9WgXcQ)"
              InputProps={{
                endAdornment: (
                  <Button
                    onClick={handleFetchYouTubeMetadata}
                    disabled={fetchingMetadata || !formData.youtubeVideoId}
                    size="small"
                  >
                    {fetchingMetadata ? <CircularProgress size={20} /> : 'Fetch Metadata'}
                  </Button>
                ),
              }}
            />

            <TextField
              fullWidth
              label="Title"
              name="title"
              value={formData.title}
              onChange={handleChange}
              required
              margin="normal"
            />

            <TextField
              fullWidth
              label="Description"
              name="description"
              value={formData.description}
              onChange={handleChange}
              multiline
              rows={4}
              margin="normal"
            />

            <TextField
              fullWidth
              select
              label="Category"
              name="category"
              value={formData.category}
              onChange={handleChange}
              required
              margin="normal"
            >
              {categories.map((cat) => (
                <MenuItem key={cat} value={cat}>
                  {cat}
                </MenuItem>
              ))}
            </TextField>

            <TextField
              fullWidth
              label="Duration (seconds)"
              name="duration"
              type="number"
              value={formData.duration}
              onChange={handleChange}
              required
              margin="normal"
              inputProps={{ min: 0 }}
            />

            <Box sx={{ display: 'flex', gap: 2, mt: 3 }}>
              <Button
                type="submit"
                variant="contained"
                disabled={loading}
                sx={{ flex: 1 }}
              >
                {loading ? 'Uploading...' : 'Upload Video'}
              </Button>
              <Button
                variant="outlined"
                onClick={() => navigate('/users')}
                sx={{ flex: 1 }}
              >
                Cancel
              </Button>
            </Box>
          </Box>
        </Paper>
      </Container>
    </Box>
  )
}

export default VideoUploadPage

