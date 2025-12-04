import React from 'react';

export interface DroneStatusProps {
  droneId: string;
  status: 'active' | 'inactive' | 'maintenance';
  batteryLevel: number;
}

export const DroneStatus: React.FC<DroneStatusProps> = ({ droneId, status, batteryLevel }) => {
  const getStatusColor = (): string => {
    switch (status) {
      case 'active':
        return 'green';
      case 'inactive':
        return 'gray';
      case 'maintenance':
        return 'orange';
      default:
        return 'gray';
    }
  };

  return (
    <div className="drone-status">
      <h3>Drone {droneId}</h3>
      <p style={{ color: getStatusColor() }}>Status: {status}</p>
      <p>Battery: {batteryLevel}%</p>
    </div>
  );
};
