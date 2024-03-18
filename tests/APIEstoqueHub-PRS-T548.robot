*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***

${body_hubPRS-T547} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 1000000827,    #sku kit fornecedor
...            "quantidade": 1
...        },
...    
...        {
...            "idSku": 1000067047,    #sku kit comercial
...            "quantidade": 1
...        },
...    
...        {
...            "idSku": 55006140,    #sku avulso
...            "quantidade": 1
...        }
...        
...    ]
...  }

*** Test Cases ***

Validar o retorno da chamada na api vv-estoque-hub parametrizando sku kit fornecedor kit comercial e sku avulso na mesma chamada

    [Tags]      cats-regionalizcao    estoque-hub    task-1869    prs-t547

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubPRS-T547}   headers=${header}    expected_status=200

    Status Should Be  200  ${response} 

    
    