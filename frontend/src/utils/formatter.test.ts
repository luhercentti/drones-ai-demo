import { formatDroneId, getBatteryStatusText, isLowBattery } from './formatter';

describe('Formatter Utils', () => {
  describe('formatDroneId', () => {
    it('should format drone id to uppercase', () => {
      expect(formatDroneId('drone-001')).toBe('DRONE-001');
    });

    it('should remove special characters except hyphen', () => {
      expect(formatDroneId('drone@001!')).toBe('DRONE001');
    });

    it('should keep valid characters', () => {
      expect(formatDroneId('ABC-123')).toBe('ABC-123');
    });
  });

  describe('getBatteryStatusText', () => {
    it('should return "Excelente" for battery >= 80', () => {
      expect(getBatteryStatusText(100)).toBe('Excelente');
      expect(getBatteryStatusText(80)).toBe('Excelente');
    });

    it('should return "Bueno" for battery >= 50 and < 80', () => {
      expect(getBatteryStatusText(79)).toBe('Bueno');
      expect(getBatteryStatusText(50)).toBe('Bueno');
    });

    it('should return "Bajo" for battery >= 20 and < 50', () => {
      expect(getBatteryStatusText(49)).toBe('Bajo');
      expect(getBatteryStatusText(20)).toBe('Bajo');
    });

    it('should return "Crítico" for battery < 20', () => {
      expect(getBatteryStatusText(19)).toBe('Crítico');
      expect(getBatteryStatusText(0)).toBe('Crítico');
    });
  });

  describe('isLowBattery', () => {
    it('should return true for battery < 20', () => {
      expect(isLowBattery(19)).toBe(true);
      expect(isLowBattery(0)).toBe(true);
    });

    it('should return false for battery >= 20', () => {
      expect(isLowBattery(20)).toBe(false);
      expect(isLowBattery(100)).toBe(false);
    });
  });
});
