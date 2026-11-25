# Academia
Aplicativo Flutter para cadastro, listagem, edição e exclusão de alunos. Os dados ficam em memória e são perdidos ao fechar o aplicativo.

## Executar
Com Flutter e Chrome instalados, abra esta pasta no VS Code e execute:

```sh
flutter pub get
flutter run -d chrome
```

O projeto inclui a plataforma web. Para gerar outras plataformas, use `flutter create --platforms=android,windows .` se necessário.

## Testes manuais
- Cadastre Lucas / Musculação / Manhã.
- Confira a listagem e edite o turno para Noite, sem duplicar.
- Tente salvar campos vazios ou apenas espaços.
- Exclua o registro e confira a atualização.

## Publicação
Crie um repositório público vazio no GitHub e execute na pasta do projeto:

```sh
git init
git add .
git commit -m "Projeto Flutter Academia"
git branch -M main
git remote add origin https://github.com/SEU-USUARIO/academia.git
git push -u origin main
```
Substitua SEU-USUARIO pelo seu usuário. Confira o link sem autenticação antes de entregar pelo Teams.

O código não foi executado neste ambiente, pois o SDK Flutter não está instalado.
