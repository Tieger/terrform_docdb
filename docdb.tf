 // Create  database  DocmentDB  

resource "aws_docdb_subnet_group" "service" {
    name = "tf-${var.name}"
    subnet_ids = "${module.vpc.private_subnets}"
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 3
  identifier         = "tf-${var.name}-${count.index}"
  cluster_identifier = "${aws_docdb_cluster.service.id}"
  #instance_class     = "db.t4g.medium"
  instance_class     = "${var.docdb_instance_class}"
}

resource "aws_docdb_cluster" "service" {
  db_subnet_group_name = "${aws_docdb_subnet_group.service.name}"
  cluster_identifier = "tf-${var.name}"
  availability_zones = ["${var.region}a","${var.region}b","${var.region}c"]
  engine             = "docdb"
  master_username    = "cladmin"
  master_password    = "${var.docdb_password}"
  backup_retention_period = 5
  preferred_backup_window = "00:00-03:00"
  skip_final_snapshot     = true
  db_cluster_parameter_group_name = "${aws_docdb_cluster_parameter_group.service.name}"
  vpc_security_group_ids = ["${aws_security_group.service.id}"]
}


resource "aws_docdb_cluster_parameter_group" "service" {
  family      = "docdb4.0"
  name        = "tlsoff"
  description = "docdb cluster parameter group"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}