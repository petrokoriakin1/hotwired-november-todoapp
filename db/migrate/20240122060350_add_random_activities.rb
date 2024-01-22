# frozen_string_literal: true

class AddRandomActivities < ActiveRecord::Migration[7.1]
  def change
    create_table 'activities', force: :cascade, id: :uuid do |t|
      t.string 'name'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'activity_memberships', force: :cascade, id: :uuid do |t|
      t.integer 'user_id', null: false
      t.integer 'activity_id', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['activity_id'], name: 'index_activity_memberships_on_activity_id'
      t.index ['user_id'], name: 'index_activity_memberships_on_user_id'
    end

    create_table 'flipper_features', force: :cascade, id: :uuid do |t|
      t.string 'key', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['key'], name: 'index_flipper_features_on_key', unique: true
    end

    create_table 'flipper_gates', force: :cascade, id: :uuid do |t|
      t.string 'feature_key', null: false
      t.string 'key', null: false
      t.string 'value'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index %w[feature_key key value], name: 'index_flipper_gates_on_feature_key_and_key_and_value',
                                         unique: true
    end

    create_table 'group_memberships', force: :cascade, id: :uuid do |t|
      t.integer 'user_id', null: false
      t.integer 'group_id', null: false
      t.boolean 'steward', default: false, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['group_id'], name: 'index_group_memberships_on_group_id'
      t.index ['user_id'], name: 'index_group_memberships_on_user_id'
    end

    create_table 'groups', force: :cascade, id: :uuid do |t|
      t.integer 'activity_id', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['activity_id'], name: 'index_groups_on_activity_id'
    end

    create_table 'messages', force: :cascade, id: :uuid do |t|
      t.text 'body'
      t.integer 'user_id', null: false
      t.string 'messageable_type', null: false
      t.integer 'messageable_id', null: false
      t.boolean 'acknowledged', default: false, null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index %w[messageable_type messageable_id], name: 'index_messages_on_messageable'
      t.index ['user_id'], name: 'index_messages_on_user_id'
    end

    create_table 'teams', force: :cascade, id: :uuid do |t|
      t.string 'name'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'timestamps', force: :cascade, id: :uuid do |t|
      t.string 'activity'
      t.string 'name'
      t.datetime 'timestamp'
      t.integer 'event'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'users', force: :cascade, id: :uuid do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.integer 'team_id', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['team_id'], name: 'index_users_on_team_id'
    end

    add_foreign_key 'activity_memberships', 'activities'
    add_foreign_key 'activity_memberships', 'users'
    add_foreign_key 'group_memberships', 'groups'
    add_foreign_key 'group_memberships', 'users'
    add_foreign_key 'groups', 'activities'
    add_foreign_key 'messages', 'users'
    add_foreign_key 'users', 'teams'
  end
end
