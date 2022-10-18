provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_linux_virtual_machine" "my_vm" {
  name                = "basic_a2"
  resource_group_name = "fake_resource_group"
  location            = "eastus"

  size           = "Basic_A2" # <<<<< Try changing this to Basic_A4 to compare the costs
  admin_username = "fakeuser"
  admin_password = "fakepass"

  network_interface_ids = [
    "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/testrg/providers/Microsoft.Network/networkInterfaces/fakenic",
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_app_service_plan" "elastic" {
  name                = "api-appserviceplan-pro"
  location            = "eastus"
  resource_group_name = "fake_resource_group"
  kind                = "elastic"
  reserved            = false

  sku {
    tier     = "Basic" 
    size     = "EP2" 
    capacity = 1
  }
}

resource "azurerm_function_app" "my_function" {
  name                       = "hello-world"
  location                   = "uksouth" # <<<<< Try changing this to EP3 to compare the costs
  resource_group_name        = "fake_resource_group"
  app_service_plan_id        = azurerm_app_service_plan.elastic.id
  storage_account_name       = "fakestorageaccountname"
  storage_account_access_key = "fake_storage_account_access_key"
}

resource "azurerm_postgresql_flexible_server" "gp" {
  name                = "example-psqlflexibleserver"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  storage_mb          = 32768

  sku_name = "GP_Standard_D4s_v3"
}
