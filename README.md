# AppManutencao

Projeto destinado à avaliação de contratação para equipe de Sustentação - Softplan. Siga as instruções descritas aqui para corrigir o projeto e entregar as correções para o avaliador.

Versão utilizada do Delphi: Tokyo 10.2. Pode ser utilizada outras versões, desde que o código seja compatível. Testamos com o Community 10.3 e funcionou também.

## Instruções

### Correções a serem realizadas

- Resolva todos defeitos descritos na seção `Defeitos`. Obrigatório.
- **Todos** os `hints` e `warnings` do projeto devem ser resolvidos. Não esqueça de sempre rodar o build (Shift + F9), ao invés do compile (Ctrl + F9), para ver todos os hints e warnings. Obrigatório.
* Causa: [dcc32 Warning] Streams.pas(58): W1036 Variable 'SizeInc' might not have been initialized
* Solução: inicializada variável SizeInc
* Causa: [dcc32 Warning] Streams.pas(63): W1002 Symbol 'IncludeTrailingBackslash' is specific to a platform
* Solução: substituído por IncludeTrailingPathDelimiter
* Causa: [dcc32 Warning] Streams.pas(73): W1035 Return value of function 'TfStreams.LoadStream' might be undefined
* Solução: Criação do objeto para o Result
* Causa: [dcc32 Warning] Exceptions.pas(48): W1024 Combining signed and unsigned types - widened both operands
* Solução: O tipo "Integer" é impróprio para ser usado na operação, deve ser usado "Cardinal"(Integer de -2147483648 a 2147483647;Cardinal de 0 a 4294967295.
* Causa: [dcc32 Hint] Exceptions.pas(38): H2164 Variable 't2' is declared but never used in 'TfExceptions.Button1Click'
* Solução: Eliminação da variável t2
* Causa: [dcc32 Warning] Exceptions.pas(80): W1002 Symbol 'IncludeTrailingBackslash' is specific to a platform
* Solução: substituído por IncludeTrailingPathDelimiter
* Causa: [dcc32 Warning] Exceptions.pas(96): W1058 Implicit string cast with potential data loss from 'string' to 'AnsiString'
* Solução: tipo da variável "s" para string
* Causa: [dcc32 Warning] Exceptions.pas(98): W1057 Implicit string cast from 'AnsiChar' to 'string'
* Solução: tipo da variável "s" para string
* Causa: [dcc32 Warning] Exceptions.pas(99): W1057 Implicit string cast from 'AnsiChar' to 'string'
* Solução: tipo da variável "s" para string
* Causa: [dcc32 Hint] Exceptions.pas(89): H2077 Value assigned to 'TfExceptions.LoadNumbers' never used
* Solução: LoadNumbers não precisa ser uma função, pode ser uma "procedure"


- **Todos** os `memory leaks` do projeto devem ser resolvidos. Obrigatório.
- Fica aberto ao candidato se quiser refatorar algo no projeto. Opcional.

### Como submeter uma correção 

 - Corrija o projeto e nos envie por e-mail ou faça upload para núvem e nos envie o link. 
 - Envie o projeto limpo, apenas com os mesmos arquivos enviados (sem dcu, binário, etc).

## Defeitos

Corrija cada defeito descrito abaixo. Cada seção corresponde à uma tela do projeto. Para cada defeito, preencher causa e solução: 

* Causa: explicar tecnicamente qual era a causa do problema; 
* Solução: explicar tecnicamente qual foi a solução dada ao problema; 

OBS: necessitei trocar o TClientDataSet por TFDMemTable, visto a licença que possuo do Delphi Professional.

### Dataset Copy 

`Defeito 1: fazer as alterações do Dataset 1 serem replicadas automaticamente no Dataset 2`

Causa: O FDataSource2 não possuia fonte de dados.

Solução: Clonado o cursor de dados do FDataSource1 para o FDataSource2.

### Dataset Loop

`Defeito 2: corrigir rotina que apaga números pares`

Causa: Ao haver a deleção do registro o cursor do registro muda, fazendo com um registro fosse "pulado"

Solução: 
1ª - voltar para o início da estrutura de repetição
2ª - se o registro não fosse deletado, mover para o próximo

### Streams

`Defeito 3: erro de Out of Memory ao clicar no botão "Load 100"`

Causa: A função "LoadStream" que cria um "TMemoryStream" com o conteúdo de um PDF, nunca é liberado da memória.

Solução: Liberar da memória a variável que recebe "TMemoryStream" criado.

`Defeito 4: quando clica várias vezes seguidas no botão Load 100 (mais de 10 vezes), ao tentar fechar o sistema ele não fecha`

Causa: O processamento é disparado várias vezes, o que interrompe o fechamento da aplicação. A aplicação não fica "travada" durante o processamento por causa do "Application.ProcessMessages" permitindo que se clique várias vezes o botão.

Solução: a mais óbivia é desabilitar o processamento do botão até que o processo seja terminado.

### Exceptions/Performance

`Defeito 5: melhorar performance do processamento quando utilizado o botão "Operação em lote". Esperado que a operação seja concluída em menos de 10s. (Manter a ordem original do texto é um plus)`

Causa: A lentidão ocorre na apresentação dos dados à tela(adição dos dados ao Memo2)(para a inserção de uma linha, há várias mensagem do Windows que são disparadas pelo método "TMemoStrings.Insert", o que vai causando a lentidão), também há caracter inválido, no laço da string, visto que um texto válido inicia da posição 1, ao invés de 0(como está)(isto fazia a inserção de um caracter "nulo" no resultado). O erro "List index out of bounds (10000)", causado por tentar acessar um item inexistente da listagem não foi corrigido, bastando para isto substituir "for i := 0 to st.Count do" por "for i := 0 to Pred(st.Count) do".

Solução: Definição do texto do processamento ao final da execução de "forma direta".

`Defeito 6: ao clicar no botão "Operação 1" está escondendo a exceção original. Alterar para mostrar a exceção correta no Memo1`

Causa: A execução do método era cercada por um tratamento de exceção que não "propagava" a mesma exceção.

Solução: Remoção do tratamento de exceção, "estourando" a exceção original.

`Defeito 7: ao clicar em "Operação em lote" não deve parar o processamento caso dê erros na rotina. Caso apresente erros, suas classes (ClassName da exceção) e mensagens (Message da exceção) devem ser mostrados no fim do processamento, no Memo1. Exemplo: é feito um laço de 0 à 7. Caso dê erro quando i for igual a 1, deve continuar o processamento para o 2, e assim por diante.`

Causa: Não há tratamento de exceção para quando erros ocorrem no método "LoadNumbers".

Solução: Implementado tratamento de exceção (try..except), capturando a classe e a mensagem de erro da exceção.

`Defeito 8: substitua o "GetTickCount" por outra forma de "contar" o tempo de processamento`

Causa: Utilização de recurso mais moderno da linguagem.

Solução: Adoção do TStopwatch.

### Threads

`Defeito 9: crie um formulário com o nome da unit “Threads.pas” e nome do form “fThreads” e altere o form Main para abrir este novo form, como é feito nos outros botões. Neste form deve haver um botão que executará duas threads (aqui se entende thread, task, thread anônima, qualquer tipo de programação paralela). Estas threads irão realizar um laço de 0 até 100, onde a cada iteração do laço elas deverão aguardar (sleep) um tempo em milisegundos determinado pelo usuário (pode ser configurado em um TEdit). A cada iteração do laço, a thread deverá incrementar uma barra de progresso, com valor Max 200 (100 de cada thread). A mesma barra de progresso deve ser usada em ambas threads`

Causa: Há compartilhamento de mesmos recursos(barra de progresso e posição atual da barra); diante disso, é necessário fazer o incremento da posição atual "thread-safe".

Solução: Variável de controle da posição atual sendo feita através do método "TInterlocked.Increment" e necessidade de "Synchronize" na thread, visto que é um controle da UI.
