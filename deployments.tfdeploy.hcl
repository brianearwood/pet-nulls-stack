deployment "simple" {
  inputs = {
    instances        = 1
    aws_region     = "us-west-1"
  }
  deployment_group = deployment_group.simple
}

deployment "staging" {
  inputs = {
    instances        = 3
    aws_region     = "us-west-1"
  }
}

deployment "development" {
  inputs = {
    instances        = 4
    aws_region     = "us-west-1"
  }
}

deployment "prod" {
  inputs = {
    instances        = 3
  }
}

deployment "complex4" {
  inputs = {
    instances        = 3
  }
}

deployment_group "simple" {
  auto_approve_checks = [deployment_auto_approve.no_destroy]
}

deployment_auto_approve "no_destroy" {
  check {
    condition = context.plan.changes.remove == 0
    reason    = "Plan removes ${context.plan.changes.remove} resources."
  }
}
