//Criar uma constante que chama a biblioteca
const express = require("express");
//Clean Code
const app = express();
//Chamar a porta do servidor
app.listen(8080, () => {
  console.log("O servidor está ativo na porta 8080!!!");
});

//Criando a primeira rota
app.get("/", () => {
  console.log("Opa, deu certo o acesso!!!");
});
let nome = "Léo"
//Rota de envio de uma marcação
app.get("/testeHTML", (req, res) => {
  res.send("<h1>Olá Minha primeira página</h1>" + nome);
});
