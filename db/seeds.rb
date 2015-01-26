# Creates a user for test purposes
User.new(
  name: "Fábio Beranizo Fontes Lopes", 
  email: "f104864@dac.unicamp.br", 
  password: "passwd", 
  password_confirmation: "passwd"
).save(validate: false)