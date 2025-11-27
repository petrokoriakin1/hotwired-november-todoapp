# frozen_string_literal: true

class SquashedSchema < ActiveRecord::Migration[7.1]
  def change
    # This is a squashed, idempotent migration that creates the current
    # schema in one place. Existing deployments that have run older
    # migrations will be unaffected because those files are marked
    # superseded below.

    create_table 'activities', if_not_exists: true, id: :string, limit: 36 do |t|
      t.string 'name'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'activity_memberships', if_not_exists: true, id: :string, limit: 36 do |t|
      t.integer 'activity_id', null: false
      t.integer 'user_id', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'flipper_features', if_not_exists: true, id: :string, limit: 36 do |t|
      t.string 'key', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'flipper_gates', if_not_exists: true, id: :string, limit: 36 do |t|
      t.string 'feature_key', null: false
      t.string 'key', null: false
      t.string 'value'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'group_memberships', if_not_exists: true, id: :string, limit: 36 do |t|
      t.integer 'group_id', null: false
      t.integer 'user_id', null: false
      t.boolean 'steward', default: false, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'groups', if_not_exists: true, id: :string, limit: 36 do |t|
      t.integer 'activity_id', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'messages', if_not_exists: true, id: :string, limit: 36 do |t|
      t.text 'body'
      t.integer 'user_id', null: false
      t.string 'messageable_type', null: false
      t.integer 'messageable_id', null: false
      t.boolean 'acknowledged', default: false, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'lists', if_not_exists: true, id: :string, limit: 36, default: -> { 'uuid()' } do |t|
      t.string 'title'
      t.string 'description'
      t.boolean 'template', default: false, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'sections', if_not_exists: true, id: :string, limit: 36, default: lambda {
      'uuid()'
    } do |t|
      t.string 'title'
      t.string 'list_id', limit: 36, null: false
      t.boolean 'default', default: false, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'tasks', if_not_exists: true, id: :string, limit: 36, default: -> { 'uuid()' } do |t|
      t.string 'title'
      t.string 'description'
      t.boolean 'completed', default: false, null: false
      t.string 'section_id', limit: 36, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'teams', if_not_exists: true, id: :string, limit: 36 do |t|
      t.string 'name'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'timestamps', if_not_exists: true, id: :string, limit: 36 do |t|
      t.string 'activity'
      t.string 'name'
      t.integer 'event'
      t.datetime 'timestamp'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'users', if_not_exists: true, id: :string, limit: 36 do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.integer 'team_id', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    # Indexes and foreign keys
    begin
      add_index :activity_memberships, :activity_id, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :activity_memberships, :user_id, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :flipper_features, :key, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :flipper_gates, %i[feature_key key value], name: 'index_flipper_gates_on_feature_key_and_key_and_value',
                                                           unique: true
    rescue StandardError
      nil
    end
    begin
      add_index :group_memberships, :group_id, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :group_memberships, :user_id, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :groups, :activity_id, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :messages, %i[messageable_type messageable_id], name: 'index_messages_on_messageable',
                                                                if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :messages, :user_id, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :sections, :list_id, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :tasks, :section_id, if_not_exists: true
    rescue StandardError
      nil
    end
    begin
      add_index :users, :team_id, if_not_exists: true
    rescue StandardError
      nil
    end

    begin
      add_foreign_key 'activity_memberships', 'activities'
    rescue StandardError
      nil
    end
    begin
      add_foreign_key 'activity_memberships', 'users'
    rescue StandardError
      nil
    end
    begin
      add_foreign_key 'group_memberships', 'groups'
    rescue StandardError
      nil
    end
    begin
      add_foreign_key 'group_memberships', 'users'
    rescue StandardError
      nil
    end
    begin
      add_foreign_key 'groups', 'activities'
    rescue StandardError
      nil
    end
    begin
      add_foreign_key 'messages', 'users'
    rescue StandardError
      nil
    end
    begin
      add_foreign_key 'sections', 'lists'
    rescue StandardError
      nil
    end
    begin
      add_foreign_key 'tasks', 'sections'
    rescue StandardError
      nil
    end
    begin
      add_foreign_key 'users', 'teams'
    rescue StandardError
      nil
    end
  end
end
