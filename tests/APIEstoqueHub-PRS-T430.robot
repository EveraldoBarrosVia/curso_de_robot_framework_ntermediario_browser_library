*** Settings ***

Documentation    Este ciclo de teste, C65 "Validar Retorno da Api Estoque Hub - 
...              Sugestão QA", está demtro da tesk 1760 e trata-se de um retorno esperado, sujerido 
...              pela qualidade, quando parametrizado mais de um sku na mesma chamada, na api estoque hub.

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***
${body_hubPRS-T430} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 55006140,    
...            "quantidade": 0
...        },
...        {
...            "idSku": 2293577,   
...            "quantidade": 0
...        }
...    ]
...  }

*** Test Cases ***
Validar a mensagem com quantidade zero para dois SKUS
    
    [tags]      cats-regionalizcao    estoque-hub    task-1860    prs-t430

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubPRS-T430}   headers=${header}    expected_status=422

    Status Should Be  422  ${response} 

    ${mensagemRetorno0}=    Get Value From Json       ${response.json()}[details][0]        description
    ${mensagemRetorno1}=    Get Value From Json       ${response.json()}[details][0]        description

   
    Should Contain    ${mensagemRetorno0}[0]        O campo quantidade deve ser maior que zero
    Should Contain    ${mensagemRetorno0}[0]        O campo quantidade deve ser maior que zero

    