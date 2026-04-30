import pytest
from Calculator_Project.Calculator import Calculator

@pytest.fixture
def calc():
    return Calculator()

# Positive & Edge Cases using Parametrize
@pytest.mark.parametrize("a, b, expected", [
    (10, 5, 15),    # Positive
    (-1, -1, -2),   # Negative values
    (0, 0, 0),      # Edge Case: Zero
    (2.5, 2.5, 5.0) # Floating point
])
def test_addition(calc, a, b, expected):
    assert calc.add_numbers(a, b) == expected

# Negative Case: Division by Zero
def test_divide_by_zero(calc):
    with pytest.raises(ValueError, match="Cannot divide by zero"):
        calc.divide_numbers(10, 0)