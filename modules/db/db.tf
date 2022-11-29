resource "aws_db_instance" "mysql" {
    allocated_storage = 20 #GiB
    max_allocated_storage = 220
    backup_retention_period = 7
    db_name = "mysqldb"
    db_subnet_group_name = aws_db_subnet_group.this.name
    engine = "mysql"
    instance_class = "db.t3.micro"
    multi_az = true
    identifier = "mysql-db-instance"
    username = var.db_username
    password = var.db_password
    port = 3306
    skip_final_snapshot = true
    storage_encrypted = true
    vpc_security_group_ids = var.security_group_ids
}

resource "aws_db_subnet_group" "this" {
    name = "mysql_subnet_group"
    subnet_ids = var.subnet_ids
}