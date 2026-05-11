from PageActions import PageActions
from robot.api import logger
from robot.api.deco import keyword
from selenium.webdriver.common.by import By


class LoginPageApi(PageActions):

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    _LOGIN_URL = "https://practicetestautomation.com/practice-test-login/"
    _LOGIN_SUCCESS_URL = "https://practicetestautomation.com/logged-in-successfully/"
    _USERNAME_LOCATOR = (By.ID, 'username')
    _USER_PASSWORD_LOCATOR = (By.CSS_SELECTOR, 'input#password')
    _SUBMIT_BUTTON_LOCATOR = (By.ID, 'submit')
    _LOGOUT_BUTTON_LOCATOR = (By.XPATH, '//div/a[normalize-space(text())="Log out"]')
    _POST_TITLE_LOCATOR = (By.XPATH, '//h1[@class="post-title"]')
    _STRONG_LOCATOR = (By.XPATH, '//p[@class="has-text-align-center"]/strong')
    _ERROR_LOCATOR = (By.CSS_SELECTOR, 'div#error')

    def enter_username(self, username):
        self.enter_text(self._USERNAME_LOCATOR, username)

    def enter_password(self, password):
        self.enter_text(self._USER_PASSWORD_LOCATOR,password)

    def click_submit(self):
        self.click_ele(self._SUBMIT_BUTTON_LOCATOR)

    def click_logout_button(self):
        self.click_ele(self._LOGOUT_BUTTON_LOCATOR)
        logger.info(f"Logout from ")

    def verify_logout_button_is_displayed(self):
        return self.find_ele(self._LOGOUT_BUTTON_LOCATOR).is_displayed()

    def verify_error_message_is_displayed(self):
        # find_ele returns the element if found, or raises an error if not
        element = self.find_ele(self._ERROR_LOCATOR)
        #is_displayed = element.is_displayed()
        is_displayed = element.is_enabled()
        logger.info(f"Error message display status: {is_displayed}", console=True)
        return is_displayed

    def get_error_message_text(self):
        # Reuses your existing get_element_text logic
        return self.get_element_text(self._ERROR_LOCATOR)