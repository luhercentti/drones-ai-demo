import React from 'react';
import { render, screen } from '@testing-library/react';
import { DroneStatus, DroneStatusProps } from './DroneStatus';

describe('DroneStatus Component', () => {
  it('should render drone information correctly', () => {
    const props: DroneStatusProps = {
      droneId: 'DRONE-001',
      status: 'active',
      batteryLevel: 85,
    };

    render(<DroneStatus {...props} />);

    expect(screen.getByText('Drone DRONE-001')).toBeInTheDocument();
    expect(screen.getByText('Status: active')).toBeInTheDocument();
    expect(screen.getByText('Battery: 85%')).toBeInTheDocument();
  });

  it('should display inactive status', () => {
    const props: DroneStatusProps = {
      droneId: 'DRONE-002',
      status: 'inactive',
      batteryLevel: 20,
    };

    render(<DroneStatus {...props} />);

    expect(screen.getByText('Status: inactive')).toBeInTheDocument();
  });

  it('should display maintenance status', () => {
    const props: DroneStatusProps = {
      droneId: 'DRONE-003',
      status: 'maintenance',
      batteryLevel: 50,
    };

    render(<DroneStatus {...props} />);

    expect(screen.getByText('Status: maintenance')).toBeInTheDocument();
  });

  it('should display battery level correctly', () => {
    const props: DroneStatusProps = {
      droneId: 'DRONE-004',
      status: 'active',
      batteryLevel: 100,
    };

    render(<DroneStatus {...props} />);

    expect(screen.getByText('Battery: 100%')).toBeInTheDocument();
  });
});
