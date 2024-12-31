*** Settings ***
Documentation    we are going to check login and logout functionality
Library          SeleniumLibrary
Library          C:/Users/14192/HelloPython/robot_test_project/resources/keywords/PdfCreate.py    WITH NAME    Pdf
Resource         C:/Users/14192/HelloPython/robot_test_project/resources/keywords/common.resource
Test Setup       Open The Login Page




*** Test Cases ***
Verify Login Page Elements
    Verify Login Form Elements
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Verify Login Form Elements_step1.png
    Pdf.Add Step                     Verify Login Page Elements    ${SCREENSHOT_DIR}/Verify Login Form Elements_step1.png
    common.Generate Final PDF        Verify Login Page Elements
Login with Valid Credentials
    common.Enter Credentials         ${valid_username}     ${valid_password}
    Capture Page Screenshot          ${SCREENSHOT_DIR}/valid credentials login.png
    Pdf.Add Step                     valid credentials login    ${SCREENSHOT_DIR}/valid credentials login.png
    common.Click Login Button
    common.Verify Successful Login
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Successful Login.png
    Pdf.Add Step                     Successful Login    ${SCREENSHOT_DIR}/Successful Login.png
    common.Generate Final PDF        Login with Valid Credentials
Logout Functionality
    common.Enter Credentials         ${valid_username}     ${valid_password}
    common.Click Login Button
    Click on Logout
    Verify Logout
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Click on Logout.png
    Pdf.Add Step                     Logout Functionality    ${SCREENSHOT_DIR}/Click on Logout.png
    common.Generate Final PDF        Logout Functionality


*** Keywords ***
Verify Login Form Elements
    Wait Until Element Is Visible     xpath://input[@name='username']
    Wait Until Element Is Visible     xpath://input[@name='password']
    Wait Until Element Is Visible     xpath://button
    Wait Until Element Is Visible     xpath://p[text()='Forgot your password? ']


Click on Logout
    Wait Until Element Is Visible    css:.oxd-userdropdown
    Click Element                    css:.oxd-userdropdown
    Wait Until Element Is Visible    xpath://ul[@class='oxd-dropdown-menu']/li
    @{dropdown_menu}=                Get WebElements    xpath://ul[@class='oxd-dropdown-menu']/li
    FOR    ${item}    IN    @{dropdown_menu}
        IF    '${item.text}' == 'Logout'
            Click Element    ${item}
        END
    END

Verify Logout
    Wait Until Element Is Visible    //h5[text()='Login']