output "printname" {
  value = "Hello, ${var.username}. Your age is ${var.age}"
}

output "listoutput" {
  value = "First element ${var.users[var.index]}"
}

output "listoutputjoined" {
  value = "Complete array = ${join(", ", var.users)}"
}

output "usingmap" {
  value = "Avinash's age is ${lookup(var.userAge, "avinash")}"
}
