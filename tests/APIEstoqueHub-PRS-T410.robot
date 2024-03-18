*** Settings ***

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***
${body_hubT410} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 9600909,
...            "quantidade": 1
...        },
...    
...        {
...            "idSku": 55043423,
...            "quantidade": 1
...        },
...        {
...            "idSku": 55003404,
...            "quantidade": 1
...        }
...    ]
...  }

*** Test Cases ***
Validar se a API traz a quantidade solicitada
    [tags]      cats-regionalizcao    estoque-hub   task-1853    prs-t410  

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubT410}   headers=${header}    expected_status=200

    Status Should Be  200  ${response} 

   