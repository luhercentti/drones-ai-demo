import request from 'supertest';
import { app } from './index';

describe('Backend API', () => {
  describe('GET /health', () => {
    it('should return health status', async () => {
      const response = await request(app).get('/health');
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('status', 'ok');
      expect(response.body).toHaveProperty('service', 'drones-antimisiles-backend');
    });
  });
});
