#!/Usr/bin/env ruby
# encoding: utf-8

require 'fileutils'
require './lib/rpc-dsl/contract'
require './lib/exporter/unity_cs_exporter'


include RpcDsl


contract = Contract.new("Hoge") do
  @template_dir = File.dirname(__FILE__) + '/templates'
  @output_dir = "generated"
  @namespace = "foo.bar"

  @version = 1

  constants << Constant.new(:MAX_ACCOUNT_NAME_LENGTH, 12)

  types << Type.new("Account") do
    field "id", :int
    field "name", :string
    field "character_id", :int, {:array? => true}
  end

  functions << Function.new("createAccount") do
    @path = "/account/create"
    @method = :POST
    add_param "name", :string, {:length => :MAX_ACCOUNT_NAME_LENGTH}
    description = "アカウント作成"
  end

  functions << Function.new("removeAccount") do
    @path = "/account"
    @method = :POST
    add_param "name", :string
    description = "アカウント削除"
  end

  functions << Function.new("login") do
    @path = "/mails"
    @method = :POST
    add_param "name", :string
    add_response_param "account", :Account
    description = "ログイン"
  end


  def export
    extend UnityCSExporter

    dir = File.join(@output_dir, namespace.split('.'))
    FileUtils.mkdir_p(dir)
    
    # generate c# codes
    unity_cs_export(dir)
  end
end

contract.export

