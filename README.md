# Linux server monitoring: Grafana + Prometheus

![metrics1](https://github.com/user-attachments/assets/3acb6f4e-8d2b-4fea-b3dd-9b7f02b4147e)

<img width="700" alt="Screenshot 2024-09-04 at 21 30 40" src="https://github.com/user-attachments/assets/58f02648-373f-498e-aeb4-2356145f5c29">

## Tech stack:
1. Cloud - AWS, Docker, terrafrom/terragrunt
2. Configuration: Ansible
3. Software: Grafana, Prometheus

## How to deploy / undeploy
1. terragrunt apply -auto-approve  --terragrunt-working-dir ./terra
2. ansible-playbook -i ansible/dynamic_inventory.py ansible/playbook.yml
3. Enjoy, http://\<grafana public ip\>:3000
5. terragrunt destroy -auto-approve --terragrunt-working-dir ./terra
