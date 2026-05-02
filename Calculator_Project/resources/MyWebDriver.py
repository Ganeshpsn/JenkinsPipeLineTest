from selenium import webdriver
from robot.api import logger


class MyWebDriver:
    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'
    def __init__(self):
        self.driver = None

    def start_browser(self, browser="chrome"):
        # Log an INFO message so you know which browser is launching
        logger.info(f"Attempting to start {browser} browser...")

        try:
            if browser.lower() == "chrome":
                self.driver = webdriver.Chrome()
            elif browser.lower() == "firefox":
                self.driver = webdriver.Firefox()
            else:
                # Log an error if the browser type is wrong
                logger.error(f"Unsupported browser type provided: {browser}")
                raise ValueError(f"Unsupported browser: {browser}")

            self.driver.maximize_window()
            #self.driver.implicitly_wait(10)
            logger.info(f"{browser.capitalize()} browser started and maximized successfully.", console=True)
            return self.driver

        except Exception as e:
            logger.error(f"Failed to start the browser. Error: {str(e)}")
            raise

    def open_url(self, url):
        if self.driver:
            # Info logs show up in the report under the keyword
            logger.info(f"Navigating to URL: {url}")
            self.driver.get(url)
            #self.driver.implicitly_wait(15)
        else:
            logger.error("Execution failed: open_url called before start_browser.")
            raise RuntimeError("Browser not initialized. Call 'start_browser' first.")

    def quit_browser(self):
        if self.driver:
            logger.info("Closing the browser instance.", console=True)
            self.driver.quit()
        else:
            # A debug log is useful for technical details that don't need to clutter the main report
            logger.debug("quit_browser called but no active driver session was found.")