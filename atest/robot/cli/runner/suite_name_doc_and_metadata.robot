*** Settings ***
Default Tags    regression  pybot  jybot
Resource        cli_resource.robot


*** Test Cases ***

Default Name, Doc & Metadata
    Run tests  ${EMPTY}  ${TESTFILE}
    Check Names  ${SUITE}  Normal
    Check Names  ${SUITE.tests[0]}  First One  Normal.
    Check Names  ${SUITE.tests[1]}  Second One  Normal.
    Should Be Equal  ${SUITE.doc}  Normal test cases
    Should Be Equal  ${SUITE.metadata['Something']}  My Value

Overriding Name, Doc & Metadata And Escaping
    ${bs} =  Set Variable If  __import__('os').name == 'nt'  \\  \\\\
    Run Tests  -l log.html -N this_is_overridden_next --name my_COOL_Name.EXEX. --doc Even_${bs}cooooler${bs}_docEXQU --metadata something:new --metadata Two_Parts:three_part_VALUE -M path:c:${bs}temp${bs}new.txt -M esc:STQUDOAMHAEXEX --escape star:ST -E quest:QU -E dollar:DO -E amp:AM -E hash:HA -E exclam:EX  ${TESTFILE}
    Check Names  ${SUITE}  my COOL Name.!!.
    Check Names  ${SUITE.tests[0]}  First One  my COOL Name.!!..
    Check Names  ${SUITE.tests[1]}  Second One  my COOL Name.!!..
    Should Be Equal  ${SUITE.doc}  Even \\cooooler\\ doc!?
    Should Be Equal  ${SUITE.metadata['Something']}  new
    Should Be Equal  ${SUITE.metadata['Two Parts']}  three part VALUE
    Should Be Equal  ${SUITE.metadata['path']}  c:\\temp\\new.txt
    Should Be Equal  ${SUITE.metadata['esc']}  *?$&#!!
    Check File Contains  ${OUTDIR}/log.html  Something
    Check File Does Not Contain  ${OUTDIR}/log.html  something

