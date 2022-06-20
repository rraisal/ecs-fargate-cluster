Architectural Diagram

![alt text](https://github.com/rraisal/ecs-fargate-cluster/blob/main/diagram/planA-ecs.jpg)

Components:

- VPC CIDR : 10.0.0.0/24
- Private subnets : "10.0.0.0/28", "10.0.0.16/28", "10.0.0.32/28"
- Public Subnets: "10.0.0.48/28", "10.0.0.64/28", "10.0.0.80/28"
- Nat Gateways to access the internet from the private network.
- LoadBalancer : Application load balancer with two target groups(Since I don’t have any domain/SSL I didn't redirect 80 to 443 so currently ALB is working on http)
- - Two target groups for blue green deployment 
- AWS Farget Cluster : plan-a-cluster-prod
- CodePipeline - to enable continuous delivery pipeline
- CodeBuild - to build docker images
- CodeDeploy - for ECS deployment.
- ECR - to store docker images.
