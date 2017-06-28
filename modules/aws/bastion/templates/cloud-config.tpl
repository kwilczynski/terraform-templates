#cloud-config
packages:
  - curl
  - awscli
runcmd:
  - aws ec2 associate-address --instance-id $(curl -s http://169.254.169.254/latest/meta-data/instance-id) --allocation-id ${allocation_id} --region $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's/\w$//')
output:
  all: '| tee -a /var/log/cloud-init-output.log'
