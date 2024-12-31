*** Settings ***
Documentation    we are going to check leave, Vacancy and Dashboard functionality
Library          SeleniumLibrary
Library          C:/Users/14192/HelloPython/robot_test_project/resources/keywords/PdfCreate.py    WITH NAME    Pdf
Resource         C:/Users/14192/HelloPython/robot_test_project/resources/keywords/common.resource
Test Setup       Open The Login Page





*** Test Cases ***
Job Vacancy Creation
    common.Enter Credentials         ${valid_username}     ${valid_password}
    common.Click Login Button
    common.Verify Successful Login
    Navigate to Job Vacancies
    Create a New Vacancy
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Job Vacancy Creation.png
    Pdf.Add Step                     Job Vacancy Creation    ${SCREENSHOT_DIR}/Job Vacancy Creation.png
    common.Generate Final PDF        Job Vacancy Creation
    Verify Vacancy Creation

Employee Leave Request
    common.Enter Credentials         ${valid_username}     ${valid_password}
    common.Click Login Button
    common.Verify Successful Login
    Navigate to Leave Management
    Submit a Leave Request
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Employee Leave Request.png
    Pdf.Add Step                     Employee Leave Request    ${SCREENSHOT_DIR}/Employee Leave Request.png
    common.Generate Final PDF        Employee Leave Request
    Verify Leave Request

Verify Dashboard Widgets Functionality
    common.Enter Credentials         ${valid_username}     ${valid_password}
    common.Click Login Button
    common.Verify Successful Login
    Navigate to the Dashboard
    Verify Widget Presence
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Verify Dashboard Widgets Functionality.png
    Pdf.Add Step                     Verify Dashboard Widgets Functionality    ${SCREENSHOT_DIR}/Verify Dashboard Widgets Functionality.png
    common.Generate Final PDF        Verify Dashboard Widgets Functionality


*** Keywords ***
Navigate to Job Vacancies
    Wait Until Element Is Visible      xpath://span[text()='Recruitment']
    Click Element                     xpath://span[text()='Recruitment']
    Wait Until Element Is Visible    xpath://a[text()='Vacancies']
    Click Element                   xpath://a[text()='Vacancies']


Create a New Vacancy
    Wait Until Element Is Visible        xpath://button[text()=' Add ']
    Click Button                         xpath://button[text()=' Add ']
    Wait Until Element Is Visible        xpath://h6[text()='Add Vacancy']
    Input Text                           xpath://label[text()='Vacancy Name']/parent::div/parent::div//input    ${vacancy_name}
    Click Element                        xpath://div[@class='oxd-select-text--after']
    Wait Until Element Is Visible        xpath://span[text()='Software Engineer']
    Click Element                        xpath://span[text()='Software Engineer']
    Input Text                           xpath://input[@placeholder='Type for hints...']    A
#    Wait Until Element Is Visible        xpath:(//div[@class='oxd-autocomplete-dropdown --positon-bottom']/div)[1]
    Sleep                                2
    Click Element                        xpath:(//div[@class='oxd-autocomplete-dropdown --positon-bottom']/div)[1]
    Click Button                         xpath://button[@type='submit']
    Sleep                                2



Verify Vacancy Creation
    Wait Until Element Is Visible        xpath://a[text()='Vacancies']
    Click Element                        xpath://a[text()='Vacancies']
    Wait Until Element Is Visible        xpath://div[text()='${vacancy_name}']
    ${job}=                              Get Text    xpath://div[text()='${vacancy_name}']/parent::div/following-sibling::div/div
    Log                                  ${job}

Navigate to Leave Management
    Wait Until Element Is Visible    xpath://span[text()='Leave']
    Click Element                    xpath://span[text()='Leave']
    Sleep    2
    ${exists}=    Run Keyword And Return Status    Page Should Contain Element    xpath:(//div[@class='oxd-table-row oxd-table-row--with-border'])[2]
    IF    ${exists}
        Click Element    (//input[@type='checkbox'])[2]/parent::label/span/i
        Click Button     //button[text()=' Cancel ']
        Click Button     //button[text()=' Yes, Confirm ']
    ELSE
        Log    Element not found, skipping actions.
    END
    Wait Until Element Is Visible    xpath://a[text()='Apply']
    Click Element                    xpath://a[text()='Apply']

Submit a Leave Request
    Wait Until Element Is Visible    xpath://label[text()='Leave Type']/parent::div/following-sibling::div
    Click Element                    xpath://label[text()='Leave Type']/parent::div/following-sibling::div
    Wait Until Element Is Visible    xpath://span[text()='CAN - FMLA']
    Click Element                    xpath://span[text()='CAN - FMLA']
    Click Element                    xpath:(//i[@class='oxd-icon bi-calendar oxd-date-input-icon'])[1]
    Click Element                    xpath://div[@class='oxd-calendar-date-wrapper']/div[text()='${leave_date_start}']
    Click Element                    xpath:(//i[@class='oxd-icon bi-calendar oxd-date-input-icon'])[2]
    Sleep                            500ms
    Click Element                    xpath://div[@class='oxd-calendar-date-wrapper']/div[text()='${leave_date_end}']
    Click Element                    xpath://button[@type='submit']
    Sleep                            3


Verify Leave Request
    Click Element                    xpath://a[text()='Leave List']
    Wait Until Element Is Visible    xpath://div[text()='CAN - FMLA']
    ${vacation_type}=    Get Text    xpath://div[text()='CAN - FMLA']
    Log                              ${vacation_type}


Navigate to the Dashboard
    Wait Until Element Is Visible    xpath://h6[text()='Dashboard']

Verify Widget Presence
    Element Should Be Visible        xpath://p[text()='Time at Work']
    Element Should Be Visible        xpath://p[contains(., 'Employee Distribution')]
   