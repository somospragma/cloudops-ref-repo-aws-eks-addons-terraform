# Sample - EKS Addons Module

Este ejemplo demuestra cómo usar el módulo EKS Addons con validación de compatibilidad con Auto Mode.

## ⚠️ IMPORTANTE: Compatibilidad con Auto Mode

Si tu cluster EKS tiene **Auto Mode habilitado**, los siguientes addons son **INCOMPATIBLES** porque AWS los gestiona automáticamente:

- ❌ `karpenter`
- ❌ `aws-load-balancer-controller`
- ❌ `aws-ebs-csi-driver`

### Addons Compatibles con Auto Mode

- ✅ `vpc-cni`
- ✅ `coredns`
- ✅ `kube-proxy`
- ✅ `aws-efs-csi-driver`
- ✅ `aws-fsx-csi-driver`
- ✅ `snapshot-controller`

## Flujo de Datos (PC-IAC-026)

```
terraform.tfvars → variables.tf → data.tf → locals.tf → main.tf → module
```

## Prerequisitos

1. **Cluster EKS** ya creado
2. **IAM Roles** para addons que requieren service account (EBS CSI, EFS CSI)

## Uso

### 1. Con Auto Mode

Editar `terraform.tfvars`:

```hcl
auto_mode_enabled = true

addons_config = {
  "main" = {
    addons = {
      "vpc-cni"    = { addon_version = "v1.18.0-eksbuild.1" }
      "coredns"    = { addon_version = "v1.11.1-eksbuild.4" }
      "kube-proxy" = { addon_version = "v1.29.0-eksbuild.1" }
      # NO incluir: aws-ebs-csi-driver, karpenter, aws-load-balancer-controller
    }
  }
}
```

### 2. Sin Auto Mode (Node Groups/Fargate)

Editar `terraform.tfvars`:

```hcl
auto_mode_enabled = false

addons_config = {
  "main" = {
    addons = {
      "vpc-cni"    = { addon_version = "v1.18.0-eksbuild.1" }
      "coredns"    = { addon_version = "v1.11.1-eksbuild.4" }
      "kube-proxy" = { addon_version = "v1.29.0-eksbuild.1" }
      "aws-ebs-csi-driver" = {
        addon_version            = "v1.28.0-eksbuild.1"
        service_account_role_arn = ""  # Se llenará automáticamente
      }
    }
  }
}
```

## Ejecución

```bash
terraform init
terraform plan
terraform apply
```

## Validación

El módulo validará automáticamente que no intentes instalar addons incompatibles con Auto Mode. Si lo haces, recibirás un error como:

```
ERROR: Los siguientes addons son incompatibles con EKS Auto Mode: aws-ebs-csi-driver, karpenter
```
