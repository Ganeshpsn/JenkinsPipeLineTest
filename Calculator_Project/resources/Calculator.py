from robot.api import logger


class Calculator:

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'      # Or 'TEST CASE' / 'GLOBAL'

    """
    TEST CASE (Default)	A new instance of Calculator is created for every test case.
    TEST SUITE	One instance is created for the entire .robot file.
    GLOBAL	One instance for the entire execution (even across multiple .robot files).
    """

    def __init__(self):
        self.history = []  # This stores state!

    def add_numbers(self, a, b):
        result = a + b
        # 'also_console=True' ensures the log appears in both the log.html and your terminal
        logger.info(f"Adding {a} + {b} = {result}", console=True)
        self.history.append(f"{a}+{b}={result}")
        return result

    def divide_numbers(self, a, b):
        if b == 0:
            logger.error("Attempted to divide by zero!", console=True)
            raise ValueError("Cannot divide by zero")

        result = a / b
        logger.info(f"Dividing {a} by {b} = {result}", console=True)
        self.history.append(f"{a}/{b}={result}")
        return result

    def subtract_numbers(self, a, b):
        result = a - b
        logger.info(f"Subtracting {b} from {a} = {result}", console=True)
        self.history.append(f"{a}-{b}={result}")
        return result

    def multiply_numbers(self, a, b):
        result = a * b
        logger.info(f"Multiplying {a} and {b} = {result}", console=True)
        self.history.append(f"{a}*{b}={result}")
        return result

    def get_calculator_history(self):

        logger.info(f"\n{'='*25}\nCalculator History\n"
                    f"{'-'*25}\n{'\n'.join(self.history)}\n{'='*25}", console=True, html=True)
        return self.history
