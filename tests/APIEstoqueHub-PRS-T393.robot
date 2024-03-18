*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

** Variables ***

${body_hubPRS-T393} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 55006140,    #sku avulso
...            "quantidade": 1
...        },
...        {
...            "idSku": 55003404,    #sku avulso
...            "quantidade": 1
...        },
...     {
...            "idSku": 1001294420,    #sku kit
...            "quantidade": 1
...        },
...        {
...            "idSku": 1000065644,    #sku kit
...            "quantidade": 1
...        }
...    ]
...  }

*** Test Cases ***
Validar o retorno da chamada na api vv-estoque-hub quando parametrizado dois skus kits e avulsos na mesma chamada
   
    [tags]      cats-regionalizcao    estoque-hub    task-1811    prs-t393

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubPRS-T393}   headers=${header}    expected_status=200

     Status Should Be  200  ${response} 

    ${saldo-t}=	    Get Length	${response.json()}[itens][0]

    FOR    ${Ind}    IN RANGE     ${saldo-t}

    Log    ${Ind} 

    Status Should Be  200  ${response}

    END
