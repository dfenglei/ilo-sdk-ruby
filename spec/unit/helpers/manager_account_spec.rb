require_relative './../../spec_helper'

RSpec.describe ILO_SDK::Client do
  include_context 'shared context'

  # describe '#get_power_state' do
  #   it 'makes a GET rest call' do
  #     fake_response = FakeResponse.new('PowerState' => 'On')
  #     expect(@client).to receive(:rest_get).with('/redfish/v1/Systems/1/').and_return(fake_response)
  #     power_state = @client.get_power_state
  #     expect(power_state).to eq('On')
  #   end
  # end
  #
  # describe '#set_power_state' do
  #   it 'makes a POST rest call' do
  #     new_action = { 'Action' => 'Reset', 'ResetType' => 'ForceRestart' }
  #     expect(@client).to receive(:rest_post).with('/redfish/v1/Systems/1/', body: new_action).and_return(FakeResponse.new)
  #     ret_val = @client.set_power_state('ForceRestart')
  #     expect(ret_val).to eq(true)
  #   end
  # end

  describe '#get_privileges' do
    it 'makes a GET rest call' do
      body = {
        'Items' => [
          {
            'Id' => '1',
            'Oem' => {
              'Hp' => {
                'LoginName' => 'test1',
                'Privileges' => {
                  'LoginPriv' => true,
                  'RemoteConsolePriv' => true,
                  'UserConfigPriv' => true,
                  'VirtualMediaPriv' => true,
                  'VirtualPowerAndResetPriv' => true,
                  'iLOConfigPriv' => true
                }
              }
            }
          },
          {
            'Id' => '2',
            'Oem' => {
              'Hp' => {
                'LoginName' => 'test2',
                'Privileges' => {
                  'LoginPriv' => false,
                  'RemoteConsolePriv' => false,
                  'UserConfigPriv' => false,
                  'VirtualMediaPriv' => false,
                  'VirtualPowerAndResetPriv' => false,
                  'iLOConfigPriv' => false
                }
              }
            }
          }
        ]
      }
      fake_response = FakeResponse.new(body)
      expect(@client).to receive(:rest_get).with('/redfish/v1/AccountService/').and_return(fake_response)
      privileges = @client.get_privileges('test1')
      expect(privileges).to eq(body['Items'][0]['Oem']['Hp']['Privileges'])
    end
  end

  describe '#set_privileges' do
    it 'makes a GET and a PATCH rest call' do
      body = {
        'Items' => [
          {
            'Id' => '1',
            'Oem' => {
              'Hp' => {
                'LoginName' => 'test1',
                'Privileges' => {
                  'LoginPriv' => true,
                  'RemoteConsolePriv' => true,
                  'UserConfigPriv' => true,
                  'VirtualMediaPriv' => true,
                  'VirtualPowerAndResetPriv' => true,
                  'iLOConfigPriv' => true
                }
              }
            }
          },
          {
            'Id' => '2',
            'Oem' => {
              'Hp' => {
                'LoginName' => 'test2',
                'Privileges' => {
                  'LoginPriv' => false,
                  'RemoteConsolePriv' => false,
                  'UserConfigPriv' => false,
                  'VirtualMediaPriv' => false,
                  'VirtualPowerAndResetPriv' => false,
                  'iLOConfigPriv' => false
                }
              }
            }
          }
        ]
      }
      fake_response = FakeResponse.new(body)
      expect(@client).to receive(:rest_get).with('/redfish/v1/AccountService/').and_return(fake_response)
      # username, login, remote_console, user_config, virtual_media, virtual_power_and_reset, ilo_config
      username = 'test1'
      login = false
      remote_console = false
      user_config = false
      virtual_media = false
      virtual_power_and_reset = false
      ilo_config = false
      new_action = {
        'Oem' => {
          'Hp' => {
            'Privileges' => {
              'LoginPriv' => login,
              'RemoteConsolePriv' => remote_console,
              'UserConfigPriv' => user_config,
              'VirtualMediaPriv' => virtual_media,
              'VirtualPowerAndResetPriv' => virtual_power_and_reset,
              'iLOConfigPriv' => ilo_config
            }
          }
        }
      }
      expect(@client).to receive(:rest_patch).with('/redfish/v1/AccountService/1/', body: new_action).and_return(FakeResponse.new)
      ret_val = @client.set_privileges(username, login, remote_console, user_config, virtual_media, virtual_power_and_reset, ilo_config)
      expect(ret_val).to eq(true)
    end
  end
end
