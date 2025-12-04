import { validateCoordinates, calculateDistance, Coordinates } from './gps';

describe('GPS Utils', () => {
  describe('validateCoordinates', () => {
    it('should return true for valid coordinates', () => {
      const coords: Coordinates = { latitude: 40.7128, longitude: -74.006 };
      expect(validateCoordinates(coords)).toBe(true);
    });

    it('should return false for latitude > 90', () => {
      const coords: Coordinates = { latitude: 91, longitude: 0 };
      expect(validateCoordinates(coords)).toBe(false);
    });

    it('should return false for latitude < -90', () => {
      const coords: Coordinates = { latitude: -91, longitude: 0 };
      expect(validateCoordinates(coords)).toBe(false);
    });

    it('should return false for longitude > 180', () => {
      const coords: Coordinates = { latitude: 0, longitude: 181 };
      expect(validateCoordinates(coords)).toBe(false);
    });

    it('should return false for longitude < -180', () => {
      const coords: Coordinates = { latitude: 0, longitude: -181 };
      expect(validateCoordinates(coords)).toBe(false);
    });

    it('should return true for edge case coordinates', () => {
      expect(validateCoordinates({ latitude: 90, longitude: 180 })).toBe(true);
      expect(validateCoordinates({ latitude: -90, longitude: -180 })).toBe(true);
      expect(validateCoordinates({ latitude: 0, longitude: 0 })).toBe(true);
    });
  });

  describe('calculateDistance', () => {
    it('should calculate distance between two coordinates', () => {
      const coord1: Coordinates = { latitude: 40.7128, longitude: -74.006 }; // New York
      const coord2: Coordinates = { latitude: 51.5074, longitude: -0.1278 }; // London
      const distance = calculateDistance(coord1, coord2);
      expect(distance).toBeGreaterThan(5500);
      expect(distance).toBeLessThan(5600);
    });

    it('should return 0 for same coordinates', () => {
      const coord: Coordinates = { latitude: 0, longitude: 0 };
      const distance = calculateDistance(coord, coord);
      expect(distance).toBe(0);
    });

    it('should calculate distance for nearby points', () => {
      const coord1: Coordinates = { latitude: 40.7128, longitude: -74.006 };
      const coord2: Coordinates = { latitude: 40.758, longitude: -73.9855 };
      const distance = calculateDistance(coord1, coord2);
      expect(distance).toBeGreaterThan(6);
      expect(distance).toBeLessThan(7);
    });
  });
});
