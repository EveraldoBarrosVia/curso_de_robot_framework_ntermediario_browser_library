*** Settings ***

Documentation    O esperado nesse teste, é que, a api retorne apenas o sku com a quantidade permitida.

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***
${body_hubT426} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 1000004224,
...            "quantidade": 1
...        },
...    
...        {
...            "idSku": 14291174,
...            "quantidade": 99999999
...        }
...    ]
...  }
...  


*** Test Cases ***

Validar Retorno da Api para 2 Skus com quantidade excedida para 1

    [tags]      cats-regionalizcao    estoque-hub    task-1860    endpoint-simulacao    prs-t426       

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubT426}   headers=${header}    expected_status=200

    Status Should Be  200  ${response} 

    ${mensagemRetorno}=    Get Value From Json       ${response.json()}[details]    description
   