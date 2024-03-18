*** Settings ***
# Library    DatabaseLibrary

Library      SeleniumLibrary
Library      RequestsLibrary
Library      JSONLibrary
Library      Collections

*** Variables ***

${body_hubT397} =
...  {
...  "origem": "Everaldo-hlg-teste",
...    "cep": "02118010",
...    "idUnidadeNegocio": 8,
...    "tiposEntrega": [
...        1
...    ],
...    "itens": [
...        {
...            "idSku": 1000065644,
...            "quantidade": x
...        },
...     {
...            "idSku": 1001294420,
...            "quantidade": x
...        },
...     {
...            "idSku": 55003404,
...            "quantidade": x
...        },
...     {
...            "idSku": 55006140,
...            "quantidade": x
...        }
...    ]
...    
...  }

*** Test Cases ***
Validar que quando parametrizado mais de um sku com quantidades inválidas ao estoque o retorno da descrição da chamada a tratativa ocorre de maneira igual (clonado)
    [tags]      cats-regionalizcao    estoque-hub    task-1811    prs-t397        

    Create Session  mysession  http://vv-estoque-hub-api-hlg.via.com.br  verify=true
    
    &{header}=  Create Dictionary    Content-Type=application/json    accept=application/json    Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.HEAFzxWNRFJeyY7PCPzhqtB0UX68R6__sfrxQccRaFs

    ${response}=  POST On Session  mysession  /v1/simulacao   data=${body_hubT397}   headers=${header}    expected_status=400

    Status Should Be  400  ${response} 

   
    