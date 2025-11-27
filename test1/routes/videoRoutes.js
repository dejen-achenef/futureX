import express from 'express';
const router = express.Router();
import * as videoController from '../controllers/videoController.js';
import { authenticate } from '../middleware/auth.js';
import { validate, schemas } from '../middleware/validation.js';

// POST /videos (protected)
router.post('/', authenticate, validate(schemas.createVideo), videoController.createVideo);

// GET /videos (public - with optional search and category filters)
router.get('/', videoController.getAllVideos);

// GET /videos/:id (public)
router.get('/:id', videoController.getVideoById);

// PUT /videos/:id (protected)
router.put('/:id', authenticate, validate(schemas.createVideo), videoController.updateVideo);

// DELETE /videos/:id (protected)
router.delete('/:id', authenticate, videoController.deleteVideo);

export default router;