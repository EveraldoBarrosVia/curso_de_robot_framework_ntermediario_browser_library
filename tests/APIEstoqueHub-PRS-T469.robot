*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***
${body_hubPRS-T469} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 55030833,    #sku avulso
...            "quantidade": 1
...        },
...        {
...            "idSku": 1000065644,    #sku filho qtde limite referente ao sku filho 55009647
...            "quantidade": 1
...        }
...    ]
...  }

*** Test Cases ***
Validar o retorno da chamada na api vv-estoque-hub quando parametrizado sku kit e sku avulso na mesma chamada
    
    [tags]      cats-regionalizcao    estoque-hub    task-1871    prs-t469

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubPRS-T469}   headers=${header}    expected_status=200

    Status Should Be  200  ${response} 

    
    