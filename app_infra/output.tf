output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.k8s.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "aks_cluster_kubernetes_version" {
  value = azurerm_kubernetes_cluster.k8s.kubernetes_version
}

resource "local_file" "kubeconfig" {
  depends_on   = [azurerm_kubernetes_cluster.k8s]
  filename     = "kubeconfig"
  content      = azurerm_kubernetes_cluster.k8s.kube_config_raw
}
