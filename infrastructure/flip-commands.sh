# Flip Commands:

## Blue Green Deployment(All-at-once):
###Command to flip traffic from Blue to Green Target Group
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=0 ParameterKey=GreenWeight,ParameterValue=100 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Blue

###Command to flip traffic from Green to Blue Target Group
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=100 ParameterKey=GreenWeight,ParameterValue=0 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Green

## Canary Deployment:
###Command to move 10% traffic to Green Target Group
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=90 ParameterKey=GreenWeight,ParameterValue=10 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Blue

###Command to move remaining 90% traffic to Green Target Group
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=0 ParameterKey=GreenWeight,ParameterValue=100 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Blue

###Command to move 10% traffic to Blue Target Group
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=10 ParameterKey=GreenWeight,ParameterValue=90 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Green

###Command to move remaining 90% traffic to Blue Target Group
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=100 ParameterKey=GreenWeight,ParameterValue=0 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Green

## Linear Deployment:
###Command to move 10% traffic to Green Target Group (will be used with increment of 10%)
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=90 ParameterKey=GreenWeight,ParameterValue=10 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Blue

###Exampe Next 10%
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=80 ParameterKey=GreenWeight,ParameterValue=20 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Blue

###Command to move 10% traffic to Blue Target Group (will be used with increment of 10%)
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=10 ParameterKey=GreenWeight,ParameterValue=90 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Green

###Exampe Next 10%
aws cloudformation update-stack --stack-name <ecs-extarnal-infra.yml> --use-previous-template  --parameters ParameterKey=BlueWeight,ParameterValue=20 ParameterKey=GreenWeight,ParameterValue=80 ParameterKey=Vpc,UsePreviousValue=true ParameterKey=Subnets,UsePreviousValue=true ParameterKey=TestTargetGroup,ParameterValue=Green

## Updating Primary Task set in ECS
aws ecs update-service-primary-task-set --cluster blue-green --service bg-svc-example --primary-task-set <task-set-id-green>

## Deleting blue task set
aws ecs delete-task-set --service bg-svc-example --cluster blue-green --task-set <task-set-id-blue>
