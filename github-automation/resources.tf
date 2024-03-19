resource "github_repository" "create-repo" {
  name        = "CreatedFromTerraform"
  description = "Repository created by Terraform"

  visibility = "public"
  auto_init  = true
}
