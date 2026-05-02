from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from MyWebDriver import MyWebDriver
from robot.api import logger


class PageActions(MyWebDriver):

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    def __init__(self):
        super().__init__()

    def find_ele(self, locator):
        try:
            # Create the wait instance only when you actually need to find an element
            wait = WebDriverWait(self.driver, 15)
            self.ele = wait.until(EC.presence_of_element_located(locator))
            logger.info(f"Found Element {locator}", html=True)
            return self.ele
        except Exception as e:
            logger.error(f"Not Found Element {locator}. Error: {e}", html=True)
            raise  # Crucial: Raise the error so Robot Framework marks the test as failed

    def click_ele(self, locator):
        #self.ele.location_once_scrolled_into_view
        self.find_ele(locator).click()
        logger.info(f"Clicked Element {self.ele}", html=True)

    def enter_text(self, locator, message):
        self.ele_text = self.find_ele(locator)
        self.ele_text.clear()
        self.ele_text.send_keys(message)
        logger.info(f"Entered text {message} into input field {self.ele_text}", html=True)

    def get_page_title(self):
        self.page_title= self.driver.title
        logger.info(f"Got Current Page Title is {self.page_title}", html=True)
        return self.page_title

    def get_current_page_url(self):
        self.page_url = self.driver.current_url
        logger.info(f"Got Current Page URL is {self.page_url}", html=True)
        return self.page_url

    def get_element_text(self, locator):
        self.ele_t = self.find_ele(locator).text
        logger.info(f"Element Text: {self.ele_t}")
        return self.ele_t
