*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***

${body_hubPRS-T551} =

...    {
...      "origem": "everaldo-hlg-teste",
...      "cep": "09520650",
...      "idUnidadeNegocio": 8,
...      "tiposEntrega": [
...       1
...          ],
  
...          "itens": [
...            {
...          "idSku": 50000534,
...          "quantidade": 1
...     }
...         ]
...            }

*** Test Cases ***
Validar o retorno da chamada na api vv-estoque-hub simulacaoDetalhada parametrizando com sku vazio
    [Tags]      cats-regionalizcao    estoque-hub    task-1869    prs-t551

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacaodetalhada   data=${body_hubPRS-T551}   headers=${header}    expected_status=200

    Status Should Be  200  ${response} 

    
    