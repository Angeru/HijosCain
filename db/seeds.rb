Member.find_or_initialize_by(user_name: "Angel").update!(
  first_name: "Angel",
  surnames: "Nieto",
  email: "angellnieto@gmail.com",
  role: "vocal",
  password: "ANRpw7188"
)

Member.find_or_initialize_by(user_name: "2").update!(
  first_name: "Angel",
  surnames: "Gonzalez Olmedo",
  email: "angel.gonzalez.olmedo@gmail.com",
  role: "secretario",
  password: "Circulointerior1*"
)
