# Create Resource Group in Azure
This Module allows you to create and manage Resource Group in Microsoft Azure.

## Features
This module will:

- Create new Resource Group in Microsoft Azure.

## Usage
```hcl
module "ResourceGroup" {
  source              = "../modules/azurerm/ResourceGroup"
  location            = var.location
  resource_group_name = var.name
  rg_tags  = var.rg_tags
}

```

## Example 
Please refer Example directory to consume this module into your application.

- [main.tf](./main.tf) file calls the resource group module.
- [var.tf](./var.tf) contains declaration of terraform variables which are passed to the resource group module.
- [values.auto.tfvars](./values.auto.tfvars) contains the variable defination or actual values for respective variables which are passed to the resource group module.

## Best practices for variable declaration/defination
- All names of the Resources should be defined as per Eurofins standard naming conventions.

- While declaring variables with data type 'map(object)' or 'object; or 'list(object)', It's mandatory to define all the attributes in object. If you don't want to set any attribute then define its value as null or empty list([]) or empty map({}) as per the object data type.

- Please make sure all the Required paramaters are set. Refer below section to understand the required and optional input values when using this module.

- Please verify that the values provided to the variables are in comfort with the allowed values for that variable. Refer below section to understand the allowed values for each variable when using this module.

## Inputs
### **Required Parameters**
These variables must be set in the ```module``` block when using this module.
#### name   ```string```
    Description: The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created.    
#### location   ```string```
    Description: The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created.

### **Optional Parameters**
#### rg_additional_tags     ```map(string)```
    Description: A mapping of tags which should be assigned to the Resource Group.

    Default: {}

## Outputs
#### resource_group_name
    Description: The Name of the Resource Group.
#### resource_group_location
    Description: The Azure Region of the Resource Group.
    