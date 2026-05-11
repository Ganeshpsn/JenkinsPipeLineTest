# Created by pgane at 5/1/2026
*** Settings ***
Library    ../resources/LoginPageApi.py


Suite Setup    Run Keywords    Access Class Variable    AND    Start Browser    chrome    ${HEADLESS}

Suite Teardown    Quit Browser

*** Variables ***
${Invalid_User_Message}     Your username is invalid!
${Invalid_Pwd_Message}     Your password is invalid!
${Valid_Username}    student
${Valid_Password}    Password123
${Invalid_Username}    incorrectUser
${Invalid_Password}    incorrectPassword

*** Test Cases ***
Test case 1: Positive LogIn test
    [Documentation]    Test Login with Valid credentials
    [Tags]    Positive
    [Setup]    Open Url    ${LOGIN_URL}
    Enter Username    ${Valid_Username}
    Enter Password    ${Valid_Password}
    Click Submit
    #1. Verify new page URL contains practicetestautomation.com/logged-in-successfully/
    ${Current_Url}=    Get Current Page Url
    Should be equal    ${Current_Url}    ${LOGIN_SUCCESS_URL}

    #2. Verify new page contains expected text ('Congratulations' or 'successfully logged in')
    ${page_text}=    Get element text    ${STRONG_LOCATOR}
    Should contain    ${page_text}    successfully logged in

    #3. Verify button Log out is displayed on the new page
    ${status}    Verify Logout Button Is Displayed
    Should be true    ${status}

Test case 2: Negative username test
    [Documentation]    Test Login with InValid username
    [Tags]    Negative
    [Setup]    Open Url    ${LOGIN_URL}
    Enter Username    ${Invalid_Username}
    Enter Password    ${Valid_Password}
    Click Submit
    # 1. Verify error message is displayed
    ${is_visible}=    Verify Error Message Is Displayed
    Should Be True    ${is_visible}

    # 2. Verify error message text
    ${actual_error}=    Get Error Message Text
    Should Be Equal    ${actual_error}    ${Invalid_User_Message}

Test case 3: Negative password test
    [Documentation]    Test Login with InValid password
    [Tags]    Negative
    [Setup]    Open Url    ${LOGIN_URL}
    Enter Username    ${Valid_Username}
    Enter Password    ${Invalid_Pwd_Message}
    Click Submit
    # 1. Verify error message is displayed
    ${is_visible}=    Verify Error Message Is Displayed
    Should Be True    ${is_visible}

    # 2. Verify error message text
    ${actual_error}=    Get Error Message Text
    Should Be Equal    ${actual_error}    ${Invalid_Pwd_Message}


*** Keywords ***
Access Class Variable
    ${lib}=    Get Library Instance    LoginPageApi
    ${url}=    Evaluate    $lib._LOGIN_URL
    Set suite variable    ${LOGIN_URL}    ${url}
    # ${lib._LOGIN_URL} --> direct access
    Set suite variable    ${LOGIN_SUCCESS_URL}    ${lib._LOGIN_SUCCESS_URL}
    Set suite variable    ${USERNAME_LOCATOR}    ${lib._USERNAME_LOCATOR}
    Set suite variable    ${USER_PASSWORD_LOCATOR}    ${lib._USER_PASSWORD_LOCATOR}
    Set suite variable    ${SUBMIT_BUTTON_LOCATOR}    ${lib._SUBMIT_BUTTON_LOCATOR}
    Set suite variable    ${LOGOUT_BUTTON_LOCATOR}    ${lib._LOGOUT_BUTTON_LOCATOR}
    Set suite variable    ${POST_TITLE_LOCATOR}    ${lib._POST_TITLE_LOCATOR}
    Set suite variable    ${STRONG_LOCATOR}    ${lib._STRONG_LOCATOR}
    Set suite variable    ${ERROR_LOCATOR}    ${lib._ERROR_LOCATOR}