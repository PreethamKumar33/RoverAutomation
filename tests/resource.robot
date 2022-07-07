*** Variables ***
${Browser}  Chrome
${URL}  http://35.176.154.40/search
${Upload_doc}   Lorem_ipsum.pdf
${filename_Image}   Filename.png
${Open_Image}       open.png


*** Keywords ***
Initialize all Images
    Add Image Path      ${CURDIR}${/}Sikuli_images.sikuli

Open Browser and Go to URL
    create webdriver  ${BROWSER}    executable_path=${CURDIR}${/}Driver${/}chromedriver
    GO TO  ${URL}
    Maximize Browser Window

Click open button and upload the file
    [Arguments]     ${Upload_doc}
    ${Doc_path}=    replace string  ${CURDIR}${/}Documents${/}${Upload_doc}    /   \\
    click button  xpath://body[@class='mat-typography']/app-root//app-half-sidebar-open//div[@class='layout-column mini-right-side-bar ng-star-inserted']/button[3]
    sleep  1
#    clipboard.Copy   ${Doc_path}
#    Press Keys  None    CTRL+V
    SikuliLibrary.Input Text        ${filename_Image}       ${Doc_path}
    Press Special Key       ENTER
#    Click   ${Open_Image}

Click Next Until You return to home
    sleep   3
    click button  css:.btn-section-right [color]
    click button  css:.btn-section-right [color]
    sleep   3
    click button  css:.btn-section-right [color]


Check if the file is uploaded
    [Arguments]  ${Upload_doc}
    sleep   2
    @{Title_list}=   split string  ${Upload_doc}     .
    ${Title}=   Get From List   ${Title_list}   0

    ${Total_docs}=  SeleniumLibrary.Get Text  css:.search-results-count .results-info-main

    log     ${Total_docs}

    ${total_views} =    evaluate    math.floor(${Total_docs}/10)

    log     ${total_views}

    FOR     ${i}    IN RANGE    1   ${total_views}
        ${temp}=    evaluate    ${i} * 10
        Run Keyword  Scroll Element Into View   xpath:(//a[@class='app-link'])[${temp}]
        sleep   1
    END

    click element  xpath://a[contains(text(),"${Title}")]
