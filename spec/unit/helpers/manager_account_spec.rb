require_relative './../../spec_helper'

RSpec.describe ILO_SDK::Client do
  include_context 'shared context'

  describe '#get_account_privileges' do
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
      expect(@client).to receive(:rest_get).with('/redfish/v1/AccountService/Accounts/').and_return(fake_response)
      privileges = @client.get_account_privileges('test1')
      expect(privileges).to eq(body['Items'][0]['Oem']['Hp']['Privileges'])
    end
  end

  describe '#set_account_privileges' do
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
      expect(@client).to receive(:rest_get).with('/redfish/v1/AccountService/Accounts/').and_return(fake_response)
      username = 'test1'
      privileges = {
        'LoginPriv' => false,
        'RemoteConsolePriv' => false,
        'UserConfigPriv' => false,
        'VirtualMediaPriv' => false,
        'VirtualPowerAndResetPriv' => false,
        'iLOConfigPriv' => false
      }
      new_action = {
        'Oem' => {
          'Hp' => {
            'Privileges' => privileges
          }
        }
      }
      expect(@client).to receive(:rest_patch).with('/redfish/v1/AccountService/Accounts/1/', body: new_action).and_return(FakeResponse.new)
      ret_val = @client.set_account_privileges(username, privileges)
      expect(ret_val).to eq(true)
    end

    it 'makes a GET and a PATCH (only on some attributes) rest call' do
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
      expect(@client).to receive(:rest_get).with('/redfish/v1/AccountService/Accounts/').and_return(fake_response)
      username = 'test1'
      privileges = {
        'LoginPriv' => false,
        'RemoteConsolePriv' => false,
        'UserConfigPriv' => false
      }
      new_action = {
        'Oem' => {
          'Hp' => {
            'Privileges' => privileges
          }
        }
      }
      expect(@client).to receive(:rest_patch).with('/redfish/v1/AccountService/Accounts/1/', body: new_action).and_return(FakeResponse.new)
      ret_val = @client.set_account_privileges(username, privileges)
      expect(ret_val).to eq(true)
    end
  end
end
