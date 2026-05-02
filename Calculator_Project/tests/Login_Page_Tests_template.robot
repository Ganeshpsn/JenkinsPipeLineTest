# Created by pgane at 5/1/2026
*** Settings ***
Library    ../resources/LoginPageApi.py


Suite Setup    Run Keywords    Access Class Variable    AND    Start Browser    chrome

Suite Teardown    Quit Browser

# This keyword will be used for every test case below
Test Template   Login With Different Credentials

Test Teardown    Sleep    2s

*** Variables ***
${Invalid_User_Message}     Your username is invalid!
${Invalid_Pwd_Message}     Your password is invalid!
${Valid_Username}    student
${Valid_Password}    Password123
${Invalid_Username}    incorrectUser
${Invalid_Password}    incorrectPassword

*** Test Cases ***                USERNAME    PASSWORD    EXPECTED ERROR
Invalid Username                  ${Invalid_Username}    ${Valid_Password}    Your username is invalid!
Invalid Password                  ${Valid_Username}    ${Invalid_Password}    Your password is invalid!
Empty Credentials                 ${EMPTY}    ${EMPTY}    Your username is invalid!
Valid Credentials                 ${Valid_Username}    ${Valid_Password}    successfully logged in


*** Keywords ***
Access Class Variable
    ${lib}    Get Library Instance    LoginPageApi
    ${url}    Evaluate    $lib._LOGIN_URL
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

Login With Different Credentials
    [Arguments]    ${username}    ${password}    ${expected_message}
    [Setup]    Open Url    ${LOGIN_URL}
    Enter Username    ${username}
    Enter Password    ${password}
    Sleep    1s
    Click Submit
    Sleep    2s
    ${is_visible}    ${status}    Run keyword and ignore error    Verify Error Message Is Displayed
    IF    "${is_visible}" == "PASS"
        ${actual_message}    Get Error Message Text
        Should Be Equal     ${actual_message}    ${expected_message}
    ELSE
        ${page_text}    Get element text    ${STRONG_LOCATOR}
        Should contain    ${page_text}    ${expected_message}
    END
