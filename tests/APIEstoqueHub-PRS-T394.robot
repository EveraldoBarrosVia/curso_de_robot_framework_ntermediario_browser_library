*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***

${body_hubPRS-T394} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 10628785,    #sku avulso
...            "quantidade": 99984
...        },
...        {
...            "idSku": 1000004224,    #sku filho qtde limite referente ao sku filho 55009647
...            "quantidade": 99984
...        }
...    ]
...  }

*** Test Cases ***
Validar o retorno da chamada na api vv-estoque-hub quando parametrizado o limite de "quantidade" baseado no estoque dos skus filhos ou sku avulso
    
    [tags]      cats-regionalizcao    estoque-hub    task-1811    prs-t394

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubPRS-T394}   headers=${header}    expected_status=200

    Status Should Be  200  ${response} 

    
    