*** Settings ***
Documentation    this file contains the common Keywords
Library          SeleniumLibrary
Library          Collections
Library          C:/Users/14192/HelloPython/robot_test_project/resources/keywords/PdfCreate.py    WITH NAME    Pdf
Resource         C:/Users/14192/HelloPython/robot_test_project/tests/resources/variables/common_variables.resource



*** Keywords ***
Open The Login Page
    Create Webdriver    Chrome
    Go To               https://opensource-demo.orangehrmlive.com/
    Maximize Browser Window

Enter Credentials
    [Arguments]       ${username}    ${password}
    Wait Until Element Is Visible     xpath://input[@name='username']
    Input Text        xpath://input[@name='username']    ${username}
    Input Password    xpath://input[@name='password']    ${password}


Click Login Button
    Click Button    xpath://button


Verify Successful Login
    Wait Until Element Is Visible     //h6
    ${dashboard_text}=                Get Text    //h6
    Log                               ${dashboard_text}
    Element Text Should Be            //h6    ${dashboard_text}

Generate Final PDF
    [Arguments]    ${TEST_NAME}
    ${pdf_path}=    Pdf.Save PDF    ${TEST_NAME}
    Log    PDF saved at ${pdf_path}