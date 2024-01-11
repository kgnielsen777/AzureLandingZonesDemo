BeforeDiscovery {
    $path = Resolve-Path "$PSScriptRoot/../initiative-definitions"
    $definitions = Get-ChildItem -Path "$path/*.json"
}

Describe "Test-Initiative" {
    It "<PSItem.Name> name is same as file name" -ForEach $definitions {
        $template = Get-Content -Path $PSItem | ConvertFrom-Json
        $template.name | Should -BeExactly $PSItem.BaseName
    }

    It "<PSItem.Name> is an initiative definition" -ForEach $definitions {
        $template = Get-Content -Path $PSItem | ConvertFrom-Json
        $template.type | Should -Be "Microsoft.Authorization/policySetDefinitions"
    }

    It "<PSItem.Name> refers to custom initiatives by prefix" -ForEach $definitions {
        $template = Get-Content -Path $PSItem | ConvertFrom-Json

        $managementGroupIds = $template.properties.policyDefinitions.policyDefinitionId | Select-String -Pattern "^/providers/Microsoft.Management/managementGroups/(.+)/providers/Microsoft.Authorization/policyDefinitions/.+$"

        if ($managementGroupIds.Matches) {
            $managementGroupIds.Matches | ForEach-Object {
                $PSItem.Groups[1].Value | Should -Be "<prefix>"
            }
        }
    }
}
