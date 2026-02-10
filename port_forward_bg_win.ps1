# # Stop previous port-forward background jobs
# Get-Job | Remove-Job -Force

# Write-Host "`nStarting Port-Forward for Role-Service (4101) ..."
# Start-Job -ScriptBlock {
#     kubectl port-forward deployment/role-service 4101:4101 -n petlinks-dev
# }

# Write-Host "Starting Port-Forward for Gateway (4013) ..."
# Start-Sleep -Seconds 2   # IMPORTANT DELAY

# Start-Job -ScriptBlock {
#     kubectl port-forward deployment/gateway 4013:4013 -n petlinks-dev
# }

# # Wait a few seconds to ensure startup
# Start-Sleep -Seconds 3

# Write-Host "`nChecking active ports:"
# netstat -ano | findstr ":4013"
# netstat -ano | findstr ":4101"

# Write-Host "`nPort forwarding now running in background"

# TRUNCATE TABLE
#   role_menu_permissions,
#   permissions,
#   roles,
#   menus
# RESTART IDENTITY CASCADE;

# Get-Job | Remove-Job -Force;
# Start-Job { kubectl port-forward deployment/role-service 4101:4101 -n petlinks-dev };
# Start-Job { kubectl port-forward deployment/gateway 4013:4013 -n petlinks-dev };
# netstat -ano | findstr 4101;
# netstat -ano | findstr 4013;

# docker build --no-cache -t role-service:latest .
# helm upgrade --install role-service ../services/core/thepetlink-role-service/helm/role-service -n petlinks-dev & kubectl delete pod -l app=role-service -n petlinks-dev & kubectl logs -f deployment/role-service -n petlinks-dev
# helm upgrade --install role-service ../services/core/thepetlink-role-service/helm/role-service -n petlinks-dev --create-namespace

# docker build --no-cache -t auth-service:latest .
# helm upgrade --install auth-service ../services/core/thepetlinks-auth-service/helm/auth-service -n petlinks-dev
# helm upgrade --install auth-service ../services/core/thepetlinks-auth-service/helm/auth-service -n petlinks-dev --create-namespace

# docker build --no-cache -t plan-service:latest .
# helm upgrade --install plan-service ../services/core/thepetlinks-plan-service/helm/plan-service -n petlinks-dev
# helm upgrade --install plan-service ../services/core/thepetlinks-plan-service/helm/plan-service -n petlinks-dev --create-namespace

# docker build --no-cache -t gateway:latest .
# helm upgrade --install gateway ../services/gateway/helm/gateway -n petlinks-dev & kubectl delete pod -l app=gateway -n petlinks-dev & kubectl logs -f deployment/gateway -n petlinks-dev

Get-Process kubectl -ErrorAction SilentlyContinue | Stop-Process -Force
Get-Job | Remove-Job -Force

Start-Job -Name role { kubectl port-forward deployment/role-service 4101:4101 -n petlinks-dev }
Start-Job -Name auth { kubectl port-forward deployment/auth-service 4102:4102 -n petlinks-dev }
Start-Job -Name plan { kubectl port-forward deployment/plan-service 4103:4103 -n petlinks-dev }
Start-Job -Name gateway { kubectl port-forward deployment/gateway 4013:4013 -n petlinks-dev }
Start-Job -Name pg { kubectl port-forward svc/postgresql 5432:5432 -n postgresql }

Get-Job

netstat -ano | findstr 4101;
netstat -ano | findstr 4102;
netstat -ano | findstr 4103;
netstat -ano | findstr 4013;
netstat -ano | findstr 5432;

# Get-Process kubectl -ErrorAction SilentlyContinue | Stop-Process -Force
# Get-Job | Remove-Job -Force

# Start-Job -Name role { kubectl port-forward deployment/role-service 4101:4101 -n petlinks-dev }
# Start-Job -Name pg { kubectl port-forward svc/postgresql 5432:5432 -n postgresql }

# Get-Job

# netstat -ano | findstr 4101;
# netstat -ano | findstr 5432;

# docker build --no-cache -t name-service:latest .
# terraform init --reconfigure
# terraform apply
# kubectl rollout restart deployment auth-service -n petlinks-dev
# helm uninstall gateway -n petlinks-dev

# terraform apply -target=module.docs_service.helm_release.docs_service

# curl -X PUT --upload-file ./test.png "http://minio.petlinks.local/petlinks/images/12f2afe7-63bb-40ef-9108-0ec3c19c3f2b-test.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=TCZWD75YUU2R2M1TO2PI%2F20260203%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20260203T200300Z&X-Amz-Expires=600&X-Amz-SignedHeaders=host&X-Amz-Signature=f535b96d4fb084b1908ec98a79f6ce1283d68ff050c7e354dcff6968b51ec514"
# 30d8d3e9-885d-4d0d-9064-5665afe26205

# [Unit]
# Description=Kubernetes Port Forwarding Service
# After=network.target

# [Service]
# Type=simple
# User=skpc

# ExecStart=/bin/bash -c "\
# kubectl port-forward svc/minio -n minio 9000:9000 & \
# kubectl port-forward svc/minio -n minio 9001:9001 & \
# kubectl port-forward svc/redis-master -n redis 6379:6379 & \
# kubectl port-forward deployment/docs-service -n petlinks 8080:8080 & \
# wait"

# Restart=always
# RestartSec=5

# [Install]
# WantedBy=multi-user.target


# sudo systemctl daemon-reload
# sudo systemctl restart k8s-portforward


# on error in plan constrain

# -- ALTER TABLE plan_models
# -- DROP CONSTRAINT fk_plan_models_service;

# -- CREATE INDEX idx_plan_models_service_id
# -- ON plan_models(service_id);

# kubectl delete pod kafka-0 -n kafka

# kubectl get pvc -n kafka

# kubectl delete pvc -n kafka --all

# kubectl rollout restart statefulset kafka -n kafka

# kubectl get pod kafka-0 -n kafka -o jsonpath='{.spec.containers[*].name}'

# kubectl exec -it kafka-0 -n kafka -- \
# /opt/kafka/bin/kafka-topics.sh \
# --bootstrap-server localhost:9092 \
# --list

# Ingress Restart
# kubectl apply -f k8s/ingress/petlinks-ingress.yaml
# kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx

# helm uninstall auth-service vendor-service docs-service master-service plan-service role-service gateway -n petlinks-dev
# kubectl logs -f vendor-service-86cdd4fd4f-smnrs -n petlinks-dev

# For Backfill
# kubectl exec -it master-service-567f4d469c-hxpx7 -n petlinks-dev -- sh
# kubectl exec -it plan-service-6ff69574b-27qp5 -n petlinks-dev -- ./plan-service backfill

# {
#   "name": "Sainath Kishore R G",
#   "phone": "9999999999",
#   "email": "sample@gmail.com",
#   "password": "Qwerty@123",

#   "organization": "Mr. Intelligence Inc",

#   "address": "13 Pothigai Nagar, Velampalayam",
#   "city": "Tirupur",
#   "state": "Tamil Nadu",
#   "stateCode": "32",
#   "country": "India",

#   "aadhaarNumber": "123456789123",
#   "aadhaarFile": "https://minio.petlinks.local/vendor/aadhaar/123456789123.png",
#   "gstNumber": "33ABCDE1234F1Z5",

#   "services": [
#     "1",
#     "3",
#     "5"
#   ],

#   "amount": 1721,
#   "paymentId": "pay_SCsfVtjhALeqNY",
#   "paymentStatus": "PAID"
# }
