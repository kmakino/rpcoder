#!/Usr/bin/env ruby
# encoding: utf-8

require 'fileutils'
current_dir = File.dirname(__FILE__)
require current_dir + "/rpc-dsl/contract"
require current_dir + "/exporter/unity_cs_exporter"


include RpcDsl


Contract.name 'Hoge'
Contract.namespace 'foo.bar'
Contract.version 1


Contract.constant :MAX_ACCOUNT_NAME_LENGTH, 12


Contract.type 'Account' do
  field "id", :int
  field "name", :string
  field "characterIds", :int, {:array? => true}
  field "selectedCharacterId", :int

  description "アカウント情報"
end


Contract.type 'Character' do
    field "id", :int
    field "name", :string
    field "job", :int
    
    description "キャラクター情報"
end


Contract.rpc 'createAccount' do
  method :POST
  path "/account/create"

  param "name", :string, {:length => :MAX_ACCOUNT_NAME_LENGTH}

  description = "アカウント作成"
end

Contract.rpc 'removeAccount' do
    method :POST
    path "/account/remove"
    
    param "name", :string, {:length => :MAX_ACCOUNT_NAME_LENGTH}

    description = "アカウント削除"
end

Contract.rpc 'login' do
    method :POST
    path "/login"
    
    param "name", :string, {:length => :MAX_ACCOUNT_NAME_LENGTH}
    response "info", :Account
    
    description = "ログイン"
end

Contract.rpc 'createCharacter' do
    method :POST
    path "/character/create"

    param "name", :string
    param "job", :int

    description = "キャラクター作成"
end

Contract.rpc 'reomveCharacter' do
    method :POST
    path "/character/remove"
    
    param "id", :int
    
    description = "キャラクター削除"
end

Contract.rpc 'getCharacters' do
    method :GET
    path "/character"

    param "id", :int, {:require => false}
    response "infos", :Character, {:array? => true}
    
    description = "キャラクター情報取得"
end

Contract.rpc 'selectCharacter' do
    method :POST
    path "/character/select"
    
    param "id", :int
    
    description = "キャラクター選択"
end



Contract.extend UnityCSExporter
Contract.template_dir File.dirname(__FILE__) + '/templates'
Contract.unity_cs_export Contract.get_namespace_dir "generated"




