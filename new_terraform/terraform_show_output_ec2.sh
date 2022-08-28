[ec2-user@ansible ec2]$ terraform  show
# aws_instance.test-terraform:
resource "aws_instance" "test-terraform" {
    ami                          = "ami-06a0b4e3b7eb7a300"
    arn                          = "arn:aws:ec2:ap-south-1:857751058578:instance/i-0d88038729026dc4a"
    associate_public_ip_address  = true
    availability_zone            = "ap-south-1a"
    cpu_core_count               = 1
    cpu_threads_per_core         = 1
    disable_api_termination      = false
    ebs_optimized                = false
    get_password_data            = false
    hibernation                  = false
    id                           = "i-0d88038729026dc4a"
    instance_state               = "running"
    instance_type                = "t2.micro"
    ipv6_address_count           = 0
    ipv6_addresses               = []
    key_name                     = "linux"
    monitoring                   = false
    primary_network_interface_id = "eni-024dc614bb1c2c449"
    private_dns                  = "ip-10-50-1-189.ap-south-1.compute.internal"
    private_ip                   = "10.50.1.189"
    public_dns                   = "ec2-13-126-177-87.ap-south-1.compute.amazonaws.com"
    public_ip                    = "13.126.177.87"
    security_groups              = []
    source_dest_check            = true
    subnet_id                    = "subnet-01ce15f2af5ef5944"
    tags                         = {
        "Name" = "terraform"
    }
    tenancy                      = "default"
    volume_tags                  = {}
    vpc_security_group_ids       = [
        "sg-04e6c7ee02cef7364",
    ]

    credit_specification {
        cpu_credits = "standard"
    }

    metadata_options {
        http_endpoint               = "enabled"
        http_put_response_hop_limit = 1
        http_tokens                 = "optional"
    }

    root_block_device {
        delete_on_termination = true
        device_name           = "/dev/sda1"
        encrypted             = false
        iops                  = 100
        volume_id             = "vol-04e0ba12bd060f977"
        volume_size           = 10
        volume_type           = "gp2"
    }
}