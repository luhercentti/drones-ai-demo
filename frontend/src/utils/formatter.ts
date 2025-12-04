export function formatDroneId(id: string): string {
  return id.toUpperCase().replace(/[^A-Z0-9-]/g, '');
}

export function getBatteryStatusText(level: number): string {
  if (level >= 80) {
    return 'Excelente';
  } else if (level >= 50) {
    return 'Bueno';
  } else if (level >= 20) {
    return 'Bajo';
  } else {
    return 'Crítico';
  }
}

export function isLowBattery(level: number): boolean {
  return level < 20;
}
