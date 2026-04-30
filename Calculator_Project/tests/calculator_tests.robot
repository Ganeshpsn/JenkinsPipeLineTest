*** Settings ***
Library    ../resources/Calculator.py

*** Test Cases ***
Validate Addition Logic
    [Documentation]    Test adding two positive numbers
    ${result}=    Add numbers    ${10}    ${5}
    Log To Console    \nAddition Result: ${result}
    Should Be Equal As Numbers    ${result}    15

Validate Division Edge Case
    [Documentation]    Test division and verify console logging
    ${result}=    Divide Numbers    ${10}    ${2}
    Log To Console    \nDivision Result: ${result}
    Should Be Equal As Numbers    ${result}    5
    ${history}=    Get calculator history

Validate Subtraction With Negatives
    ${result}=    Subtract Numbers   ${-5}    ${-5}
    Log To Console    \nSubtraction Result: ${result}
    Should Be Equal As Numbers    ${result}    0