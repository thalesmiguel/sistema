# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: "thales.miguel", password: "miguel")
user.add_role("admin")

estado = Estado.create(nome: "São Paulo", sigla: "SP")
cidade = Cidade.create(nome: "Araçatuba", estado: estado)

cliente = Cliente.create(nome: "Thales Miguel", cpf_cnpj: "111.111.111-11", cadastro_tipo: 0, marketing_tipos: ["Fax"], pessoa_tipo: 0)
