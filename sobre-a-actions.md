PASSO A PASSO PARA CRIAR UM WORKFLOW

Criar a pasta ".github";
Dentro da pasta ".github", criar a pasta "workflows"
Dentro da pasta "workflows", criar o arquivo.yml;
Dentro do arquivo "nome-do-arquivo.yml", inserir as informações abaixo:

name: GitHub Actions Demo

Esta linha define o nome do seu workflow. Ele será exibido na interface do GitHub Actions para identificar este conjunto de tarefas.

run-name: ${{ github.actor }} is testing out GitHub Actions 🚀

Esta linha define o nome do seu workflow. Ele será exibido na interface do GitHub Actions para identificar este conjunto de tarefas.

run-name: ${{ github.actor }} is testing out GitHub Actions 🚀

Esta linha especifica o nome da execução do workflow. O ${{ github.actor }} é uma variável de ambiente fornecida pelo GitHub Actions que representa o autor da ação que acionou o workflow. Esta linha adiciona uma mensagem personalizada que inclui o nome do autor.

on: 
  push:
  pull_request:
  issues:
  schedule:
    - cron: '0 0 * * *' # Executa todos os dias à meia-noite UTC

Aqui é definido quando o workflow deve ser acionado. No seu exemplo, o workflow será acionado por quatro tipos de eventos:
push: Quando um push de código é feito para o repositório.
pull_request: Quando uma pull request é aberta, reaberta ou sincronizada.
issues: Quando uma issue é aberta ou editada.
schedule: Este é um evento agendado, que dispara o workflow de acordo com um cron schedule. No caso, está configurado para executar todos os dias à meia-noite UTC.

jobs:
  Explore-GitHub-Actions-1:
    runs-on: ubuntu-latest

Aqui começamos a definir os jobs (conjuntos de tarefas) que serão executados pelo workflow. Este job tem o nome "Explore-GitHub-Actions-1" e será executado em uma máquina virtual com o sistema operacional Ubuntu, utilizando a versão mais recente disponível.

    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."

Esta linha imprime uma mensagem indicando que o job foi acionado automaticamente por um evento específico. O ${{ github.event_name }} é uma variável de ambiente que contém o nome do evento que acionou o workflow.

      - run: echo "🐧 This job is now running on a ${{ runner.os }} server hosted by GitHub!"

Aqui é impressa uma mensagem informando em qual tipo de servidor o job está sendo executado. A variável ${{ runner.os }} fornece o nome do sistema operacional do servidor.

      - run: echo "🔎 The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}."

Esta linha imprime o nome do branch e o nome do repositório onde o evento ocorreu. As variáveis ${{ github.ref }} e ${{ github.repository }} são fornecidas pelo GitHub Actions.

      - name: Check out repository code
        uses: actions/checkout@v3

Esta etapa configura o código do repositório atual dentro do ambiente de execução do job. Ela usa a ação actions/checkout@v3, que clona o repositório na branch e no commit especificados.

      - run: echo "💡 The ${{ github.repository }} repository has been cloned to the runner."

Aqui é exibida uma mensagem indicando que o repositório foi clonado com sucesso para o ambiente de execução do job.

      - run: echo "🖥️ The workflow is now ready to test your code on the runner."

Esta linha indica que o workflow está pronto para testar o código no ambiente de execução do job.

      - name: List files in the repository
        run: |
          ls ${{ github.workspace }}

Aqui é listado o conteúdo do diretório de trabalho do repositório clonado. ${{ github.workspace }} é uma variável que aponta para o diretório do repositório clonado no ambiente de execução do job.

      - run: echo "🍏 This job's status is ${{ job.status }}."

Por fim, esta linha imprime o estado atual do job, indicando se ele foi concluído com sucesso ou se ocorreu algum erro durante sua execução.

Exemplo com versão expecífica:

name: Run Web Tests
run-name: On push - Web Tests Ruan
on:
  push:
  pull_request:
  issues:
  schedule:
    - cron: '0 0 * * *' # Executa todos os dias à meia-noite UTC

jobs:
  web-tests:
    runs-on: ubuntu-20.04
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Install Python 3.10
        uses: actions/setup-python@v4
        with:
          python-version: "3.10"

      - name: Install Node.js 19.1
        uses: actions/setup-node@v3
        with:
          node-version: "19.1"

      - name: Install Requirements
        run: |
          python -m pip install --upgrade pip
          pip install -U -r requirements.txt
          sudo npm install @playwright/test
          sudo npx playwright install-deps
          rfbrowser init

      - name: Run RF Web Tests
        run: |
          robot -d ./results -v HEADLESS:true \
          -v BROWSER:chromium tests