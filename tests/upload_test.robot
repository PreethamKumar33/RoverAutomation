*** Settings ***
Documentation  Testing To upload Docs
Library     SeleniumLibrary
Library     SikuliLibrary   mode=NEW
Library     String
Library     Collections
Library     AllureReportLibrary
Resource    resource.robot
Test Template       Upload Documents Test
Suite Setup     Run Keywords    Start Sikuli Process    AND     Initialize all Images
Test Setup  Open Browser and Go to URL
Test Teardown  Close Browser
Suite Teardown  Stop Remote Server


*** Test Cases ***  ${Upload_doc}
DummyTest           Lorem_ipsum.pdf
#Test2               bacteria-3.pdf



*** Keywords ***
Upload Documents Test
    [Arguments]  ${upload_doc}
    Click open button and upload the file   ${upload_doc}
    Click Next Until You return to home
    Check if the file is uploaded   ${Upload_doc}