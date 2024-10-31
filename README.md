# Explicação basica sobre o app:

### 1. HomePage:
   - Exibe a lista de receitas em um formato de lista com cartões (`ListTile` dentro de `Card`).
   - Cada item na lista mostra o título e uma descrição curta da receita.
   - A lista é carregada dinamicamente usando um `StreamBuilder`, que escuta as alterações em tempo real do banco de dados Firestore.
   - Contém um botão para adicionar novas receitas (`FloatingActionButton`), que leva o usuário para a tela de adição de receita.
   - Cada item possui um botão de edição, que abre a tela de edição para a receita selecionada.

### 2. AddRecipePage:
   - Permite que o usuário adicione uma nova receita ao banco de dados.
   - Possui um formulário com campos para título, descrição, ingredientes e instruções da receita.
   - Ao enviar o formulário, os dados são salvos no Firestore e o usuário é levado de volta à página principal.
   - Exibe uma mensagem de sucesso ao adicionar a receita.

### 3. EditRecipePage:
   - Permite que o usuário edite os detalhes de uma receita existente.
   - Exibe um formulário pré-preenchido com os dados da receita selecionada (título, descrição, ingredientes e instruções).
   - Ao salvar, a receita é atualizada no Firestore e o usuário é redirecionado de volta para a página principal.
   - Exibe uma mensagem de sucesso ao salvar as alterações.

### 4. RecipeDetail:
   - Exibe os detalhes completos de uma receita selecionada.
   - Mostra o título, descrição, ingredientes e instruções da receita.
   - Contém um botão para excluir a receita do banco de dados, com confirmação de sucesso.
   - Após excluir, o usuário é redirecionado para a `HomePage`.


 # Cores
![image](https://github.com/user-attachments/assets/559f4554-42bb-4e4d-b22c-6728303800ec)

- ![#f0f0f0](https://placehold.co/15x15/f0f0f0/f0f0f0.png) `#f0f0f0`
- ![#d8d8d8](https://placehold.co/15x15/d8d8d8/d8d8d8.png) `#d8d8d8`
- ![#c0c0a8](https://placehold.co/15x15/c0c0a8/c0c0a8.png) `#c0c0a8`
- ![#604848](https://placehold.co/15x15/604848/604848.png) `#604848`
- ![#484848](https://placehold.co/15x15/484848/484848.png) `#484848`

# Imagens do app
![image](https://github.com/user-attachments/assets/dd54a07b-5003-447c-896a-9d46b2170266)
![image](https://github.com/user-attachments/assets/7eea9647-14ba-4268-932d-d1ff0f111021)
![image](https://github.com/user-attachments/assets/55526edb-1485-4d25-9da0-f8593f97879e)
![image](https://github.com/user-attachments/assets/f09f9c4a-4a6e-4c1f-9371-7deeecd7b68b)
