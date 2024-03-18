*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***
${body_hubPRS-T395} =
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
...            "idSku": 1000004224,
...            "quantidade": 1
...        }
...    ]
...  }

*** Test Cases ***
Validar o retorno da chamada na api vv-estoque-hub quando parametrizado skus kit e avulso na mesma chamada 

    [tags]      cats-regionalizcao    estoque-hub    task-1811    prs-t395

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubPRS-T395}   headers=${header}    expected_status=200

     Status Should Be  200  ${response} 

    
    FOR    ${Ind}    IN RANGE     0    3  
        ${returnSaldoTotal0}=   Get Value From Json       ${response.json()}[itens][${Ind}]     saldoTotal 
        ${returnSaldoDisponivel0}=   Get Value From Json       ${response.json()}[itens][${Ind}][entregas][0]     saldoDisponivel 

        Should Not Be Equal As Numbers      ${returnSaldoTotal0}[0]     0
        Should Not Be Equal As Numbers      ${returnSaldoDisponivel0}[0]     0
   
    
    END