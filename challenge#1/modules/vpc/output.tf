output "vpc_id" {
  value = aws_vpc.test_vpc.id
}

output "pv_subnet_id" {
  value = aws_subnet.test_priv_subnet.id
}

output "pb_subnet_id" {
  value = aws_subnet.test_pub_subnet.id
}

output "rds_security_group_id" {
  value = aws_security_group.test_rds_sec_grp.id
}
