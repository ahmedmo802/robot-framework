*** Settings ***
Documentation    we are going to check Employee Management functionality
Library          SeleniumLibrary
Library          C:/Users/14192/HelloPython/robot_test_project/resources/keywords/PdfCreate.py    WITH NAME    Pdf
Resource         C:/Users/14192/HelloPython/robot_test_project/resources/keywords/common.resource
Test Setup       Open The Login Page



*** Test Cases ***
Add New Employee
    common.Enter Credentials         ${valid_username}     ${valid_password}
    common.Click Login Button
    common.Verify Successful Login
    Navigate to Employee Management
    Enter Employee Information
    Save the Employee
    Verify Employee Addition
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Add New Employee.png
    Pdf.Add Step                     Add New Employee    ${SCREENSHOT_DIR}/Add New Employee.png
    common.Generate Final PDF        Add New Employee
Delete Employee
    common.Enter Credentials         ${valid_username}     ${valid_password}
    common.Click Login Button
    common.Verify Successful Login
    Navigate to Employee List
    Search for the Employee          ${employee_id}
    Select the Employee to Delete
    Delete the Employee
    Verify Employee Deletion
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Delete Employee.png
    Pdf.Add Step                     Open Example Website    ${SCREENSHOT_DIR}/Delete Employee.png
    common.Generate Final PDF        Delete Employee

Search for Employee by Id
    common.Enter Credentials        ${valid_username}     ${valid_password}
    common.Click Login Button
    common.Verify Successful Login
    Navigate to Employee List
    Search for the Employee          ${id_for_search}
    Verify Search Results
    Capture Page Screenshot          ${SCREENSHOT_DIR}/Search for Employee by Id.png
    Pdf.Add Step                     Search for Employee by Id    ${SCREENSHOT_DIR}/Search for Employee by Id.png
    common.Generate Final PDF        Search for Employee by Id



*** Keywords ***

Navigate to Employee Management
    Wait Until Element Is Visible      xpath://span[text()='PIM']
    Click Element                      xpath://span[text()='PIM']
    Wait Until Element Is Visible      xpath://a[text()='Add Employee']
    Click Element                      xpath://a[text()='Add Employee']


Enter Employee Information
    Wait Until Element Is Visible     xpath://input[@name='firstName']
    Input Text                        xpath://input[@name='firstName']     ${employee_first_name}
    Input Text                        xpath://input[@name='lastName']      ${employee_last_name}
    ${default_id}=    Get Element Attribute    xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input    value
    ${backspaces count}=    Get Length    ${default_id}
    Run Keyword If    """${default_id}""" != ''
    ...     Repeat Keyword  ${backspaces count +1}  Press Key  xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input   \\08
    Input Text                     xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input    ${employee_id}

Save the Employee
    Click Button    //button[@type='submit']

Verify Employee Addition
    Wait Until Element Is Visible    //h6[text()='Personal Details']
    Wait Until Element Is Visible     xpath://a[text()='Employee List']
    Click Element                     xpath://a[text()='Employee List']
    Wait Until Element Is Visible     xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input
    Input Text      xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input    ${employee_id}
    Click Button                      xpath://button[@type='submit']
    Wait Until Element Is Visible     xpath://div/div[text()='${employee_id}']
    Element Text Should Be            xpath://div/div[text()='${employee_id}']    ${employee_id}

Navigate to Employee List
    Wait Until Element Is Visible      xpath://span[text()='PIM']
    Click Element                      xpath://span[text()='PIM']
    Wait Until Element Is Visible     xpath://a[text()='Employee List']
    Click Element                     xpath://a[text()='Employee List']


Search for the Employee
    [Arguments]    ${id}
    Wait Until Element Is Visible     xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input
    Input Text      xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input    ${id}
    Click Button                      xpath://button[@type='submit']


Select the Employee to Delete
#    Wait Until Element Is Visible    xpath:(//input[@type='checkbox']/following-sibling::span)[2]
    Sleep    3
    Click Element                    xpath:(//input[@type='checkbox']/following-sibling::span)[2]


Delete the Employee
    Click Button                    xpath://button[text()=' Delete Selected ']
    Click Button                    xpath://button[@class='oxd-button oxd-button--medium oxd-button--label-danger orangehrm-button-margin']
    Sleep    3

Verify Employee Deletion
    Wait Until Element Is Visible     xpath://a[text()='Employee List']
    Click Element                     xpath://a[text()='Employee List']
    Wait Until Element Is Visible     xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input
    Input Text                        xpath://label[@class='oxd-label']/parent::div/following-sibling::div/input    ${employee_id}
    Sleep                             2
    Click Button                      xpath://button[text()=' Search ']
    Wait Until Element Is Visible     xpath://span[text()='No Records Found']
    Element Text Should Be            xpath://span[text()='No Records Found']    No Records Found

Verify Search Results
    Wait Until Element Is Visible     xpath://div/div[text()='${id_for_search}']
    Element Text Should Be           xpath://div/div[text()='${id_for_search}']    ${id_for_search}

