*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***
${body_hubT425} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 2293577,
...            "quantidade": 1
...        },
...    
...        {
...            "idSku": 55843423,
...            "quantidade": 0
...        }
...    ]
...  }
...  


*** Test Cases ***

Validar Retorno da Api para 2 Skus com quantidade válida outra com 0

    [tags]      cats-regionalizcao    estoque-hub    task-1860    endpoint-simulacao    prs-t425        

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubT425}   headers=${header}    expected_status=422

    Status Should Be  422  ${response} 

    ${mensagemRetorno}=    Get Value From Json       ${response.json()}[details][0]     description
   
     Should Contain      ${mensagemRetorno}[0]	O campo quantidade deve ser maior que zero