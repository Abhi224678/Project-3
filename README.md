
# Project 3: EC2 State Monitoring with CloudWatch Alarm

## Task 1: EC2 State Monitoring with CloudWatch Alarm

### Objective
I used Terraform to deploy an Amazon EC2 instance and configure an Amazon CloudWatch alarm to monitor its CPU utilization. The alarm is configured to enter the alarm state when average CPU utilization exceeds 70%.

### AWS Services and Tools Used
- Amazon EC2
- Amazon CloudWatch
- Terraform
- Ubuntu
- stress-ng

### Implementation
1. Configured the AWS provider to use the `ap-south-1` region.
2. Used Terraform to provision an Ubuntu EC2 instance.
3. Configured the instance to install `stress-ng` and run a CPU workload.
4. Created a CloudWatch metric alarm for the instance's `CPUUtilization` metric.
5. Set the alarm threshold to 70%, using average CPU utilization over a 5-minute period.
6. Reviewed the EC2 instance and CloudWatch alarm in the AWS Management Console.

### CloudWatch Alarm Configuration

| Setting | Value |
|---|---|
| Metric | `CPUUtilization` |
| Namespace | `AWS/EC2` |
| Statistic | Average |
| Period | 300 seconds |
| Comparison | Greater than threshold |
| Threshold | 70% |
| Evaluation periods | 1 |

### Terraform Files
- `main.tf` – AWS provider, EC2 instance, and CloudWatch alarm configuration.
- `.terraform.lock.hcl` – Provider dependency lock file.

### Deployment Commands

```bash
terraform init
terraform plan
terraform apply
```

### Verification
I reviewed the EC2 instance and CloudWatch alarm in the AWS Management Console. The alarm monitors average CPU utilization and is configured with a 70% threshold.

### Evidence
CloudWatch Screenshot added
