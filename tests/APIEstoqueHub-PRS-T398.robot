*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***

${body_hubPRS-T398} =
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
...            "quantidade": 999999999
...        },
...        {
...            "idSku": 9600909,   
...            "quantidade": 999999999
...        }
...    ]
...  }

*** Test Cases ***
Validar que quando parametrizado mais de um sku com quantidades superiores ao estoque o retorno da descrição da chamada a tratativa ocorre de maneira igual (clonado)
    
    [tags]      cats-regionalizcao    estoque-hub    task-1811    prs-t398

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubPRS-T398}   headers=${header}    expected_status=400

    Status Should Be  400  ${response} 

    ${mensagemRetorno0}=    Get Value From Json       ${response.json()}[details][0]        description
    ${mensagemRetorno1}=    Get Value From Json       ${response.json()}[details][1]        description

   
    Should Contain    ${mensagemRetorno0}[0]        Desculpe, mas só é possível comprar até
    Should contain      ${mensagemRetorno1}[0]	    Desculpe, mas só é possível comprar até

   