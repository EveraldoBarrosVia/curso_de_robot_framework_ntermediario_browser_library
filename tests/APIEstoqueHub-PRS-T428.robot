*** Settings ***

Documentation    Este ciclo de teste, C65 "Validar Retorno da Api Estoque Hub - 
...              Sugestão QA", está demtro da tesk 1760 e trata-se de um retorno esperado, sujerido 
...              pela qualidade, quando parametrizado mais de um sku na mesma chamada, na api estoque hub.

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***

${body_hubPRS-T428} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 50000534,    
...            "quantidade": 1
...        },
...        {
...            "idSku": 8726179,   
...            "quantidade": 999999999
...        }
...    ]
...  }

*** Test Cases ***
Validar Retorno da Api para 2 Skus com quantidade excedida para 1
    
    [tags]      cats-regionalizcao    estoque-hub    task-1860    prs-t428

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubPRS-T428}   headers=${header}    expected_status=200

    Status Should Be  200  ${response} 

    ${mensagemRetorno0}=    Get Value From Json       ${response.json()}[details]        description
    ${mensagemRetorno1}=    Get Value From Json       ${response.json()}[details]        description


    