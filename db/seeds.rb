Member.find_or_initialize_by(user_name: "Angel").update!(
  first_name: "Angel",
  surnames: "Nieto",
  email: "angellnieto@gmail.com",
  role: "vocal",
  password: "ANRpw7188"
)
