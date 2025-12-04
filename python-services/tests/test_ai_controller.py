"""Tests para AI Controller."""
import pytest
from src.ai_controller import AIController


class TestAIController:
    """Tests para AIController."""

    def test_initialization(self):
        """Test de inicialización del controlador."""
        controller = AIController()
        assert controller.is_initialized is False
        assert controller.initialize() is True
        assert controller.is_initialized is True

    def test_initialization_with_model_path(self):
        """Test de inicialización con ruta de modelo."""
        controller = AIController(model_path="/path/to/model")
        assert controller.model_path == "/path/to/model"

    def test_predict_threat_level_not_initialized(self):
        """Test que falla si no está inicializado."""
        controller = AIController()
        with pytest.raises(RuntimeError, match="no está inicializado"):
            controller.predict_threat_level({"speed": 100})

    def test_predict_threat_level_low_threat(self):
        """Test de predicción con baja amenaza."""
        controller = AIController()
        controller.initialize()
        threat = controller.predict_threat_level({"speed": 100, "altitude": 8000})
        assert 0.0 <= threat <= 1.0
        assert threat < 0.5

    def test_predict_threat_level_high_threat(self):
        """Test de predicción con alta amenaza."""
        controller = AIController()
        controller.initialize()
        threat = controller.predict_threat_level({"speed": 900, "altitude": 1000})
        assert 0.0 <= threat <= 1.0
        assert threat > 0.7

    def test_predict_threat_level_no_data(self):
        """Test de predicción sin datos."""
        controller = AIController()
        controller.initialize()
        threat = controller.predict_threat_level({})
        assert threat == 1.0  # Sin datos, altitud 0 = amenaza máxima

    def test_calculate_intercept_point_not_initialized(self):
        """Test de cálculo de intercepción sin inicializar."""
        controller = AIController()
        with pytest.raises(RuntimeError, match="no está inicializado"):
            controller.calculate_intercept_point((0, 0, 0), (100, 100, 100), (10, 10, 10))

    def test_calculate_intercept_point(self):
        """Test de cálculo de punto de intercepción."""
        controller = AIController()
        controller.initialize()
        drone_pos = (0, 0, 0)
        target_pos = (100, 100, 100)
        target_vel = (10, 20, 30)

        intercept = controller.calculate_intercept_point(drone_pos, target_pos, target_vel)

        assert isinstance(intercept, tuple)
        assert len(intercept) == 3
        assert intercept[0] == 120  # 100 + 10*2
        assert intercept[1] == 140  # 100 + 20*2
        assert intercept[2] == 160  # 100 + 30*2

    def test_calculate_intercept_point_zero_velocity(self):
        """Test de intercepción con velocidad cero."""
        controller = AIController()
        controller.initialize()
        intercept = controller.calculate_intercept_point((0, 0, 0), (50, 50, 50), (0, 0, 0))

        assert intercept == (50, 50, 50)

    def test_calculate_intercept_point_negative_velocity(self):
        """Test de intercepción con velocidad negativa."""
        controller = AIController()
        controller.initialize()
        intercept = controller.calculate_intercept_point((0, 0, 0), (100, 100, 100), (-5, -10, -15))

        assert intercept == (90, 80, 70)
