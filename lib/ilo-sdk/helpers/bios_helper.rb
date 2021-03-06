# (C) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

module ILO_SDK
  # Contains helper methods for Bios actions
  module BiosHelper
    # Get the bios base config
    # @raise [RuntimeError] if the request failed
    # @return [Fixnum] bios_baseconfig
    def get_bios_baseconfig
      response = rest_get('/redfish/v1/Systems/1/bios/Settings/')
      response_handler(response)['BaseConfig']
    end

    # Revert the BIOS
    # @raise [RuntimeError] if the request failed
    # @return true
    def revert_bios
      new_action = { 'BaseConfig' => 'default' }
      response = rest_patch('/redfish/v1/systems/1/bios/Settings/', body: new_action)
      response_handler(response)
      true
    end

    # Get the UEFI shell start up
    # @raise [RuntimeError] if the request failed
    # @return [Hash] uefi_shell_startup
    def get_uefi_shell_startup
      response = rest_get('/redfish/v1/Systems/1/bios/Settings/')
      bios = response_handler(response)
      {
        'UefiShellStartup' => bios['UefiShellStartup'],
        'UefiShellStartupLocation' => bios['UefiShellStartupLocation'],
        'UefiShellStartupUrl' => bios['UefiShellStartupUrl']
      }
    end

    # Set the UEFI shell start up
    # @param [String, Symbol] uefi_shell_startup
    # @param [String, Symbol] uefi_shell_startup_location
    # @param [String, Symbol] uefi_shell_startup_url
    # @raise [RuntimeError] if the request failed
    # @return true
    def set_uefi_shell_startup(uefi_shell_startup, uefi_shell_startup_location, uefi_shell_startup_url)
      new_action = {
        'UefiShellStartup' => uefi_shell_startup,
        'UefiShellStartupLocation' => uefi_shell_startup_location,
        'UefiShellStartupUrl' => uefi_shell_startup_url
      }
      response = rest_patch('/redfish/v1/Systems/1/bios/Settings/', body: new_action)
      response_handler(response)
      true
    end

    # Get the BIOS DHCP
    # @raise [RuntimeError] if the request failed
    # @return [String] bios_dhcp
    def get_bios_dhcp
      response = rest_get('/redfish/v1/Systems/1/bios/Settings/')
      bios = response_handler(response)
      {
        'Dhcpv4' => bios['Dhcpv4'],
        'Ipv4Address' => bios['Ipv4Address'],
        'Ipv4Gateway' => bios['Ipv4Gateway'],
        'Ipv4PrimaryDNS' => bios['Ipv4PrimaryDNS'],
        'Ipv4SecondaryDNS' => bios['Ipv4SecondaryDNS'],
        'Ipv4SubnetMask' => bios['Ipv4SubnetMask']
      }
    end

    # Set the BIOS DHCP
    # @param [String, Symbol] dhcpv4
    # @param [String, Symbol] ipv4_address
    # @param [String, Symbol] ipv4_gateway
    # @param [String, Symbol] ipv4_primary_dns
    # @param [String, Symbol] ipv4_secondary_dns
    # @param [String, Symbol] ipv4_subnet_mask
    # @raise [RuntimeError] if the request failed
    # @return true
    def set_bios_dhcp(dhcpv4, ipv4_address = '', ipv4_gateway = '', ipv4_primary_dns = '', ipv4_secondary_dns = '', ipv4_subnet_mask = '')
      new_action = {
        'Dhcpv4' => dhcpv4,
        'Ipv4Address' => ipv4_address,
        'Ipv4Gateway' => ipv4_gateway,
        'Ipv4PrimaryDNS' => ipv4_primary_dns,
        'Ipv4SecondaryDNS' => ipv4_secondary_dns,
        'Ipv4SubnetMask' => ipv4_subnet_mask
      }
      response = rest_patch('/redfish/v1/Systems/1/bios/Settings/', body: new_action)
      response_handler(response)
      true
    end

    # Get the URL boot file
    # @raise [RuntimeError] if the request failed
    # @return [String] url_boot_file
    def get_url_boot_file
      response = rest_get('/redfish/v1/Systems/1/bios/Settings/')
      response_handler(response)['UrlBootFile']
    end

    # Set the URL boot file
    # @param [String, Symbol] url_boot_file
    # @raise [RuntimeError] if the request failed
    # @return true
    def set_url_boot_file(url_boot_file)
      new_action = { 'UrlBootFile' => url_boot_file }
      response = rest_patch('/redfish/v1/Systems/1/bios/Settings/', body: new_action)
      response_handler(response)
      true
    end

    # Get the BIOS service
    # @raise [RuntimeError] if the request failed
    # @return [String] bios_service
    def get_bios_service
      response = rest_get('/redfish/v1/Systems/1/bios/Settings/')
      bios = response_handler(response)
      {
        'ServiceName' => bios['ServiceName'],
        'ServiceEmail' => bios['ServiceEmail']
      }
    end

    # Set the BIOS service
    # @param [String, Symbol] name
    # @param [String, Symbol] email
    # @raise [RuntimeError] if the request failed
    # @return true
    def set_bios_service(name, email)
      new_action = {
        'ServiceName' => name,
        'ServiceEmail' => email
      }
      response = rest_patch('/redfish/v1/Systems/1/bios/Settings/', body: new_action)
      response_handler(response)
      true
    end
  end
end
