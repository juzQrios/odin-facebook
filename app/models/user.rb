# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_and_belongs_to_many :friendships,
                          class_name: 'User',
                          join_table: :friendships,
                          foreign_key: :user_id,
                          association_foreign_key: :friend_id

  has_and_belongs_to_many :inverse_friendships,
                          class_name: 'User',
                          join_table: :friendships,
                          foreign_key: :friend_id,
                          association_foreign_key: :user_id

  def add_friend(friend_id)
    Friendship.create(user_id: id, friend_id: friend_id, status: 'requested')
    Friendship.create(user_id: friend_id, friend_id: id, status: 'pending')
  end
end
