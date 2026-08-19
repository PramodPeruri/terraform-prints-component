locals {
   ami_id = data.aws_ami.joindevops.id
   common_name_suffix = "${var.project_name}-${var.environment}"
   catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
   vpc_id = data.aws_ssm_parameter.vpc_id.value
   private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
   private_subnet_ids = split("," , data.aws_ssm_parameter.private_subnet_ids.value)
   backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
   frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value
   listener_arn = "${var.components}" == "frontend" ? local.frontend_alb_listener_arn : local.backend_alb_listener_arn
   sg_id = data.aws_ssm_parameter.sg_id.value
   tg_port = "${var.components}" == "frontend" ? 80 : 8080 
   health_check_path = "${var.components}" == "frontend" ? "/" : "/health"
   host_context = "${var.components}" == "frontend" ? "${var.project_name}-${var.environment}.${var.domain_name}" : "${var.components}.backend-alb-${var.environment}.${var.domain_name}"
   common_tags = {
       Project = var.project_name
       Environment = var.environment
       Terraform = "True"
   }
}