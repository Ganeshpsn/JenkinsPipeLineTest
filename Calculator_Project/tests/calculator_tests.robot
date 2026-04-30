*** Settings ***
Library    ../resources/Calculator.py

*** Test Cases ***
Validate Addition Logic
    [Documentation]    Test adding two positive numbers
    ${result}=    Add numbers    ${10}    ${5}
    Log To Console    \nAddition Result: ${result}
    Should Be Equal As Numbers    ${result}    ${15}

Validate Addition With Number And String
    [Documentation]    Test adding two with Number and String
    ${result}=    Add numbers    ${10}    5
    Log To Console    \nAddition Result: ${result}
    Should be equal    ${result}    ${None}

Validate Division Edge Case
    [Documentation]    Test division and verify console logging
    ${result}=    Divide Numbers    ${10}    ${2}
    Log To Console    \nDivision Result: ${result}
    Should Be Equal As Numbers    ${result}    ${5}
    ${history}=    Get calculator history

Validate Subtraction With Negatives
    [Documentation]    Test Subtracting two negative numbers
    ${result}=    Subtract Numbers   ${-5}    ${-5}
    Log To Console    \nSubtraction Result: ${result}
    Should Be Equal As Numbers    ${result}    ${0}

Validate Multiplication With Positive And Negatives
    [Documentation]    Test Multiplication of Positive And Negative numbers
    Set test message    Testing ${78} and ${-5}
    ${result}=    Multiply Numbers    ${78}    ${-5}
    Log To Console    \nMultiplication Result: ${result}
    Should Be Equal as Numbers    ${result}    ${-390}