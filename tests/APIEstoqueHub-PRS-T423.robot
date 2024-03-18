*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***
${body_hubT423} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": x,
...            "quantidade": 1
...        }
...        
...    ]
...    
...  }

*** Test Cases ***

Validar Retorno da Api para Sku invalido

    [tags]      cats-regionalizcao    estoque-hub    task-1860    endpoint-simulacao    prs-t423        

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubT423}   headers=${header}    expected_status=400

    Status Should Be  400  ${response} 

   
    